-- +migrate up
ALTER TABLE "public"."ev_events"
  ADD COLUMN "subdomain" text;

CREATE UNIQUE INDEX "ev_events_subdomain_index" ON "public"."ev_events"("subdomain");


-- +migrate down
ALTER TABLE "public"."ev_events"
  DROP COLUMN "subdomain";
