use std::sync::Arc;

use chrono::{Duration, Utc};
use jsonwebtoken::{encode, EncodingKey, Header};
use serde::Serialize;

use crate::modules::auth::application::dto::{LoginResponseDto, LoginUserCommand, PublicUserDto};
use crate::modules::auth::domain::errors::AuthError;
use crate::modules::auth::domain::traits::{PasswordHasher, UserRepository};

pub struct LoginUserUseCase {
    user_repository: Arc<dyn UserRepository>,
    password_hasher: Arc<dyn PasswordHasher>,
    jwt_secret: String,
    access_token_ttl: Duration,
}

impl LoginUserUseCase {
    pub fn new(
        user_repository: Arc<dyn UserRepository>,
        password_hasher: Arc<dyn PasswordHasher>,
        jwt_secret: String,
        access_token_ttl: Duration,
    ) -> Self {
        Self {
            user_repository,
            password_hasher,
            jwt_secret,
            access_token_ttl,
        }
    }

    pub async fn execute(&self, command: LoginUserCommand) -> Result<LoginResponseDto, AuthError> {
        let normalized_email = command.email.trim().to_lowercase();
        let user = self
            .user_repository
            .find_by_email(&normalized_email)
            .await?
            .ok_or(AuthError::InvalidCredentials)?;

        let password_matches = self
            .password_hasher
            .verify(&command.password, &user.password_hash)?;

        if !password_matches {
            return Err(AuthError::InvalidCredentials);
        }

        if !user.is_email_verified() {
            return Err(AuthError::EmailNotVerified);
        }

        let public_user = PublicUserDto {
            id: user.id,
            name: user.display_name(),
            email: user.email.clone(),
            email_verified: user.is_email_verified(),
        };
        let exp = Utc::now() + self.access_token_ttl;
        let claims = AccessTokenClaims {
            sub: user.id.to_string(),
            email: user.email,
            name: public_user.name.clone(),
            email_verified: public_user.email_verified,
            exp: exp.timestamp() as usize,
        };
        let token = encode(
            &Header::default(),
            &claims,
            &EncodingKey::from_secret(self.jwt_secret.as_bytes()),
        )
        .map_err(|_| AuthError::DependencyFailure("failed to create access token".to_string()))?;

        Ok(LoginResponseDto::new(public_user, token))
    }
}

#[derive(Debug, Serialize)]
struct AccessTokenClaims {
    sub: String,
    email: String,
    name: String,
    email_verified: bool,
    exp: usize,
}
