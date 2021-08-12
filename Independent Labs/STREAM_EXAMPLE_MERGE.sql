create or replace table "AFH_POC"."AFHCON"."STREAM_TEST_TBL" clone "AFH_POC"."AFHCON"."STG_BREW_NEW";

select * from "AFH_POC"."AFHCON"."STREAM_TEST_TBL";

CREATE OR REPLACE STREAM MYSTREAM_JSON
  ON TABLE "AFH_POC"."AFHCON"."STREAM_TEST_TBL"
  COMMENT = 'STREAM ON FLATTENED TABLE';

create or replace table "AFH_POC"."AFHCON"."STREAM_TEST2"
(brew_type varchar,
brew_msgtype varchar);

Merge into "AFH_POC"."AFHCON"."STREAM_TEST2" target
using "AFH_POC"."AFHCON"."MYSTREAM_JSON" src
on src.type = target.brew_type
when matched and src.METADATA$ACTION = 'INSERT' and src.METADATA$ISUPDATE= 'TRUE'
    then update set target.brew_msgtype = src.messagetype
when not matched and src.METADATA$ACTION = 'INSERT' and src.METADATA$ISUPDATE= 'FALSE'
    then insert (brew_type, brew_msgtype) values (src.type, src.messagetype);
    
select * from "AFH_POC"."AFHCON"."STREAM_TEST2";

insert into "AFH_POC"."AFHCON"."STREAM_TEST_TBL" (type, messagetype)
values ('telemetery_2', 'brew_2');

select * from MYSTREAM_JSON;

update "AFH_POC"."AFHCON"."STREAM_TEST_TBL"
set messagetype = 'brew_3' where type = 'telemetery_1';
  
  