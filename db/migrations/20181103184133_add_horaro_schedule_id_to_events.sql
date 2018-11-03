-- +migrate up
ALTER TABLE "public"."ev_events"
  ADD COLUMN "horaro_schedule_id" text;

-- +migrate down
ALTER TABLE "public"."ev_events"
  DROP COLUMN "horaro_schedule_id";
