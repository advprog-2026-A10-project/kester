use axum::{routing::get, Json, Router};
use serde_json::{json, Value};
use sqlx::postgres::PgPool;

pub mod controllers;
pub mod middleware;
pub mod repositories;
pub mod services;

#[derive(Clone)]
pub struct AppState {
    pub _pool: PgPool,
}

pub fn create_router(state: AppState) -> Router {
    Router::new()
        .route("/health", get(health_check))
        .route("/ready", get(ready_check))
        .route("/alpha/services", get(alpha_services))
        .with_state(state)
}

async fn health_check() -> Json<Value> {
    Json(json!({"status": "ok", "service": "bidmart-core-be"}))
}

async fn ready_check() -> Json<Value> {
    Json(json!({"ready": true}))
}

async fn alpha_services() -> Json<Value> {
    Json(json!({
        "service": "bidmart-core-be",
        "mode": "alpha",
        "integrations": {
            "authApi": "http://auth-be:8080",
            "database": "postgres",
            "biddingWs": "ws://bidding-ws:8080"
        },
        "notes": [
            "Core business routes are still minimal in the current source package.",
            "This endpoint exists so the alpha Docker stack exposes a reachable core API surface."
        ]
    }))
}
