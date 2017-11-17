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
  return db.addColumn('t_family_structure', 'family_icon', {
      type: type.STRING,
      notNull: true,
      defaultValue: 'http://localhost:8080/public/images/not_setting.svg'
  });
};

exports.down = function(db) {
  return db.removeColumn('t_family_structure', 'family_icon');
};

exports._meta = {
  "version": 1
};
