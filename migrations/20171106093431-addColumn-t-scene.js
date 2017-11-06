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
  return db.addColumn('t_scene', 'scene', {
      type: type.INTEGER
  }).then(function () {
    db.addColumn('t_scene', 'timestamp', {
      type: type.TIMESTAMP, default: 'NOW()'
    })
  });
};

exports.down = function(db) {
  return db.removeColumn('t_scene', 'scene')
      .then(function () {
          db.removeColumn('t_scene', 'timestamp')
      });
};

exports._meta = {
  "version": 1
};
