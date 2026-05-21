export default function AdminAlphaHomeRoute() {
  return (
    <main className="min-h-screen bg-background text-foreground">
      <section className="mx-auto flex w-full max-w-4xl flex-col gap-6 px-6 py-10">
        <div>
          <p className="text-sm font-medium text-muted-foreground">BidMart admin alpha</p>
          <h1 className="text-3xl font-semibold tracking-normal">Admin service is online</h1>
          <p className="mt-3 text-sm leading-6 text-muted-foreground">
            The admin frontend, admin API, auth database, and core database are wired into the
            Docker stack. Full admin screens depend on the upstream admin module routes.
          </p>
        </div>
        <div className="flex flex-wrap gap-2">
          <a
            className="inline-flex h-9 items-center rounded-md bg-primary px-3 text-sm font-medium text-primary-foreground hover:bg-primary/90"
            href="https://admin-api.bidmart.bid/health"
          >
            Admin API health
          </a>
          <a
            className="inline-flex h-9 items-center rounded-md border px-3 text-sm font-medium hover:bg-accent"
            href="https://bidmart.bid"
          >
            Main hub
          </a>
        </div>
      </section>
    </main>
  );
}
