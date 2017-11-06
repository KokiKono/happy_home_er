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
  return db.createTable('t_suggestion_permission', {
      id: {
          type: type.INTEGER,
          unsigned: true,
          notNull: true,
          primaryKey: true,
          autoIncrement: true,
      },
      pattern_id: {
          type: type.INTEGER,
          notNull: true,
          foreignKey: {
              name: 't_suggestion_permission_pattern_id_fk',
              table: 't_pattern',
              mapping: 'id',
              rules: {
                  onDelete: 'RESTRICT',
                  onUpdate: 'RESTRICT'
              },
          }
      },
      suggestion_id: {
          type: type.INTEGER,
          notNull: true,
          foreignKey: {
              name: 't_suggestion_permission_suggestion_id_fk',
              table: 'm_suggestion',
              mapping: 'id',
              rules: {
                  onDelete: 'RESTRICT',
                  onUpdate: 'RESTRICT'
              }
          }
      }
  });
};

exports.down = function(db) {
  return db.dropTable('t_suggestion_permission');
};

exports._meta = {
  "version": 1
};
