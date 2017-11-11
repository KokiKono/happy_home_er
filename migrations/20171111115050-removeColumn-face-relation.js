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
  return db.removeColumn('face_relation', 'tmp_faceAPI_id');
};

exports.down = function(db) {
  return db.addColumn('face_relation', 'tmp_faceAPI_id', {
          type: type.INTEGER,
          notNull: true,
          foreignKey: {
              name: 'face_relation_tmp_faceAPI_id_fk',
              table: 'tmp_faceAPI',
              mapping: 'id',
              rules: {
                  onDelete: 'RESTRICT',
                  onUpdate: 'RESTRICT'
              }
          }
  });
};

exports._meta = {
  "version": 1
};
