-- +migrate up
ALTER TABLE "public"."ev_submissions"
  ADD COLUMN "estimate_ms" integer,
  ADD COLUMN "pb_ms" integer,
  ADD COLUMN "description" text,
  ADD COLUMN "video_link" text,
  ADD COLUMN "submitted_at" timestamp without time zone,
  ADD COLUMN "status" text,
  ADD COLUMN "category_id" integer,
  ADD COLUMN "game_id" integer,
  ADD CONSTRAINT ev_sub_runs_category_id_fkey FOREIGN KEY ("category_id") REFERENCES "public"."inv_categories"("id"),
  ADD CONSTRAINT ev_sub_runs_game_id_fkey FOREIGN KEY ("game_id") REFERENCES "public"."inv_games"("id");

DROP TABLE "public"."ev_sub_runs";
DROP TABLE "public"."ev_sub_options";


-- +migrate down
ALTER TABLE "public"."ev_submissions"
  DROP COLUMN "estimate_ms",
  DROP COLUMN "pb_ms",
  DROP COLUMN "description",
  DROP COLUMN "video_link",
  DROP COLUMN "category_id",
  DROP COLUMN "game_id",
  DROP COLUMN "submitted_at",
  DROP COLUMN "status";

CREATE TABLE IF NOT EXISTS "public"."ev_sub_runs" (
  "id" serial,
  "created_at" timestamp without time zone,
  "updated_at" timestamp without time zone,
  "estimate_ms" integer,
  "pb_ms" integer,
  "submitted_at" timestamp without time zone,
  "status" text,
  "submission_id" integer,
  "category_id" integer,
  "game_id" integer,
  FOREIGN KEY ("submission_id") REFERENCES "public"."ev_submissions"("id"),
  FOREIGN KEY ("category_id") REFERENCES "public"."inv_categories"("id"),
  FOREIGN KEY ("game_id") REFERENCES "public"."inv_games"("id"),
  PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "public"."ev_sub_options" (
  "id" serial,
  "created_at" timestamp without time zone,
  "updated_at" timestamp without time zone,
  "name" text,
  "type" text,
  "string" text,
  "int" integer,
  "float" decimal,
  "boolean" boolean,
  "submission_id" integer,
  FOREIGN KEY ("submission_id") REFERENCES "public"."ev_submissions"("id"),
  PRIMARY KEY ("id")
);
