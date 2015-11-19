CREATE TABLE Account (
  id varchar(255) NOT NULL PRIMARY KEY,
  annual_revenue varchar(255) DEFAULT NULL,
  billing_city varchar(255) DEFAULT NULL,
  billing_country varchar(255) DEFAULT NULL,
  billing_zipcode varchar(255) DEFAULT NULL,
  billing_state varchar(255) DEFAULT NULL,
  billing_street varchar(255) DEFAULT NULL,
  description varchar(255) DEFAULT NULL,
  fax_number varchar(255) DEFAULT NULL,
  industry varchar(255) DEFAULT NULL,
  last_update timestamp AS CURRENT_TIMESTAMP(),
  account_name varchar(255) DEFAULT NULL,
  employee_count int(11) DEFAULT NULL,
  phone_number varchar(255) DEFAULT NULL,
  shipping_city varchar(255) DEFAULT NULL,
  shipping_country varchar(255) DEFAULT NULL,
  shipping_zipcode varchar(255) DEFAULT NULL,
  shipping_state varchar(255) DEFAULT NULL,
  shipping_street varchar(255) DEFAULT NULL,
  web_address varchar(255) DEFAULT NULL,
  account_rep varchar(255) DEFAULT NULL
);

CREATE ALIAS UUID FOR "org.h2.value.ValueUuid.getNewRandom";
