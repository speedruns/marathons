-- +migrate up
ALTER TABLE "public"."ev_events"
  ADD COLUMN "description" text;

-- +migrate down
ALTER TABLE "public"."ev_events"
  DROP COLUMN "description";
