import { AuthCard } from "../components/auth-card";
import { LoginForm } from "../components/login-form";
import { useLoginMutation } from "../hooks/use-login-mutation";
import type { LoginFormValues } from "../components/login-form";

const DEFAULT_REDIRECT_URL = "https://bidmart.bid";

export function LoginPage() {
  const login = useLoginMutation();

  function handleSubmit(values: LoginFormValues) {
    login.mutate(
      { email: values.email, password: values.password },
      {
        onSuccess: () => {
          window.location.assign(import.meta.env.VITE_REDIRECT_URL || DEFAULT_REDIRECT_URL);
        },
      },
    );
  }

  return (
    <AuthCard title="Sign in" description="Enter your credentials to access your account.">
      <LoginForm onSubmit={handleSubmit} isSubmitting={login.isPending} />
    </AuthCard>
  );
}
