GRANT SELECT, UPDATE, INSERT, DELETE ON all tables in schema edh TO group edh_rw;
GRANT SELECT ON all tables in schema edh TO group edh_ro;
GRANT TRIGGER, UPDATE, SELECT, REFERENCES, DELETE, RULE, INSERT ON all tables in schema edh TO infoadmin;
COMMIT;