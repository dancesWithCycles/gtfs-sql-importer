SET search_path to :schema, public;

CREATE INDEX IF NOT EXISTS stop_geom_idx
  ON stops USING GIST (the_geom);
