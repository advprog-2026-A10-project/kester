import { redirect } from "react-router";

export async function loader() {
  return redirect("https://auth.bidmart.bid/register");
}

export default function RegisterRedirectRoute() {
  return null;
}
