
concurrent index version:

```sql
SELECT 'CREATE INDEX CONCURRENTLY ' || table_name || '_' || column_name || ' ON ' || table_name || ' ("' || column_name || '");' 
FROM information_schema.columns
WHERE table_schema = 'public'
  AND table_name != 'pg_stat_statements'
  AND table_name != 'pg_buffercache';

With this query, we can see all of our indexes sorted by size. We can also see if there are unused indexes:
```

```sql
SELECT
  schemaname || '.' || relname AS table,
  indexrelname AS index,
  pg_size_pretty(pg_relation_size(i.indexrelid)) AS index_size,
  idx_scan as index_scans
FROM pg_stat_user_indexes ui
JOIN pg_index i ON ui.indexrelid = i.indexrelid
WHERE NOT indisunique AND idx_scan < 50 AND pg_relation_size(relid) > 5 * 8192
ORDER BY pg_relation_size(i.indexrelid) / nullif(idx_scan, 0) DESC NULLS FIRST,
pg_relation_size(i.indexrelid) DESC;
```