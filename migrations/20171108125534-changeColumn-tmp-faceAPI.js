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
  return db.runSql('ALTER TABLE `tmp_faceAPI` CHANGE `id` `id` INT(11) NOT NULL AUTO_INCREMENT', null, (e) => {
      console.log(e);
  });
};

exports.down = function(db) {
  return db.changeColumn('tmp_faceAPI', 'id' , {
      type: type.INTEGER,
      notNull: true,
  });
};

exports._meta = {
  "version": 1
};
