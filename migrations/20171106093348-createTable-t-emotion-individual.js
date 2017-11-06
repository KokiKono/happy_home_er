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
  return db.createTable('t_emotion_individual', {
      id: {
          type: type.INTEGER,
          unsigned: true,
          notNull: true,
          primaryKey: true,
          autoIncrement: true,
      },
      emotion_id: {
          type: type.INTEGER,
          notNull: true,
          foreignKey: {
              name: 't_emotion_individual',
              table: 't_emotion',
              mapping: 'id',
              rules: {
                  onDelete: 'RESTRICT',
                  onUpdate: 'RESTRICT'
              }
          }
      },
      timestamp: {
          type: type.TIMESTAMP,
          notNull: true,
          default: 'NOW()'
      },
      json_data: {
          type: type.TEXT,
          notNull: true,
          default: ''
      },
      face_id: {
          type: type.TEXT,
          notNull: true,
          default: ''
      }
  });
};

exports.down = function(db) {
  return db.dropTable('t_emotion_individual');
};

exports._meta = {
  "version": 1
};
