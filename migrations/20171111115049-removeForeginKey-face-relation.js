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
  return db.removeForeignKey('face_relation', 'face_relation_tmp_faceAPI_id_fk');
};

exports.down = function(db) {
  return db.addForeignKey('face_relation', 'tmp_faceAPI', 'face_relation_tmp_faceAPI_id_fk',
      {
        tmp_faceAPI_id: id
      },
      {
          onDelete: 'CASCADE',
          onUpdate: 'RESTRICT'
      }
  );
};

exports._meta = {
  "version": 1
};
