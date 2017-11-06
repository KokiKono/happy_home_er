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
  return db.createTable('t_face_group', {
      id: {
          type: type.INTEGER,
          unsigned: true,
          notNull: true,
          primaryKey: true,
          autoIncrement: true,
      },
      family_structure_id: {
          type: type.INTEGER,
          notNull: true,
          foreignKey: {
              name: 't_face_group_family_structure_id_fk',
              table: 't_family_structure',
              mapping: 'id',
              rules: {
                  onDelete: 'RESTRICT',
                  onUpdate: 'RESTRICT'
              }
          }
      },
      face_id: {
          type: type.TEXT,
          notNull: true,
          default: ''
      },
      timestamp: {
          type: type.TIMESTAMP,
          notNull: true,
          default: 'NOW()'
      }
  });
};

exports.down = function(db) {
  return db.dropTable('t_face_group');
};

exports._meta = {
  "version": 1
};
