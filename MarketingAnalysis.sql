-- Study Marketing Analysis:

-- 1.1 - What's our sales number, by product categories?

SELECT SUM(MntWines),
    SUM(MntFruits),
    SUM(MntMeatProducts),
    SUM(MntFishProducts),
    SUM(MntSweetProducts),
    SUM(MntGoldProds)
FROM ifood_df
GROUP BY MntWines;
-- 1.2 - What's the best selling product and how many sales did it have?

-- Tableau Version:
CREATE VIEW tableau_best_product as
SELECT SUM(MntWines),
    SUM(MntFruits),
    SUM(MntMeatProducts),
    SUM(MntFishProducts),
    SUM(MntSweetProducts),
    SUM(MntGoldProds)
FROM ifood_df;

-- MySQL Version:
SELECT CASE
        GREATEST(
            SUM(MntWines),
            SUM(MntFruits),
            SUM(MntMeatProducts),
            SUM(MntFishProducts),
            SUM(MntSweetProducts),
            SUM(MntGoldProds)
        )
        WHEN MntWines THEN 'MntWines'
        WHEN MntFruits THEN 'MntFruits'
        WHEN MntMeatProducts THEN 'MntMeatProducts'
        WHEN MntFishProducts THEN 'MntFishProducts'
        WHEN MntSweetProducts THEN 'MntSweetProducts'
        WHEN MntGoldProds THEN 'MntGoldProds'
        ELSE 'Unknown'
    END as best_selling_product
FROM ifood_df
GROUP BY MntWines,
    MntFruits,
    MntMeatProducts,
    MntFishProducts,
    MntSweetProducts,
    MntGoldProds;
CREATE VIEW best_selling_product as
SELECT 'MntWines' AS best_product,
    SUM(MntWines) AS best_selling_product
FROM ifood_df
UNION ALL
SELECT 'MntFruits',
    SUM(MntFruits)
FROM ifood_df
UNION ALL
SELECT 'MntMeatProducts',
    SUM(MntMeatProducts)
FROM ifood_df
UNION ALL
SELECT 'MntSweetProducts',
    SUM(MntSweetProducts)
FROM ifood_df
UNION ALL
SELECT 'MntFishProducts',
    SUM(MntFishProducts)
FROM ifood_df
UNION ALL
SELECT 'MntGoldProds',
    SUM(MntGoldProds)
FROM ifood_df
ORDER BY best_selling_product DESC
LIMIT 1;

-- 2- How many children does our customers have on average?

CREATE VIEW tableau_average_customerkids as
SELECT ROUND(AVG(Kidhome + Teenhome), 2)
FROM ifood_df;

-- 2.1 - Is there any correlation between Income and Education?

WITH Food AS (
    SELECT CASE
            WHEN Income < 25000 THEN '0-24k'
            WHEN Income < 50000 THEN '25-49k'
            WHEN Income < 75000 THEN '50-74k'
            WHEN Income < 100000 THEN '75-99k'
            WHEN Income < 125000 THEN '100-125k'
            ELSE 'Unknown'
        END AS Income_range,
        CASE
            WHEN `education_2n Cycle` THEN '2n_cycle'
            WHEN education_Basic THEN 'basic'
            WHEN education_Graduation THEN 'graduation'
            WHEN education_Master THEN 'master'
            WHEN education_PhD THEN 'PhD'
            ELSE 'Unknown'
        END AS Education
    FROM ifood_df
)
SELECT COUNT(*),
    Income_range,
    Education
FROM Food
GROUP BY Education,
    Income_range;

-- 2.2 - Is there any correlation between Income and Age?

WITH Income_Age AS (
    SELECT CASE
            WHEN Income < 25000 THEN '0-24K'
            WHEN Income < 50000 THEN '25-49K'
            WHEN Income < 75000 THEN '50-74K'
            WHEN Income < 100000 THEN '75-99K'
            WHEN Income < 125000 THEN '100-125K'
            ELSE 'Unknown'
        END AS Income_range,
        CASE
            WHEN Age < 25 THEN '0-24Y'
            WHEN Age < 45 THEN '25-44Y'
            WHEN Age < 65 THEN '45-64Y'
            WHEN Age < 85 THEN '65-85K'
            ELSE 'Unknown'
        END AS Age_range
    FROM ifood_df
)
SELECT COUNT(*),
    Income_range,
    Age_range
FROM Income_Age
GROUP BY Income_range,
    Age_range;

-- 3.1 - Which campaign had the best perfomance?

