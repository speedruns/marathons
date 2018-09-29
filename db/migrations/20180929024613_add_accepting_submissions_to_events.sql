-- +migrate up
ALTER TABLE "public"."ev_events"
  ADD COLUMN "state" text DEFAULT 'draft';

-- +migrate down
ALTER TABLE "public"."ev_events"
  DROP COLUMN "state";
