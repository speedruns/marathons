-- +migrate up
ALTER TABLE "public"."ev_sub_runs"
  ADD COLUMN "description" text,
  ADD COLUMN "video_link" text;

-- +migrate down
ALTER TABLE "public"."ev_sub_runs"
  DROP COLUMN "description",
  DROP COLUMN "video_link";
