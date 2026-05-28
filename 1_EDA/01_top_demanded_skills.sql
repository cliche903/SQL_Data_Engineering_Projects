/*
 Question: What are the most in-demand skills for data engineers?
 - Identify the top 10 in-demand skills for data engineers
 - Focus on remote job postings
 - Why? 
    - Retrieves the top 10 skills with the highest demand in the remote job market,
 providing insights into the most valuable skills for data engineers seeking remote work
 */

SELECT 
    sd.skills,
    COUNT(jpf.*) AS demand_count
FROM job_postings_fact AS jpf
    JOIN skills_job_dim AS sjd ON jpf.job_id = sjd.job_id
    JOIN skills_dim AS sd ON sjd.skill_id = sd.skill_id
WHERE 
    jpf.job_title_short = 'Data Engineer'
    AND jpf.job_work_from_home = TRUE
GROUP BY 
    sd.skills
ORDER BY 
    demand_count DESC
LIMIT 10;

/*
 
 SQL and Python dominate the data engineering job market, each appearing in roughly 
 29,000 job postings — nearly twice as often as any other skill. Cloud expertise follows 
 closely behind, with AWS featured in approximately 18,000 postings and Azure in 14,000. 
 Apache Spark rounds out the top five at nearly 13,000 postings, underscoring the 
 continued importance of big data processing.
 
 Beyond the top five, data pipeline tools such as Airflow, Snowflake, and Databricks 
 are seeing growing demand, while Java and GCP round out the ten most sought-after skills overall. 
 
 The broader picture is clear: data engineers are expected to combine strong programming 
 fundamentals with cloud fluency and hands-on experience with modern data infrastructure.
 
 ┌────────────┬──────────────┐
 │   skills   │ demand_count │
 │  varchar   │    int64     │
 ├────────────┼──────────────┤
 │ sql        │        29221 │
 │ python     │        28776 │
 │ aws        │        17823 │
 │ azure      │        14143 │
 │ spark      │        12799 │
 │ airflow    │         9996 │
 │ snowflake  │         8639 │
 │ databricks │         8183 │
 │ java       │         7267 │
 │ gcp        │         6446 │
 └────────────┴──────────────┘
 
 */