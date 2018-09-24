-- +migrate up
ALTER TABLE "public"."ev_submissions"
  ADD COLUMN "game_name" text,
  ADD COLUMN "category_name" text;

-- +migrate down
ALTER TABLE "public"."ev_submissions"
  DROP COLUMN "game_name",
  DROP COLUMN "category_name";
