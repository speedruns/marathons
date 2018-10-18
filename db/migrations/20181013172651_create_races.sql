-- +migrate up
CREATE TABLE IF NOT EXISTS "public"."ev_races" (
  "id" serial,
  "event_id" integer,
  "game_id" integer,
  "category_id" integer,
  "description" text,
  "video_link" text,
  "estimate" integer,
  "created_at" timestamp without time zone,
  "updated_at" timestamp without time zone,
  FOREIGN KEY ("event_id") REFERENCES "public"."ev_events"("id"),
  FOREIGN KEY ("game_id") REFERENCES "public"."inv_games"("id"),
  FOREIGN KEY ("category_id") REFERENCES "public"."inv_categories"("id"),
  PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "public"."ev_race_runs" (
  "id" serial,
  "race_id" integer,
  "run_id" integer,
  FOREIGN KEY ("race_id") REFERENCES "public"."ev_races"("id"),
  FOREIGN KEY ("run_id") REFERENCES "public"."ev_runs"("id"),
  PRIMARY KEY ("id")
);

ALTER TABLE "public"."ev_schedules"
  DROP COLUMN "run_id";

ALTER TABLE "public"."ev_schedulings"
  ADD COLUMN "race_id" integer,
  ADD CONSTRAINT ev_schedulings_race_id FOREIGN KEY ("race_id") REFERENCES "public"."ev_races"("id");


-- +migrate down
ALTER TABLE "public"."ev_schedulings"
  DROP COLUMN "race_id";

ALTER TABLE "public"."ev_schedules"
  ADD COLUMN "run_id" integer,
  ADD CONSTRAINT ev_schedules_run_id FOREIGN KEY ("run_id") REFERENCES "public"."ev_runs"("id");

DROP TABLE IF EXISTS "public"."ev_race_runs";
DROP TABLE IF EXISTS "public"."ev_races";
