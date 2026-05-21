import { redirect, type LoaderFunctionArgs } from "react-router";

export async function loader({ request }: LoaderFunctionArgs) {
  const url = new URL(request.url);
  return redirect(`https://auth.bidmart.bid/verify-email${url.search}`);
}

export default function VerifyEmailRedirectRoute() {
  return null;
}
