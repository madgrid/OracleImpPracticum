ALTER TABLE P_OWNER DROP CONSTRAINT P_OWNER_EMAIL_CHECK;
ALTER TABLE P_OWNER ADD CONSTRAINT P_OWNER_EMAIL_CHECK CHECK
											(EMAIL LIKE '%@%.%');
