-- +migrate up
ALTER TABLE "public"."ev_sub_runs"
  ADD COLUMN "submitted_at" timestamp without time zone,
  ADD COLUMN "status" text;

-- +migrate down
ALTER TABLE "public"."ev_sub_runs"
  DROP COLUMN "submitted_at",
  DROP COLUMN "status";
