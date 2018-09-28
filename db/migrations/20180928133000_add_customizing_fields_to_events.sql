-- +migrate up
ALTER TABLE "public"."ev_events"
  ADD COLUMN "site_title" text,
  ADD COLUMN "twitter" text,
  ADD COLUMN "twitch" text,
  ADD COLUMN "discord" text;

-- +migrate down
ALTER TABLE "public"."ev_events"
  DROP COLUMN "site_title",
  DROP COLUMN "twitter",
  DROP COLUMN "twitch",
  DROP COLUMN "discord";
