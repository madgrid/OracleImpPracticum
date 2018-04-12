CREATE VIEW P_PHONECONTACT_VERIFICATION_V AS
SELECT LNAME, FNAME, EMAIL, PHONE_CONTACTID, PHONENUM, PHONETYPE, LAST_DATE_VERIFIED
FROM P_OWNER, P_OWNERPHONE, P_OWNERCONTACT
WHERE LAST_DATE_VERIFIED  < TRUNC(SYSDATE) - 365
ORDER BY LNAME;

DROP VIEW P_PHONECONTACT_VERIFICATION_V;

CREATE VIEW P_10001_STATEMENT_V AS
SELECT STATEMENTID, STATEMENTDATE, OWNERID, LNAME, FNAME, PROPERTYID, STREET1, STREET2, CITY, STATE, ZIP, ISSUETYPE, OTHER
FROM P_STATEMENT, P_OWNER, P_PORPERTY, P_ISSUES
WHERE OWNERID = '10001' AND STATEMNTID = '40001'
GROUP BY STREET1;

DROP VIEW P_10001_STATEMENT_V;
