-- +migrate up
CREATE TABLE IF NOT EXISTS "public"."acc_sessions" (
  "id" serial,
  "key" text,
  "created_at" timestamp without time zone,
  "updated_at" timestamp without time zone,
  "user_id" integer,
  "valid" boolean DEFAULT false,
  FOREIGN KEY ("user_id") REFERENCES "public"."acc_users"("id"),
  PRIMARY KEY ("id")
);

-- +migrate down
DROP TABLE "public"."acc_sessions";
