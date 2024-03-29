ALTER SYSTEM SET log_destination = 'stderr';
ALTER SYSTEM SET logging_collector = on;
ALTER SYSTEM SET log_directory = 'log';
ALTER SYSTEM SET log_filename = 'postgresql-%a.log';
ALTER SYSTEM SET log_truncate_on_rotation = on;
ALTER SYSTEM SET log_min_duration_statement = 5000;
ALTER SYSTEM SET log_checkpoints = on;
ALTER SYSTEM SET log_connections = on;
ALTER SYSTEM SET log_disconnections = on;
ALTER SYSTEM SET log_error_verbosity = default;
ALTER SYSTEM SET log_line_prefix = '%t [%p]: user=%u, db=%d, app=%a, client=%h ';
ALTER SYSTEM SET log_lock_waits = on;
ALTER SYSTEM SET log_timezone = 'America/Sao_Paulo';