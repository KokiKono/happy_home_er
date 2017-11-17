SET SESSION FOREIGN_KEY_CHECKS=0;

/* Drop Tables */

DROP TABLE IF EXISTS animation_management;
DROP TABLE IF EXISTS tmp_face_group;
DROP TABLE IF EXISTS face_relation;
DROP TABLE IF EXISTS t_emotion_individual;
DROP TABLE IF EXISTS t_emotion;
DROP TABLE IF EXISTS t_face_group;
DROP TABLE IF EXISTS t_love_number;
DROP TABLE IF EXISTS t_notice_suggestion;
DROP TABLE IF EXISTS t_suggestion_task;
DROP TABLE IF EXISTS t_notice;
DROP TABLE IF EXISTS t_family_structure;
DROP TABLE IF EXISTS t_love_family_umber;
DROP TABLE IF EXISTS t_suggestion_permission;
DROP TABLE IF EXISTS t_pattern;
DROP TABLE IF EXISTS t_scene;
DROP TABLE IF EXISTS m_family;
DROP TABLE IF EXISTS m_suggestion_detail;
DROP TABLE IF EXISTS t_suggestion_judgment;
DROP TABLE IF EXISTS m_suggestion;
DROP TABLE IF EXISTS presentation_management;
DROP TABLE IF EXISTS tmp_faceAPI;




/* Create Tables */

CREATE TABLE animation_management
(
	id int NOT NULL AUTO_INCREMENT,
	name text,
	-- START , END
	type text COMMENT 'START , END',
	timestamp timestamp,
	PRIMARY KEY (id)
);


CREATE TABLE face_relation
(
	id int NOT NULL AUTO_INCREMENT,
	-- microsoft FaceAPIのユニークID
	face_id text COMMENT 'microsoft FaceAPIのユニークID',
	image_path text,
	-- 個別に対応したデータ
	json_data text COMMENT '個別に対応したデータ',
	PRIMARY KEY (id)
);


CREATE TABLE m_family
(
	id int NOT NULL AUTO_INCREMENT,
	timestamp timestamp DEFAULT NOW() NOT NULL,
	PRIMARY KEY (id)
);


CREATE TABLE m_suggestion
(
	id int NOT NULL AUTO_INCREMENT,
	title text,
	point int,
	-- この提案するためのパラメーター管理（JSONで）？？
	note text COMMENT 'この提案するためのパラメーター管理（JSONで）？？',
	-- 提案するタイプ（モバイル、スピーカー、リフォームなど)
	type text COMMENT '提案するタイプ（モバイル、スピーカー、リフォームなど)',
	tag_icon text,
	PRIMARY KEY (id)
);


CREATE TABLE m_suggestion_detail
(
	id int NOT NULL AUTO_INCREMENT,
	suggestion_id int NOT NULL,
	task_contents text,
	PRIMARY KEY (id)
);


CREATE TABLE presentation_management
(
	id int NOT NULL AUTO_INCREMENT,
	name text NOT NULL,
	-- START , END
	type text COMMENT 'START , END',
	timestamp timestamp,
	PRIMARY KEY (id)
);


CREATE TABLE tmp_faceAPI
(
	id int NOT NULL AUTO_INCREMENT,
	-- 個別に対応したデータ
	json_data text COMMENT '個別に対応したデータ',
	image_path text,
	PRIMARY KEY (id)
);


CREATE TABLE tmp_face_group
(
	id int NOT NULL AUTO_INCREMENT,
	face_relation_id int NOT NULL,
	-- microsoft FaceAPIのユニークID
	face_id text COMMENT 'microsoft FaceAPIのユニークID',
	timestamp timestamp,
	PRIMARY KEY (id)
);


CREATE TABLE t_emotion
(
	id int NOT NULL AUTO_INCREMENT,
	family_id int NOT NULL,
	-- 個別に対応したデータ
	json_data text COMMENT '個別に対応したデータ',
	image_path text,
	timestamp timestamp,
	PRIMARY KEY (id)
);


CREATE TABLE t_emotion_individual
(
	id int NOT NULL AUTO_INCREMENT,
	emotion_id int NOT NULL,
	-- 個別に対応したデータ
	json_data text NOT NULL COMMENT '個別に対応したデータ',
	-- microsoft FaceAPIのユニークID
	face_id text NOT NULL COMMENT 'microsoft FaceAPIのユニークID',
	timestamp timestamp NOT NULL,
	PRIMARY KEY (id)
);


CREATE TABLE t_face_group
(
	id int NOT NULL AUTO_INCREMENT,
	family_structure_id int NOT NULL,
	-- microsoft FaceAPIのユニークID
	face_id text NOT NULL COMMENT 'microsoft FaceAPIのユニークID',
	timestamp timestamp NOT NULL,
	PRIMARY KEY (id)
);


CREATE TABLE t_family_structure
(
	id int NOT NULL AUTO_INCREMENT,
	family_id int NOT NULL,
	name text,
	-- 父、母、娘、息子のいずれか。
	type text NOT NULL COMMENT '父、母、娘、息子のいずれか。',
	-- microsoft FaceAPIのユニークID
	face_id text NOT NULL COMMENT 'microsoft FaceAPIのユニークID',
	family_icon text,
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
	is_old boolean DEFAULT 'false' NOT NULL,
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
	-- どのパターンを選択したか。
	pattern int NOT NULL COMMENT 'どのパターンを選択したか。',
	timestamp timestamp DEFAULT NOW(),
	PRIMARY KEY (id)
);


CREATE TABLE t_scene
(
	id int NOT NULL AUTO_INCREMENT,
	family_id int NOT NULL,
	-- 家族シーン、留守シーンのどれを選択したか。
	scene int COMMENT '家族シーン、留守シーンのどれを選択したか。',
	timestamp timestamp DEFAULT NOW() NOT NULL,
	PRIMARY KEY (id)
);


CREATE TABLE t_suggestion_judgment
(
	id int NOT NULL AUTO_INCREMENT,
	suggestion_id int NOT NULL,
	key_name text,
	val int,
	PRIMARY KEY (id)
);


CREATE TABLE t_suggestion_permission
(
	id int NOT NULL AUTO_INCREMENT,
	pattern_id int NOT NULL,
	suggestion_id int NOT NULL,
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

ALTER TABLE tmp_face_group
	ADD FOREIGN KEY (face_relation_id)
	REFERENCES face_relation (id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE t_emotion
	ADD FOREIGN KEY (family_id)
	REFERENCES m_family (id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE t_family_structure
	ADD FOREIGN KEY (family_id)
	REFERENCES m_family (id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE t_love_family_umber
	ADD FOREIGN KEY (famiry_id)
	REFERENCES m_family (id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE t_scene
	ADD FOREIGN KEY (family_id)
	REFERENCES m_family (id)
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


ALTER TABLE t_suggestion_judgment
	ADD FOREIGN KEY (suggestion_id)
	REFERENCES m_suggestion (id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE t_suggestion_permission
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


ALTER TABLE t_emotion_individual
	ADD FOREIGN KEY (emotion_id)
	REFERENCES t_emotion (id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE t_face_group
	ADD FOREIGN KEY (family_structure_id)
	REFERENCES t_family_structure (id)
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


ALTER TABLE t_suggestion_permission
	ADD FOREIGN KEY (pattern_id)
	REFERENCES t_pattern (id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE t_pattern
	ADD FOREIGN KEY (scene_id)
	REFERENCES t_scene (id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;



