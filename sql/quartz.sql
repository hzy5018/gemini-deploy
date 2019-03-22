DROP TABLE IF EXISTS TASK_FIRED_TRIGGERS;
DROP TABLE IF EXISTS TASK_PAUSED_TRIGGER_GRPS;
DROP TABLE IF EXISTS TASK_SCHEDULER_STATE;
DROP TABLE IF EXISTS TASK_LOCKS;
DROP TABLE IF EXISTS TASK_SIMPLE_TRIGGERS;
DROP TABLE IF EXISTS TASK_SIMPROP_TRIGGERS;
DROP TABLE IF EXISTS TASK_CRON_TRIGGERS;
DROP TABLE IF EXISTS TASK_BLOB_TRIGGERS;
DROP TABLE IF EXISTS TASK_TRIGGERS;
DROP TABLE IF EXISTS TASK_JOB_DETAILS;
DROP TABLE IF EXISTS TASK_CALENDARS;

CREATE TABLE TASK_JOB_DETAILS(
                               SCHED_NAME character varying(120) NOT NULL,
                               JOB_NAME character varying(200) NOT NULL,
                               JOB_GROUP character varying(200) NOT NULL,
                               DESCRIPTION character varying(250) NULL,
                               JOB_CLASS_NAME character varying(250) NOT NULL,
                               IS_DURABLE boolean NOT NULL,
                               IS_NONCONCURRENT boolean NOT NULL,
                               IS_UPDATE_DATA boolean NOT NULL,
                               REQUESTS_RECOVERY boolean NOT NULL,
                               JOB_DATA bytea NULL);
alter table TASK_JOB_DETAILS add primary key(SCHED_NAME,JOB_NAME,JOB_GROUP);

CREATE TABLE TASK_TRIGGERS (
                             SCHED_NAME character varying(120) NOT NULL,
                             TRIGGER_NAME character varying(200) NOT NULL,
                             TRIGGER_GROUP character varying(200) NOT NULL,
                             JOB_NAME character varying(200) NOT NULL,
                             JOB_GROUP character varying(200) NOT NULL,
                             DESCRIPTION character varying(250) NULL,
                             NEXT_FIRE_TIME BIGINT NULL,
                             PREV_FIRE_TIME BIGINT NULL,
                             PRIORITY INTEGER NULL,
                             TRIGGER_STATE character varying(16) NOT NULL,
                             TRIGGER_TYPE character varying(8) NOT NULL,
                             START_TIME BIGINT NOT NULL,
                             END_TIME BIGINT NULL,
                             CALENDAR_NAME character varying(200) NULL,
                             MISFIRE_INSTR SMALLINT NULL,
                             JOB_DATA bytea NULL)  ;
alter table TASK_TRIGGERS add primary key(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP);

CREATE TABLE TASK_SIMPLE_TRIGGERS (
                                    SCHED_NAME character varying(120) NOT NULL,
                                    TRIGGER_NAME character varying(200) NOT NULL,
                                    TRIGGER_GROUP character varying(200) NOT NULL,
                                    REPEAT_COUNT BIGINT NOT NULL,
                                    REPEAT_INTERVAL BIGINT NOT NULL,
                                    TIMES_TRIGGERED BIGINT NOT NULL)  ;
alter table TASK_SIMPLE_TRIGGERS add primary key(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP);

CREATE TABLE TASK_CRON_TRIGGERS (
                                  SCHED_NAME character varying(120) NOT NULL,
                                  TRIGGER_NAME character varying(200) NOT NULL,
                                  TRIGGER_GROUP character varying(200) NOT NULL,
                                  CRON_EXPRESSION character varying(120) NOT NULL,
                                  TIME_ZONE_ID character varying(80))  ;
alter table TASK_CRON_TRIGGERS add primary key(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP);

CREATE TABLE TASK_SIMPROP_TRIGGERS
(
  SCHED_NAME character varying(120) NOT NULL,
  TRIGGER_NAME character varying(200) NOT NULL,
  TRIGGER_GROUP character varying(200) NOT NULL,
  STR_PROP_1 character varying(512) NULL,
  STR_PROP_2 character varying(512) NULL,
  STR_PROP_3 character varying(512) NULL,
  INT_PROP_1 INT NULL,
  INT_PROP_2 INT NULL,
  LONG_PROP_1 BIGINT NULL,
  LONG_PROP_2 BIGINT NULL,
  DEC_PROP_1 NUMERIC(13,4) NULL,
  DEC_PROP_2 NUMERIC(13,4) NULL,
  BOOL_PROP_1 boolean NULL,
  BOOL_PROP_2 boolean NULL) ;
alter table TASK_SIMPROP_TRIGGERS add primary key(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP);

CREATE TABLE TASK_BLOB_TRIGGERS (
                                  SCHED_NAME character varying(120) NOT NULL,
                                  TRIGGER_NAME character varying(200) NOT NULL,
                                  TRIGGER_GROUP character varying(200) NOT NULL,
                                  BLOB_DATA bytea NULL) ;
alter table TASK_BLOB_TRIGGERS add primary key(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP);

CREATE TABLE TASK_CALENDARS (
                              SCHED_NAME character varying(120) NOT NULL,
                              CALENDAR_NAME character varying(200) NOT NULL,
                              CALENDAR bytea NOT NULL)  ;
alter table TASK_CALENDARS add primary key(SCHED_NAME,CALENDAR_NAME);

