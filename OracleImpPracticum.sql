CREATE TABLE P_PROPERTY (
			PROPERTYID	CHAR(5 BYTE)			NOT NULL,
      STREET1			VARCHAR2(50 BYTE) NOT NULL,
      STREET2			VARCHAR2(50 BYTE)	NULL,
      CITY				VARCHAR2(50 BYTE) DEFAULT 'FITCHBURG' NOT NULL,
      STATE				CHAR(2 BYTE)			DEFAULT 'MA' NOT NULL,
      ZIP					CHAR(10 BYTE)			NULL,
      SQFOOTAGE		NUMBER(5,0)				NULL,
      HAS_AC			CHAR(1 BYTE)			NULL,
      ISHOUSE			CHAR(1 BYTE)			NOT NULL,
			CONSTRAINT	P_PROPERTY_PK			PRIMARY KEY(PROPERTYID),
			CONSTRAINT	P_PROPERTY_STATE_CHECK CHECK
									(STATE IN ('AL','AK','AZ','AR','CA','CO','CT','DE','FL','GA','HI','ID','IL','IN','IA','KS','KY','LA','ME','MD','MA','MI','MN','MS','MO','MT','NE','NV','NH','NJ','NM','NY','NC','ND','OH','OK','OR','PA','RI','SC','SD','TN','TX','UT','VT','VA','WA','WV','WI','WY','AS','DC','FM','GU','MH','MP','PW','PR','VI','AE','AA')),
      CONSTRAINT	P_PROPERTY_ISHOUSE_CHECK	CHECK
      						(ISHOUSE IN ('Y','N'))
);

/* what is column id????*/
CREATE TABLE P_OWNER (
			OWNERID	CHAR(5 BYTE) 			NOT NULL,
      LNAME		VARCHAR2(50 BYTE) NOT NULL,
      FNAME		VARCHAR2(30 BYTE) NULL,
      SSN			CHAR(9 BYTE)			NULL,
      EMAIL 	VARCHAR2(50 BYTE) NULL,
      CONSTRAINT	P_OWNER_PK 		PRIMARY KEY(OWNERID),
      CONSTRAINT 	P_OWNER_EMAIL_CHECK	CHECK
      						(EMAIL LIKE '%@%.%' AND EMAIL NOT LIKE '@%' AND EMAIL NOT LIKE '%@%@%')
);

CREATE TABLE P_OWNERADDRESS (
			ADDRESS_CONTRACTID	CHAR(5 BYTE) 			NOT NULL,
      STREET1							VARCHAR2(50 BYTE) NOT NULL,
      STREET2							VARCHAR2(50 BYTE)	NULL,
      CITY								VARCHAR2(50 BYTE) DEFAULT 'FITCHBURG'	NOT NULL,
      STATE								CHAR(2 BYTE)			DEFAULT	'MA' NOT NULL,
      ZIP									CHAR(10 BYTE)			NULL,
      ADDRESSTYPE					VARCHAR2(10 BYTE) DEFAULT	'UNKNOWN' NOT NULL,
      CONSTRAINT	P_OWNERADDRESS_PK	PRIMARY KEY(ADDRESS_CONTRACTID),
      CONSTRAINT	P_OWNERADDRESS_STATE_CHECK CHECK
      						(STATE IN ('AL','AK','AZ','AR','CA','CO','CT','DE','FL','GA','HI','ID','IL','IN','IA','KS','KY','LA','ME','MD','MA','MI','MN','MS','MO','MT','NE','NV','NH','NJ','NM','NY','NC','ND','OH','OK','OR','PA','RI','SC','SD','TN','TX','UT','VT','VA','WA','WV','WI','WY','AS','DC','FM','GU','MH','MP','PW','PR','VI','AE','AA')),
      CONSTRAINT P_OWNERADDRESS_ADDRESSTYPE_CHECK CHECK
      						(ADDRESSTYPE IN ('HOME','OFFICE','RELATIVE','UNKNOWN'))
);

CREATE TABLE P_OWNERCONTACT (
			CONTRACTID					CHAR(5 BYTE)	NOT NULL,
      OWNERID							CHAR(5 BYTE) 	NOT NULL,
      LAST_DATE_VERIFIED	DATE					NULL,
      IS_PHONE						CHAR(1 BYTE)	NOT NULL,
      CONSTRAINT	P_OWNERCONTACT_PK	PRIMARY KEY(CONTRACTID),
      CONSTRAINT	P_OWNERCONTRACT_FK				FOREIGN KEY(OWNERID)
      						REFERENCES P_OWNER(OWNERID)
);

CREATE TABLE P_OWNERPHONE (
			PHONE_CONTRACTID	CHAR(5 BYTE)			NOT NULL,
      PHONENUM					VARCHAR2(30 BYTE) NOT NULL,
      PHONETYPE					VARCHAR2(30 BYTE) DEFAULT 'UNKNOWN' NOT NULL,
      CONSTRAINT	P_OWNERPHONE_PK	PRIMARY KEY(PHONE_CONTRACTID),
      CONSTRAINT	P_OWNERPHONE_PHONETYPE_CHECK CHECK
      						(PHONETYPE IN ('HOME','OFFICE','CELL','UNKNOWN'))
);

CREATE TABLE P_APT (
			A_PROPERTYID			CHAR(5 BYTE)	NOT NULL,
      BUILDINGFLOOR			NUMBER(3,0)		NULL,
      APT_CONTROLS_HEAT	CHAR(1 BYTE)	NULL,
      APT_CONTROLS_AC		CHAR(1 BYTE)	NULL,
      CONSTRAINT	P_APT_PK PRIMARY KEY(A_PROPERTYID)
);

