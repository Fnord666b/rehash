#
# $Id$
#

DROP TABLE IF EXISTS submissions_notes;
CREATE TABLE submissions_notes (
	noid mediumint(8) unsigned NOT NULL auto_increment,
	uid mediumint(8) unsigned NOT NULL default '0',
	submatch varchar(32) NOT NULL default '',
	subnote text,
	time datetime default NULL,
	PRIMARY KEY  (noid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

