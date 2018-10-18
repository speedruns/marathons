-- +migrate up
ALTER TABLE "public"."ev_runs"
  ADD COLUMN "status" text DEFAULT 'pending';

-- +migrate down
ALTER TABLE "public"."ev_runs"
  DROP COLUMN "status";
