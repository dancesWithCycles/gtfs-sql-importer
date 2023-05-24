BEGIN;
CREATE SCHEMA IF NOT EXISTS :schema;
SET search_path to :schema, public;

CREATE TABLE feed_info (
  feed_index serial PRIMARY KEY, -- tracks uploads, avoids key collisions
  feed_publisher_name text not null,
  feed_publisher_url text not null,
  feed_lang text not null,
  default_lang text default null,
  feed_start_date date default null,
  feed_end_date date default null,
  feed_version text default null,
  -- unofficial features
  feed_download_date date,
  feed_file text,
  feed_timezone text default null,
  feed_id text default null,
  feed_contact_url text default null,
  feed_contact_email text default null,
  CONSTRAINT feed_file_uniq UNIQUE (feed_file)
);

CREATE TABLE stops (
  feed_index int NOT NULL REFERENCES feed_info (feed_index) ON DELETE CASCADE,
  stop_id text not null,
  stop_code text,
  stop_name text,
  stop_desc text,
  stop_lat double precision,
  stop_lon double precision,
  zone_id text,
  stop_url text,
  stop_street text,
  stop_city text,
  stop_region text,
  stop_postcode text,
  stop_country text,
  stop_timezone text,
  direction text,
  position text,
  parent_station text,
  wheelchair_boarding integer REFERENCES wheelchair_boardings (wheelchair_boarding),
  wheelchair_accessible integer REFERENCES wheelchair_accessible (wheelchair_accessible),
  -- optional
  location_type integer REFERENCES location_types (location_type),
  vehicle_type int,
  level_id text,
  platform_code text,
  the_geom geometry(point, 4326),
  CONSTRAINT stops_level_id_fkey FOREIGN KEY (feed_index, level_id)
    REFERENCES levels (feed_index, level_id),
  CONSTRAINT stops_pkey PRIMARY KEY (feed_index, stop_id)
);

-- trigger the_geom update with lat or lon inserted
CREATE OR REPLACE FUNCTION stop_geom_update() RETURNS TRIGGER AS $stop_geom$
  BEGIN
    NEW.the_geom = ST_SetSRID(ST_MakePoint(NEW.stop_lon, NEW.stop_lat), 4326);
    RETURN NEW;
  END;
$stop_geom$ LANGUAGE plpgsql;

CREATE TRIGGER stop_geom_trigger BEFORE INSERT OR UPDATE ON stops
    FOR EACH ROW EXECUTE PROCEDURE stop_geom_update();

COMMIT;
