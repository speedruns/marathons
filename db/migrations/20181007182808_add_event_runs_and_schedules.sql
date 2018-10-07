-- +migrate up
CREATE TABLE IF NOT EXISTS "public"."ev_runs" (
  "id" serial,
  "event_id" integer,
  "runner_id" integer,
  "submission_id" integer,
  "video_link" text,
  "estimate" text,
  "pb" text,
  "time" text,
  "game_id" integer,
  "category_id" integer,
  "created_at" timestamp without time zone,
  "updated_at" timestamp without time zone,
  FOREIGN KEY ("event_id") REFERENCES "public"."ev_events"("id"),
  FOREIGN KEY ("runner_id") REFERENCES "public"."acc_users"("id"),
  FOREIGN KEY ("submission_id") REFERENCES "public"."ev_submissions"("id"),
  FOREIGN KEY ("game_id") REFERENCES "public"."inv_games"("id"),
  FOREIGN KEY ("category_id") REFERENCES "public"."inv_categories"("id"),
  PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "public"."ev_schedules" (
  "id" serial,
  "event_id" integer,
  "run_id" integer,
  "title" text,
  "start_time" timestamp without time zone,
  "end_time" timestamp without time zone,
  FOREIGN KEY ("event_id") REFERENCES "public"."ev_events"("id"),
  FOREIGN KEY ("run_id") REFERENCES "public"."ev_runs"("id"),
  PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "public"."ev_schedulings" (
  "schedule_id" integer,
  "run_id" integer,
  "start_time" timestamp without time zone,
  "end_time" timestamp without time zone,
  "completed" boolean DEFAULT false,
  FOREIGN KEY ("schedule_id") REFERENCES "public"."ev_schedules"("id"),
  FOREIGN KEY ("run_id") REFERENCES "public"."ev_runs"("id")
);



-- +migrate down
DROP TABLE IF EXISTS "public"."ev_schedulings";
DROP TABLE IF EXISTS "public"."ev_schedules";
DROP TABLE IF EXISTS "public"."ev_runs";
