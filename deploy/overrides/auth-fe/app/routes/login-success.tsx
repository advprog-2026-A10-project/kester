import { Link } from "react-router";
import { AuthCard } from "~/modules/auth/presentation/components/auth-card";
import { Button } from "~/shared/components/ui/button";

export default function LoginSuccessRoute() {
  return (
    <AuthCard title="Login successful" description="Your BidMart account is authenticated.">
      <div className="space-y-4 text-sm text-muted-foreground">
        <p>You can continue once the main marketplace pages are available in this alpha build.</p>
        <Button asChild className="w-full">
          <Link to="/login">Back to sign in</Link>
        </Button>
      </div>
    </AuthCard>
  );
}
