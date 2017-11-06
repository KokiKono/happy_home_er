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
  return db.addColumn('m_suggestion', 'note', {
      type: type.TEXT
  }).then(function () {
      db.addColumn('m_suggestion', 'type', {
          type: type.TEXT
      })
  });
};

exports.down = function(db) {
  return db.removeColumn('m_suggestion', 'note')
      .then(function () {
          db.removeColumn('m_suggestion', 'type')
      });
};

exports._meta = {
  "version": 1
};