CREATE TABLE TASK_PAUSED_TRIGGER_GRPS (
                                        SCHED_NAME character varying(120) NOT NULL,
                                        TRIGGER_GROUP character varying(200) NOT NULL)  ;
alter table TASK_PAUSED_TRIGGER_GRPS add primary key(SCHED_NAME,TRIGGER_GROUP);

CREATE TABLE TASK_FIRED_TRIGGERS (
                                   SCHED_NAME character varying(120) NOT NULL,
                                   ENTRY_ID character varying(95) NOT NULL,
                                   TRIGGER_NAME character varying(200) NOT NULL,
                                   TRIGGER_GROUP character varying(200) NOT NULL,
                                   INSTANCE_NAME character varying(200) NOT NULL,
                                   FIRED_TIME BIGINT NOT NULL,
                                   SCHED_TIME BIGINT NOT NULL,
                                   PRIORITY INTEGER NOT NULL,
                                   STATE character varying(16) NOT NULL,
                                   JOB_NAME character varying(200) NULL,
                                   JOB_GROUP character varying(200) NULL,
                                   IS_NONCONCURRENT boolean NULL,
                                   REQUESTS_RECOVERY boolean NULL)  ;
alter table TASK_FIRED_TRIGGERS add primary key(SCHED_NAME,ENTRY_ID);

CREATE TABLE TASK_SCHEDULER_STATE (
                                    SCHED_NAME character varying(120) NOT NULL,
                                    INSTANCE_NAME character varying(200) NOT NULL,
                                    LAST_CHECKIN_TIME BIGINT NOT NULL,
                                    CHECKIN_INTERVAL BIGINT NOT NULL)  ;
alter table TASK_SCHEDULER_STATE add primary key(SCHED_NAME,INSTANCE_NAME);

CREATE TABLE TASK_LOCKS (
                          SCHED_NAME character varying(120) NOT NULL,
                          LOCK_NAME character varying(40) NOT NULL)  ;
alter table TASK_LOCKS add primary key(SCHED_NAME,LOCK_NAME);

CREATE INDEX IDX_TASK_J_REQ_RECOVERY ON TASK_JOB_DETAILS(SCHED_NAME,REQUESTS_RECOVERY);
CREATE INDEX IDX_TASK_J_GRP ON TASK_JOB_DETAILS(SCHED_NAME,JOB_GROUP);

CREATE INDEX IDX_TASK_T_J ON TASK_TRIGGERS(SCHED_NAME,JOB_NAME,JOB_GROUP);
CREATE INDEX IDX_TASK_T_JG ON TASK_TRIGGERS(SCHED_NAME,JOB_GROUP);
CREATE INDEX IDX_TASK_T_C ON TASK_TRIGGERS(SCHED_NAME,CALENDAR_NAME);
CREATE INDEX IDX_TASK_T_G ON TASK_TRIGGERS(SCHED_NAME,TRIGGER_GROUP);
CREATE INDEX IDX_TASK_T_STATE ON TASK_TRIGGERS(SCHED_NAME,TRIGGER_STATE);
CREATE INDEX IDX_TASK_T_N_STATE ON TASK_TRIGGERS(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP,TRIGGER_STATE);
CREATE INDEX IDX_TASK_T_N_G_STATE ON TASK_TRIGGERS(SCHED_NAME,TRIGGER_GROUP,TRIGGER_STATE);
CREATE INDEX IDX_TASK_T_NEXT_FIRE_TIME ON TASK_TRIGGERS(SCHED_NAME,NEXT_FIRE_TIME);
CREATE INDEX IDX_TASK_T_NFT_ST ON TASK_TRIGGERS(SCHED_NAME,TRIGGER_STATE,NEXT_FIRE_TIME);
CREATE INDEX IDX_TASK_T_NFT_MISFIRE ON TASK_TRIGGERS(SCHED_NAME,MISFIRE_INSTR,NEXT_FIRE_TIME);
CREATE INDEX IDX_TASK_T_NFT_ST_MISFIRE ON TASK_TRIGGERS(SCHED_NAME,MISFIRE_INSTR,NEXT_FIRE_TIME,TRIGGER_STATE);
CREATE INDEX IDX_TASK_T_NFT_ST_MISFIRE_GRP ON TASK_TRIGGERS(SCHED_NAME,MISFIRE_INSTR,NEXT_FIRE_TIME,TRIGGER_GROUP,TRIGGER_STATE);

CREATE INDEX IDX_TASK_FT_TRIG_INST_NAME ON TASK_FIRED_TRIGGERS(SCHED_NAME,INSTANCE_NAME);
CREATE INDEX IDX_TASK_FT_INST_JOB_REQ_RCVRY ON TASK_FIRED_TRIGGERS(SCHED_NAME,INSTANCE_NAME,REQUESTS_RECOVERY);
CREATE INDEX IDX_TASK_FT_J_G ON TASK_FIRED_TRIGGERS(SCHED_NAME,JOB_NAME,JOB_GROUP);
CREATE INDEX IDX_TASK_FT_JG ON TASK_FIRED_TRIGGERS(SCHED_NAME,JOB_GROUP);
CREATE INDEX IDX_TASK_FT_T_G ON TASK_FIRED_TRIGGERS(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP);
CREATE INDEX IDX_TASK_FT_TG ON TASK_FIRED_TRIGGERS(SCHED_NAME,TRIGGER_GROUP);

commit;