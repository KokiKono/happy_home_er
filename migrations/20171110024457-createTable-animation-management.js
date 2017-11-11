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
  return db.createTable('animation_management', {
      id: {
          type: type.INTEGER,
          unsigned: true,
          notNull: true,
          primaryKey: true,
          autoIncrement: true
      },
      name: {
          type: type.TEXT
      },
      type: {
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
  return db.dropTable('animation_management');
};

exports._meta = {
  "version": 1
};
