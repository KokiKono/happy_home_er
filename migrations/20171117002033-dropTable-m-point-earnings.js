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
  return db.dropTable('m_point_earnings');
};

exports.down = function(db) {
    return db.createTable('m_point_earnings', {
        id: {
            type: type.INTEGER,
            unsigned: true,
            notNull: true,
            primaryKey: true,
            autoIncrement: true,
        },
        tag_icon: {
            type: type.TEXT
        },
        contents: {
            type: type.TEXT
        },
        point: {
            type: type.INTEGER
        },
        family_icon: {
            type: type.TEXT
        }
    });
};

exports._meta = {
  "version": 1
};
