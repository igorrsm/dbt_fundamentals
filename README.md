# Learning DBT - Data Build Tool

I created this repository  for **my own use**. I'll be practicing some transformations with dbt while learning about best practices.

# Notes
1.  **DBT Fundamentals**

Overview of the course.

2.  **Analytics Engineering**

The modern stack data team is built with three types of professionals:
- Data Engineer
- Analytics Engineering
- Data Analyst

In a few words, the **Data Engineer** is responsible for the **creation and maintenance of data pipelines**, the **Analytics Engineering** has a mixed role in the data team, with knowledge to make the process of **Extract - Load - Transform (ETL)** data, and **Data Analysts** use this treated data for **analytics** and **decision-making**.

3. **Setting up dbt**

A tutorial for setting up dbt with snowflake (what I use at work).

4. **Models**

Models are **.sql** files with blocks of code that, later on, are created inside data objects within Snowflake structure. 

DBT works with a **modular approach**. The project is made of parts that, when built together, creates a final structure used for data analytics. The modularization is presented by the use of the "ref" function, like this:

    --int_customers.sql
    select 
	    * 
	from {{ref('stg_customers)}}
    
As we can see, the **int_customers.sql** has a reference, that is **"stg_customers"**. 
The **"stg"** files usually are the first selects of the data needed from some kind of source.

#### Naming Conventions

In DBT projects, we should always have the following models:

- **sources:** raw data.
- **stagings:** reference of the source, minor transformations here.
- **intermediates:** between stagings and marts models. Have more profound transformations.
- **fact models:** usually have a lot of transactions and grow with time (sales).
- **dimension models:** things that exist, that are, that normally don't change, like customers.


5. **Sources**

Sources are data objects that come before our stataging models. Usually they're created by data engineers with developed data pipelines.

To configure the sources in our dbt project, we need to use the source function with a .yml configuration file.

The .yml file looks like:

    --src_jaffle_shop.yml
    version: 2
    
    sources:
      - name: jaffle_shop
        database: raw
        schema: jaffle_shop
        tables:
          - name: customers
          - orders
	    

And the stg with a source function will look like:

    --stg_jaffle_shop__customers.sql
    
    select
	    *
	from {{source('jaffle_shop', 'customers')}}