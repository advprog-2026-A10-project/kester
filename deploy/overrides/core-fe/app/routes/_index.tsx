const services = [
  {
    name: "Auth",
    description: "Registration, verification, login, and email flows.",
    appUrl: "https://auth.bidmart.bid",
    apiUrl: "https://api.auth.bidmart.bid/health",
  },
  {
    name: "Marketplace Core",
    description: "Core API container and main marketplace frontend.",
    appUrl: "https://bidmart.bid",
    apiUrl: "https://api.bidmart.bid/health",
  },
  {
    name: "Admin",
    description: "Admin frontend and admin API container.",
    appUrl: "https://admin.bidmart.bid",
    apiUrl: "https://admin-api.bidmart.bid/health",
  },
  {
    name: "Realtime Bidding",
    description: "WebSocket gateway for auction updates.",
    appUrl: "https://ws.bidmart.bid",
    apiUrl: "https://ws.bidmart.bid",
  },
];

export default function AlphaHomeRoute() {
  return (
    <main className="min-h-screen bg-background text-foreground">
      <section className="mx-auto flex w-full max-w-6xl flex-col gap-8 px-6 py-10">
        <div className="flex flex-col gap-3">
          <p className="text-sm font-medium text-muted-foreground">BidMart alpha deployment</p>
          <h1 className="text-3xl font-semibold tracking-normal">Integrated service hub</h1>
          <p className="max-w-3xl text-sm leading-6 text-muted-foreground">
            This page is a deployment-level shell that brings the current auth, core, admin,
            database, and realtime packages together on one VM. Some product UI is still placeholder
            until the upstream service modules expose their full routes.
          </p>
        </div>

        <div className="grid gap-4 md:grid-cols-2">
          {services.map((service) => (
            <section key={service.name} className="rounded-md border bg-card p-5 shadow-sm">
              <div className="flex flex-col gap-2">
                <h2 className="text-lg font-semibold">{service.name}</h2>
                <p className="min-h-10 text-sm text-muted-foreground">{service.description}</p>
                <div className="mt-3 flex flex-wrap gap-2">
                  <a
                    className="inline-flex h-9 items-center rounded-md bg-primary px-3 text-sm font-medium text-primary-foreground hover:bg-primary/90"
                    href={service.appUrl}
                  >
                    Open
                  </a>
                  <a
                    className="inline-flex h-9 items-center rounded-md border px-3 text-sm font-medium hover:bg-accent"
                    href={service.apiUrl}
                  >
                    Health
                  </a>
                </div>
              </div>
            </section>
          ))}
        </div>

        <section className="rounded-md border bg-card p-5">
          <h2 className="text-lg font-semibold">Demo flow</h2>
          <div className="mt-3 flex flex-wrap gap-2">
            <a
              className="inline-flex h-9 items-center rounded-md bg-primary px-3 text-sm font-medium text-primary-foreground hover:bg-primary/90"
              href="https://auth.bidmart.bid/register"
            >
              Register
            </a>
            <a
              className="inline-flex h-9 items-center rounded-md border px-3 text-sm font-medium hover:bg-accent"
              href="https://auth.bidmart.bid/login"
            >
              Login
            </a>
            <a
              className="inline-flex h-9 items-center rounded-md border px-3 text-sm font-medium hover:bg-accent"
              href="https://admin.bidmart.bid"
            >
              Admin
            </a>
          </div>
        </section>
      </section>
    </main>
  );
}
