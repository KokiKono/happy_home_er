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
  return db.createTable('presentation_management', {
      id: {
          type: type.INTEGER,
          unsigned: true,
          notNull: true,
          primaryKey: true,
          autoIncrement: true,
      },
      name: {
          type: type.TEXT,
          notNull: true,
          default: ''
      },
      type: {
          type: type.TEXT,
          notNull: true,
          default: 'START'
      }
  });
};

exports.down = function(db) {
  return db.dropTable('presentation_management');
};

exports._meta = {
  "version": 1
};
