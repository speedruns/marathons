-- +migrate up
CREATE TABLE IF NOT EXISTS "public"."acc_users" (
  "id" serial,
  "created_at" timestamp without time zone,
  "updated_at" timestamp without time zone,
  "name" text,
  "encrypted_password" text,
  "discord" text,
  "twitch" text,
  "twitter" text,
  "timezone" text,
  "admin" boolean DEFAULT 'false',
  "avatar_object_id" text,
  PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "public"."acc_organizations" (
  "id" serial,
  "created_at" timestamp without time zone,
  "updated_at" timestamp without time zone,
  "name" text,
  "owner_id" integer,
  FOREIGN KEY ("owner_id") REFERENCES "public"."acc_users"("id"),
  PRIMARY KEY ("id")
);



CREATE TABLE IF NOT EXISTS "public"."inv_series" (
  "id" serial,
  "created_at" timestamp without time zone,
  "updated_at" timestamp without time zone,
  "name" text,
  PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "public"."inv_games" (
  "id" serial,
  "created_at" timestamp without time zone,
  "updated_at" timestamp without time zone,
  "name" text,
  "series_number" text,
  "twitch_id" text,
  "series_id" integer,
  FOREIGN KEY ("series_id") REFERENCES "public"."inv_series"("id"),
  PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "public"."inv_categories" (
  "id" serial,
  "created_at" timestamp without time zone,
  "updated_at" timestamp without time zone,
  "name" text,
  "rules" text,
  "game_id" integer,
  FOREIGN KEY ("game_id") REFERENCES "public"."inv_games"("id"),
  PRIMARY KEY ("id")
);



CREATE TABLE IF NOT EXISTS "public"."ev_events" (
  "id" serial,
  "created_at" timestamp without time zone,
  "updated_at" timestamp without time zone,
  "name" text,
  "start_date" timestamp without time zone,
  "end_date" timestamp without time zone,
  "organization_id" integer,
  FOREIGN KEY ("organization_id") REFERENCES "public"."acc_organizations"("id"),
  PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "public"."ev_submissions" (
  "id" serial,
  "created_at" timestamp without time zone,
  "updated_at" timestamp without time zone,
  "event_id" integer,
  "account_id" integer,
  FOREIGN KEY ("event_id") REFERENCES "public"."ev_events"("id"),
  FOREIGN KEY ("account_id") REFERENCES "public"."acc_users"("id"),
  PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "public"."ev_sub_runs" (
  "id" serial,
  "created_at" timestamp without time zone,
  "updated_at" timestamp without time zone,
  "estimate_ms" integer,
  "pb_ms" integer,
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


-- +migrate down
DROP TABLE "public"."ev_sub_options";
DROP TABLE "public"."ev_sub_runs";
DROP TABLE "public"."ev_submissions";
DROP TABLE "public"."ev_events";
DROP TABLE "public"."inv_categories";
DROP TABLE "public"."inv_games";
DROP TABLE "public"."inv_series";
DROP TABLE "public"."acc_organizations";
DROP TABLE "public"."acc_users";
