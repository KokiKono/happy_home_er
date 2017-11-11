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
    return db.createTable('tmp_face_group', {
        id: {
            type: type.INTEGER,
            unsigned: true,
            notNull: true,
            primaryKey: true,
            autoIncrement: true,
        },
        face_relation_id: {
            type: type.INTEGER,
            notNull: true,
            foreignKey: {
                name: 'tmp_face_group_face_relation_id_fk',
                table: 'face_relation',
                mapping: 'id',
                rules: {
                    onDelete: 'RESTRICT',
                    onUpdate: 'RESTRICT'
                }
            }
        },
        face_id: {
            type: type.TEXT,
        },
        timestamp: {
            type: type.TIMESTAMP,
            default: 'NOW()',
        }
    });
};

exports.down = function(db) {
  return db.dropTable('tmp_face_group');
};

exports._meta = {
  "version": 1
};
