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
  return db.createTable('t_suggestion_judgment', {
      id: {
          type: type.INTEGER,
          unsigned: true,
          notNull: true,
          primaryKey: true,
          autoIncrement: true,
      },
      suggestion_id: {
          type: type.INTEGER,
          notNull: true,
          foreignKey: {
              name: 't_suggestion_judgment_suggestion_id_fk',
              table: 'm_suggestion',
              mapping: 'id',
              rules: {
                  onDelete: 'RESTRICT',
                  onUpdate: 'RESTRICT'
              }
          }
      },
      key_name: {
          type: type.TEXT
      },
      val: {
          type: type.INTEGER
      }
  });
};

exports.down = function(db) {
  return db.dropTable('t_suggestion_judgment');
};

exports._meta = {
  "version": 1
};
