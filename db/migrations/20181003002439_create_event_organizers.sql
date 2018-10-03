-- +migrate up
CREATE TABLE IF NOT EXISTS "public"."ev_organizers" (
  "id" serial,
  "event_id" integer,
  "user_id" integer,
  "created_at" timestamp without time zone,
  "updated_at" timestamp without time zone,
  FOREIGN KEY ("event_id") REFERENCES "public"."ev_events"("id"),
  FOREIGN KEY ("user_id") REFERENCES "public"."acc_users"("id"),
  PRIMARY KEY ("id")
);

-- +migrate down
DROP TABLE IF EXISTS "public"."ev_organizers";
