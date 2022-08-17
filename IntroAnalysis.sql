SELECT *
FROM ifood_df;

SELECT count(*)
FROM information_schema.columns
WHERE table_name = 'ifood_df';

SELECT Income
FROM ifood_df
LIMIT 3, 1;

SELECT Income
FROM ifood_df
WHERE Kidhome IS TRUE;

SELECT *
FROM ifood_df
WHERE Income > 5000
    AND Income < 10000;

SELECT Income
FROM ifood_df
WHERE education_Master IS FALSE;

SELECT NumWebVisitsMonth,
    NumStorePurchases,
    NumCatalogPurchases,
    NumWebPurchases
FROM ifood_df
ORDER BY Income ASC;

-- Target study - Marital Status
CREATE VIEW Marital_Statuses AS
SELECT CASE
        WHEN marital_Divorced IS TRUE THEN 'Divorced'
        WHEN marital_Married IS TRUE THEN 'Married'
        WHEN marital_Single IS TRUE THEN 'Single'
        WHEN marital_Together IS TRUE THEN 'Together'
        WHEN marital_Widow IS TRUE THEN 'Widow'
        ELSE 'Unknown'
    END as 'Marital Status'
FROM ifood_df;