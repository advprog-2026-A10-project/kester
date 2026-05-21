import { Link } from "react-router";
import { AuthCard } from "~/modules/auth/presentation/components/auth-card";
import { Button } from "~/shared/components/ui/button";

export default function LoginSuccessRoute() {
  return (
    <AuthCard title="Login successful" description="Your BidMart account is authenticated.">
      <div className="space-y-4 text-sm text-muted-foreground">
        <p>You are signed in for the alpha auth flow. Continue to the integrated service hub.</p>
        <Button asChild className="w-full">
          <a href="https://bidmart.bid">Open BidMart hub</a>
        </Button>
        <Button asChild variant="outline" className="w-full">
          <Link to="/login">Back to sign in</Link>
        </Button>
      </div>
    </AuthCard>
  );
}
