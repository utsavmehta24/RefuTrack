--------------------------------------------------------------------------------
-- 1. Rename columns to snake_case and convert text fields to INT
--------------------------------------------------------------------------------
ALTER TABLE persons_of_concern
  CHANGE `Country / territory of asylum/residence` country              VARCHAR(100),
  CHANGE `Origin`                                                  origin               VARCHAR(100),
  CHANGE `Refugees (incl. refugee-like situations)`                refugees             INT,
  CHANGE `Asylum-seekers (pending cases)`                          asylum_seekers       INT,
  CHANGE `Returned refugees`                                       returned_refugees    INT,
  CHANGE `Internally displaced persons (IDPs)`                     idps                 INT,
  CHANGE `Returned IDPs`                                           returned_idps        INT,
  CHANGE `Stateless persons`                                       stateless_persons    INT,
  CHANGE `Others of concern`                                       others_of_concern    INT,
  CHANGE `Total Population`                                        total_population     INT;

--------------------------------------------------------------------------------
-- 2. Verify the new schema
--------------------------------------------------------------------------------
DESCRIBE persons_of_concern;

--------------------------------------------------------------------------------
-- 3. Quick data sanity check
--------------------------------------------------------------------------------
SELECT *
FROM persons_of_concern
LIMIT 10;

