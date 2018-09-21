-- +migrate up
ALTER TABLE "public"."ev_submissions"
  DROP COLUMN "estimate_ms",
  DROP COLUMN "pb_ms",
  ADD COLUMN "estimate" text,
  ADD COLUMN "pb" text;

-- +migrate down
ALTER TABLE "public"."ev_submissions"
  ADD COLUMN "estimate_ms" integer,
  ADD COLUMN "pb_ms" integer,
  DROP COLUMN "estimate",
  DROP COLUMN "pb";
