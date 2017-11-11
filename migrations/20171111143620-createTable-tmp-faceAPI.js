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
  return db.createTable('tmp_faceAPI', {
      id: {
          type: type.INTEGER,
          notNull: true,
          primaryKey: true
      },
      image_path: {
          type: type.TEXT
      },
      json_data: {
          type: type.TEXT
      },
      timestamp: {
          type: type.TIMESTAMP,
          notNUll: true,
          default: 'NOW()'
      }
  });
};

exports.down = function(db) {
  return db.dropTable('tmp_faceAPI');
};

exports._meta = {
  "version": 1
};
