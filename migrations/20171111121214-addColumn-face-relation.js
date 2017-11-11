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
  return db.addColumn('face_relation', 'image_path', {
      type: type.TEXT
  });
};

exports.down = function(db) {
  return db.removeColumn('face_relation', 'image_path');
};

exports._meta = {
  "version": 1
};
