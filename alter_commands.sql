ALTER TABLE P_OWNER DROP CONSTRAINT P_OWNER_EMAIL_CHECK;
ALTER TABLE P_OWNER ADD CONSTRAINT P_OWNER_EMAIL_CHECK CHECK
										(EMAIL LIKE '%@%.%' OR EMAIL LIKE '%@@%.%' AND EMAIL NOT LIKE '%@.%' AND EMAIL NOT LIKE '%.%@%');


ALTER TABLE P_HOUSE DROP CONSTRAINT P_HOUSE_ACREAGE_CHECK;
ALTER TABLE P_HOUSE ADD CONSTRAINT P_HOUSE_ACREAGE_CHECK CHECK
											(ACREAGE > 0 AND ACREAGE <= 100);

ALTER TABLE P_PURCHASE DROP CONSTRAINT P_PURCHASE_CHECK_DATE;
ALTER TABLE P_PURCHASE ADD CONSTRAINT	P_PURCHASE_CHECK_DATE CHECK
      						(PURCHASEDATE > TO_DATE('1939-01-01', 'yyyy-mm-dd'));