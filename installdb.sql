USE mysql;

DROP FUNCTION IF EXISTS bloommatch;
CREATE FUNCTION bloommatch RETURNS integer SONAME 'lib_mysqludf_bloom.so';
CREATE FUNCTION bloomupdate RETURNS STRING SONAME 'lib_mysqludf_bloom.so';