SELECT GREATEST (
        SUM(AcceptedCmp3),
        SUM(AcceptedCmp4),
        SUM(AcceptedCmp5),
        SUM(AcceptedCmp1),
        SUM(AcceptedCmp2)
    )
FROM ifood_df;

-- 3.2 - What's the TOP 3 best selling products?

SELECT 'MntWines' AS Products,
    SUM(MntWines) AS TOP3_best
FROM ifood_df
UNION ALL
SELECT 'MntFruits',
    SUM(MntFruits)
FROM ifood_df
UNION ALL
SELECT 'MntMeatProducts',
    SUM(MntMeatProducts)
FROM ifood_df
UNION ALL
SELECT 'MntFishProducts',
    SUM(MntFishProducts)
FROM ifood_df
UNION ALL
SELECT 'MntSweetProducts',
    SUM(MntSweetProducts)
FROM ifood_df
UNION ALL
SELECT 'MntGoldProds',
    SUM(MntGoldProds)
FROM ifood_df
ORDER BY TOP3_best DESC
LIMIT 3;

-- 3.3 - What's the TOP 3 least sold items?

SELECT 'MntWines' AS Products,
    SUM(MntWines) AS TOP3_worst
FROM ifood_df
UNION ALL
SELECT 'MntFruits',
    SUM(MntFruits)
FROM ifood_df
UNION ALL
SELECT 'MntMeatProducts',
    SUM(MntMeatProducts)
FROM ifood_df
UNION ALL
SELECT 'MntFishProducts',
    SUM(MntFishProducts)
FROM ifood_df
UNION ALL
SELECT 'MntSweetProducts',
    SUM(MntSweetProducts)
FROM ifood_df
UNION ALL
SELECT 'MntGoldProds',
    SUM(MntGoldProds)
FROM ifood_df
ORDER BY TOP3_worst
LIMIT 3;

-- 4 - What do the different Marital Statuses usually shop? 

WITH Marital_Shopping AS (
    SELECT CASE
            WHEN marital_Divorced IS TRUE THEN 'Divorced'
            WHEN marital_Married THEN 'Married'
            WHEN marital_Single THEN 'Single'
            WHEN marital_Together THEN 'Together'
            WHEN marital_Widow THEN 'Widow'
            ELSE 'Unknown'
        END AS Martital,
        CASE
            WHEN NumDealsPurchases THEN 'DealsPurchases'
            WHEN NumWebPurchases THEN 'WebPurchases'
            WHEN NumCatalogPurchases THEN 'CatalogPurchases'
            WHEN NumStorePurchases THEN 'StorePurchases'
            ELSE 'Unknown'
        END AS Purchases_Type
    FROM ifood_df
)
SELECT COUNT(*),
    Martital,
    Purchases_Type
FROM Marital_Shopping
GROUP BY Martital,
    Purchases_Type;

-- 5 - Create our Persona (Average Customer).

WITH Average_Marital AS (
    SELECT MAX(
            CASE
                WHEN marital_Divorced IS TRUE THEN 'Divorced'
                WHEN marital_Married IS TRUE THEN 'Married'
                WHEN marital_Single IS TRUE THEN 'Single'
                WHEN marital_Together IS TRUE THEN 'Together'
                WHEN marital_Widow IS TRUE THEN 'Widow'
                ELSE 'Unknown'
            END
        ) AS marital_status
    FROM ifood_df
),
Average_Education AS (
    SELECT MAX(
            CASE
                WHEN `education_2n Cycle` THEN '2nd_cycle'
                WHEN education_Basic THEN 'basic'
                WHEN education_Graduation THEN 'graduation'
                WHEN education_Master THEN 'master'
                WHEN education_PhD THEN 'PhD'
                ELSE 'Unknown'
            END
        ) AS Education
    FROM ifood_df
)
SELECT ROUND(AVG(Age), 0),
    ROUND(AVG(Income), 2),
    ROUND(AVG(Kidhome + Teenhome), 2),
    marital_status,
    Education
FROM ifood_df,
    Average_Education,
    Average_Marital
GROUP BY marital_status,
    Education;

-- 6 - What channels are generating the least leads?

SELECT LEAST(
        SUM(NumDealsPurchases),
        SUM(NumWebPurchases),
        SUM(NumCatalogPurchases),
        SUM(NumStorePurchases),
        SUM(NumWebVisitsMonth)
    )
FROM ifood_df;

-- 7 - How many years ago did our customers made their first purchase in our company?

SELECT ROUND(Customer_Days / 365, 0) AS Customer_time_years
FROM ifood_df;