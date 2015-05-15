class AddTriggersToStations < ActiveRecord::Migration
  def up
    execute <<-SQL
      CREATE FUNCTION audit_changes() RETURNS trigger AS $$
      BEGIN
          IF NEW.bikes_count != OLD.bikes_count OR NEW.slots_count != OLD.slots_count OR NEW.status != OLD.status THEN
            EXECUTE
                'INSERT into recordings (station_id, slots_count, bikes_count, status, polled_at) SELECT $1.id, $1.slots_count, $1.bikes_count, $1.status, $1.last_polled_at WHERE NOT EXISTS (SELECT 1 FROM recordings WHERE station_id = $1.id AND polled_at = $1.last_polled_at);'
            USING OLD;
          END IF;
          RETURN NEW;
      END;
      $$ language plpgsql;

      CREATE TRIGGER audit_trigger
        BEFORE UPDATE
        ON stations
        FOR EACH ROW
        EXECUTE PROCEDURE audit_changes();
    SQL
  end

  def down
    execute <<-SQL
      DROP TRIGGER audit_trigger ON stations;
      DROP FUNCTION audit_changes();
    SQL
  end
end
