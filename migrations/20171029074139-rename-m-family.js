'use strict';

var dbm;
var type;
var seed;

/**
  * We receive the dbmigrate dependency from dbmigrate initially.
  * This enables us to not have to rely on NODE_PATH.
  */
exports.setup = function(options, seedLink) {
  dbm = options.dbmigrate;
  type = dbm.dataType;
  seed = seedLink;
};

exports.up = function(db) {
  return db.renameTable('m_famiry', 'm_family');
};

exports.down = function(db) {
  return db.renameTable('m_family', 'm_famiry');
};

exports._meta = {
  "version": 2,
};
