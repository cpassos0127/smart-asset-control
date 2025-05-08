$env:PGPASSWORD = "oqGFfSXDwXLNDuZ"  # Substitua pela senha real se mudar
psql -h 127.0.0.1 -U postgres -d smart -f "schema_smart_asset.sql"
