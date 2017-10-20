SET SESSION FOREIGN_KEY_CHECKS=0;

/* Drop Tables */

DROP TABLE IF EXISTS t_love_number;
DROP TABLE IF EXISTS t_notice_suggestion;
DROP TABLE IF EXISTS t_suggestion_task;
DROP TABLE IF EXISTS t_notice;
DROP TABLE IF EXISTS t_family_structure;
DROP TABLE IF EXISTS t_love_family_umber;
DROP TABLE IF EXISTS t_pattern;
DROP TABLE IF EXISTS t_scene;
DROP TABLE IF EXISTS m_famiry;
DROP TABLE IF EXISTS m_suggestion_detail;
DROP TABLE IF EXISTS m_suggestion;




/* Create Tables */

CREATE TABLE m_famiry
(
	id int NOT NULL AUTO_INCREMENT,
	timestamp timestamp DEFAULT NOW(), SYSDATE() NOT NULL,
	PRIMARY KEY (id)
);


CREATE TABLE m_suggestion
(
	id int NOT NULL AUTO_INCREMENT,
	title text,
	PRIMARY KEY (id)
);


CREATE TABLE m_suggestion_detail
(
	id int NOT NULL AUTO_INCREMENT,
	suggestion_id int NOT NULL,
	task_contents text,
	PRIMARY KEY (id)
);


CREATE TABLE t_family_structure
(
	id int NOT NULL AUTO_INCREMENT,
	family_id int NOT NULL,
	name text,
	-- 父、母、娘、息子のいずれか。
	type text NOT NULL COMMENT '父、母、娘、息子のいずれか。',
	PRIMARY KEY (id)
);


CREATE TABLE t_love_family_umber
(
	id int NOT NULL AUTO_INCREMENT,
	point int,
	datatime datetime DEFAULT NOW(), SYSDATE() NOT NULL,
	famiry_id int NOT NULL,
	PRIMARY KEY (id)
);


CREATE TABLE t_love_number
(
	id int NOT NULL AUTO_INCREMENT,
	family_structure_id int NOT NULL,
	point int,
	datatime datetime DEFAULT NOW(), SYSDATE() NOT NULL,
	notice_id int,
	PRIMARY KEY (id)
);


CREATE TABLE t_notice
(
	id int NOT NULL AUTO_INCREMENT,
	family_structure_id int NOT NULL,
	title text,
	-- 行動する前の内容
	notice_contents text COMMENT '行動する前の内容',
	result_contents text,
	is_skip boolean DEFAULT 'false',
	PRIMARY KEY (id)
);


CREATE TABLE t_notice_suggestion
(
	id int NOT NULL AUTO_INCREMENT,
	notice_id int NOT NULL,
	suggestion_id int NOT NULL,
	receiving boolean DEFAULT 'false',
	PRIMARY KEY (id)
);


CREATE TABLE t_pattern
(
	id int NOT NULL AUTO_INCREMENT,
	scene_id int NOT NULL,
	PRIMARY KEY (id)
);


CREATE TABLE t_scene
(
	id int NOT NULL AUTO_INCREMENT,
	family_id int NOT NULL,
	PRIMARY KEY (id)
);


CREATE TABLE t_suggestion_task
(
	suggestion_detail_id int NOT NULL,
	notice_id int NOT NULL,
	done boolean DEFAULT 'false' NOT NULL,
	PRIMARY KEY (suggestion_detail_id, notice_id)
);



/* Create Foreign Keys */

ALTER TABLE t_family_structure
	ADD FOREIGN KEY (family_id)
	REFERENCES m_famiry (id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE t_love_family_umber
	ADD FOREIGN KEY (famiry_id)
	REFERENCES m_famiry (id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE t_scene
	ADD FOREIGN KEY (family_id)
	REFERENCES m_famiry (id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE m_suggestion_detail
	ADD FOREIGN KEY (suggestion_id)
	REFERENCES m_suggestion (id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE t_notice_suggestion
	ADD FOREIGN KEY (suggestion_id)
	REFERENCES m_suggestion (id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE t_suggestion_task
	ADD FOREIGN KEY (suggestion_detail_id)
	REFERENCES m_suggestion_detail (id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE t_love_number
	ADD FOREIGN KEY (family_structure_id)
	REFERENCES t_family_structure (id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE t_notice
	ADD FOREIGN KEY (family_structure_id)
	REFERENCES t_family_structure (id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE t_love_number
	ADD FOREIGN KEY (notice_id)
	REFERENCES t_notice (id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE t_notice_suggestion
	ADD FOREIGN KEY (notice_id)
	REFERENCES t_notice (id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE t_suggestion_task
	ADD FOREIGN KEY (notice_id)
	REFERENCES t_notice (id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE t_pattern
	ADD FOREIGN KEY (scene_id)
	REFERENCES t_scene (id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;



