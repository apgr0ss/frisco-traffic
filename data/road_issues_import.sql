-- 504625,08/3/2019 02:08,Major Road Traffic Issue,12500 CAJUN DR,,"Integration, Citysourced App",08/5/2019 11:30,CLOSED,2498740.96700000,7105155.53900000,GEOMETRY / MORE LANES,Yes,,NO - RESIDENT / OTHER,,8/3/2019 12:00:00 PM,8/5/2019 12:00:00 PM,,,8/5/2019 12:00:00 PM

-- RequestId,Date Initiated,Description,Address,ZipCode,InitiatedBy,DateTimeClosed,Status,XCoordinate,YCoordinate,RequestType,Proactive,Initiated by Resident,Received by Engineer,Resident Contacted,OnHoldPendingOtherAction,DateInProgress,DateComplete  

DROP TABLE IF EXISTS friscoissues;
CREATE TABLE friscoissues(

RequestId INT,
DateInitiated DATE,
Description TEXT,
Address TEXT,
Zip INT ,
InitiatedBy TEXT,
DateTimeClosed DATE,
Status TEXT,
XCoordinate DOUBLE PRECISION,
YCoordinate DOUBLE PRECISION,
RequestType TEXT,
Response TEXT,
LaborHours NUMERIC,
Proactive TEXT,
InitiatedByResident DATE,
ReceivedByEngineer DATE,
ResidentContacted DATE,
OnHoldPendingOtherAction TEXT,
DateInProgress DATE,
DateComplete DATE
);

\copy friscoissues FROM '/Users/jesse.hamner/frisco-traffic/data/road_issues_major.csv' WITH (HEADER, FORMAT CSV, NULL '');

SELECT AddGeometryColumn('friscoissues', 'stateplane', 2276, 'POINT', 2);
SELECT AddGeometryColumn('friscoissues', 'geom', 4326, 'POINT', 2);

UPDATE friscoissues SET stateplane = ST_GeomFromText('POINT(' || XCoordinate || ' ' || YCoordinate || ')', 2276);
UPDATE friscoissues SET geom = ST_Transform(stateplane, 4326);


DROP TABLE IF EXISTS friscominorissues;
CREATE TABLE friscominorissues(
RequestId INT,
DateInitiated DATE,
Description TEXT,
Address TEXT,
Zip INT,
InitiatedBy TEXT,
DateTimeClosed DATE,
Status TEXT,
XCoordinate DOUBLE PRECISION,
YCoordinate DOUBLE PRECISION,
RequestType TEXT,
Proactive TEXT,
InitiatedByResident DATE,
ReceivedByEngineer DATE,
ResidentContacted DATE,
OnHoldPendingOtherAction TEXT,
DateInProgress DATE,
DateComplete DATE
);


\copy friscominorissues FROM '/Users/jesse.hamner/frisco-traffic/data/road_issues_minor.csv' WITH (HEADER, FORMAT CSV, NULL '');

SELECT AddGeometryColumn('friscominorissues', 'stateplane', 2276, 'POINT', 2);
SELECT AddGeometryColumn('friscominorissues', 'geom', 4326, 'POINT', 2);

UPDATE friscominorissues SET stateplane = ST_GeomFromText('POINT(' || XCoordinate || ' ' || YCoordinate || ')', 2276);
UPDATE friscominorissues SET geom = ST_Transform(stateplane, 4326);