CREATE TABLE P_HOUSE (
			H_PROPERTYID								CHAR(5 BYTE) 	NOT NULL,
      ACREAGE											NUMBER(5,2) 	NULL,
      IS_LAWN_MAINTAINED_BY_OWNER	CHAR(1 BYTE)	NULL,
      CONSTRAINT	P_HOUSE_PK	PRIMARY KEY(H_PROPERTYID),
      CONSTRAINT	P_HOUSE_ACREAGE_CHECK CHECK
      						(0 <= ACREAGE <= 100)
);

CREATE TABLE P_ISSUES (
			PROPERTYID			CHAR(5 BYTE)				NOT NULL,
      ISSUESID				CHAR(5 BYTE)				NOT NULL,
      ISSUETYPE				CHAR(20 BYTE)				NOT NULL,
      OTHER						VARCHAR2(1000 BYTE)	NULL,
      ACTIONREQUIRED	CHAR(1 BYTE)				NULL,
      RESOLVE					CHAR(1 BYTE)				NULL,
      CONSTRAINT	P_ISSUES_PK		PRIMARY KEY(ISSUESID),
      CONSTRAINT	P_ISSUES_FK	FOREIGN KEY(PROPERTYID)
      						REFERENCES P_PROPERTY(PROPERTYID),
      CONSTRAINT	P_ISSUES_ISSUETYPE_CHECK CHECK
      						(ISSUETYPE IN ('COMPLAINT','CODE VIOLATION','INSPECTION CONCERN','OTHER'))
);

CREATE TABLE P_PURCHASE (
			OWNERID				CHAR(5 BYTE)	NOT NULL,
      PROPERTYID		CHAR(5 BYTE)	NOT NULL,
      PURCHASEDATE	DATE					NULL,
      RECORDEDDATE	DATE					DEFAULT SYSDATE NOT NULL,
      CONSTRAINT	P_PURCHASE_PK		PRIMARY KEY(OWNERID, PROPERTYID),
      CONSTRAINT	P_PURCHASE_FK1	FOREIGN KEY(PROPERTYID)
      						REFERENCES 	P_PROPERTY(PROPERTYID),
      CONSTRAINT	P_PURCHASE_FK2	FOREIGN KEY(OWNERID)
      						REFERENCES	P_OWNER(OWNERID),
      CONSTRAINT	P_PURCHASE_CHECK_DATE CHECK
      						(PURCHASEDATE > TO_DATE('1939-01-01', 'yyyy-mm-dd'))

);

CREATE TABLE P_STATEMENT (
			STATEMENTID		CHAR(5 BYTE)	NOT NULL,
      OWNERID				CHAR(5 BYTE)	NOT NULL,
      STATEMENTDATE	DATE					DEFAULT	SYSDATE	NOT NULL,
      CONSTRAINT	P_STATEMENT_PK	PRIMARY KEY(STATEMENTID),
      CONSTRAINT	P_STATEMENT_FK	FOREIGN KEY(OWNERID)
      						REFERENCES	P_OWNER(OWNERID)
);

CREATE TABLE P_STATEMENTITEMS (
			STATEMENTID	CHAR(5 BYTE)	NOT NULL,
      PROPERTYID	CHAR(5 BYTE)	NOT NULL,
      CONSTRAINT P_STATEMENTITEMS_PK	PRIMARY KEY(STATMENTID, PROPERTYID),
      CONSTRAINT P_STATEMENTITEMS_FK1			FOREIGN KEY(STATEMENTID)
      						REFERENCES	P_STATEMENT(STATEMENTID),
			CONSTRAINT P_STATEMENTITEMS_FK2			FOREIGN KEY(PROPERTYID)
      						REFERENCES	P_PROPERTY(PROPERTYID),
);

CREATE TABLE P_ACTIONS (
			PROPERTYID									CHAR(5 BYTE)  			NOT NULL,
			ISSUEID											CHAR(5 BYTE)  			NOT NULL,
      ACTIONID										CHAR(5 BYTE) 				NOT NULL,
      ACTIONDATE									DATE								DEFAULT SYSDATE	NOT NULL,
      ACTIONTYPE									CHAR(10 BYTE) 			NOT NULL,
      OTHER												VARCHAR2(1000 BYTE)	NULL,
      CONTRACTID_USED							CHAR(5 BYTE)				NULL,
      ACTION_NOTES								VARCHAR2(1000 BYTE)	NULL,
      IS_ACTION_WAITING_RESPONSE	CHAR(1 BYTE)				NULL,
      CONSTRAINT	P_ACTIONS_PK		PRIMARY KEY(ACTIONID),
   		CONSTRAINT  P_ACTIONS_FK1		FOREIGN KEY(ISSUEID)
      						REFERENCES P_ISSUES(ISSUEID),
      CONSTRAINT	P_ACTIONS_FK2		FOREIGN KEY(PROPERTYID)
      						REFERENCES P_PROPERTY(PROPERTYID),
      CONSTRAINT	P_ACTIONS_ACTIONTYPE_CHECK	CHECK
      						(ACTIONTYPE IN ('LETTER SENT','CERT LETTER SENT','OWNER CALLED','REFERRED TO CRIMINAL COURT','REFERRED TO CIVIL COURT', 'OTHER'))
);
