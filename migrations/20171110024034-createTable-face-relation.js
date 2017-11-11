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
  return db.changeColumn('tmp_faceAPI', 'id', {
      type: type.INTEGER,
      length: 11,
  }, () => {
      db.createTable('face_relation', {
          tmp_faceAPI_id: {
              type: type.INTEGER,
              notNull: true,
              // foreignKey: {
              //     name: 'face_relation_tmp_faceAPI_id_fk',
              //     table: 'tmp_faceAPI',
              //     mapping: 'id',
              //     rules: {
              //         onDelete: 'RESTRICT',
              //         onUpdate: 'RESTRICT'
              //     }
              // }
          },
          tmp_face_group_id: {
              type: type.INTEGER,
              notNull: true,
              // foreignKey: {
              //     name: 'ace_relation_tmp_face_group_id_fk',
              //     table: 'tmp_face_group',
              //     mapping: 'id',
              //     rules: {
              //         onDelete: 'RESTRICT',
              //         onUpdate: 'RESTRICT'
              //     }
              // }
          },
          face_id: {
              type: type.TEXT,
          }
      });
  })
};

exports.down = function(db) {
  return db.dropTable('face_relation');
};

exports._meta = {
  "version": 1
};
