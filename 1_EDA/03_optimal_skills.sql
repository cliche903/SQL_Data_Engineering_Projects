/*
Question: What are the most optimal skills for data engineers—balancing both demand and salary?
- Create a ranking column that combines demand count and median salary to identify the most valuable skills.
- Focus only on remote Data Engineer positions with specified annual salaries.
- Why?
    - This approach highlights skills that balance market demand and financial reward. It weights core skills appropriately instead of letting rare, outlier skills distort the results.
    - The natural log transformation ensures that both high-salary and widely in-demand skills surface as the most practical and valuable to learn for data engineering careers.
*/

SELECT 
    sd.skills,
    ROUND(MEDIAN(jpf.salary_year_avg), 0) AS median_salary,
    COUNT(jpf.*) AS demand_count,
    ROUND(LN(COUNT(jpf.*)), 1) AS ln_demand_count,
    ROUND((MEDIAN(jpf.salary_year_avg) * LN(COUNT(jpf.*)))/1_000_000, 2) AS optimal_score    
FROM job_postings_fact AS jpf
    JOIN skills_job_dim AS sjd ON jpf.job_id = sjd.job_id
    JOIN skills_dim AS sd ON sjd.skill_id = sd.skill_id
WHERE 
    jpf.job_title_short = 'Data Engineer'
    AND jpf.job_work_from_home = TRUE
    AND jpf.salary_year_avg IS NOT NULL
GROUP BY 
    sd.skills
HAVING 
    COUNT(jpf.*) >= 100
ORDER BY 
    optimal_score DESC
LIMIT 25;

/*

Top Skills by Optimal Score:
• Terraform is at the top, with a $184K average salary and 193 job posts.
• Python and SQL have the most jobs (over 1100 each) and still offer strong median salaries, around $135K and $130K.
• AWS, Spark, and Airflow are popular tools used in cloud and big data, with median salaries between $137K and $150K.
• Kafka also has a high median salary ($145K) and a solid number of jobs.
• Snowflake, Azure, and Databricks all have a steady number of jobs and median salaries between $128K and $137K.

DevOps & Engineering Tools:
• Airflow, Kubernetes, and Docker have strong demand and higher salary ranges ($135K~$150K).
• Git ($140K/208 postings) and GitHub ($135K/127 postings) are widely used and offer competitive salaries.

Programming Languages:
• Java (303 postings, $135K median) and Scala (247 postings, $137K median) are still strong choices for higher-paying data jobs.
• Go ($140K/113 postings) is another language with a high median salary.

Databases & Cloud Tools:
• Redshift ($130K/274 postings), GCP ($136K/196 postings), Hadoop ($135K/198 postings), NoSQL ($134.4K/193 postings), 
and MongoDB ($135.8K/136 postings) are useful skills to have.
• R, PySpark, and BigQuery also offer solid salaries and enough job openings.

Summary:
The most valuable data engineering skills consistently balance two factors: strong hiring demand and 
high earning potential. Core technologies such as Python, SQL, AWS, Spark, Airflow, and Terraform stand 
out as especially strategic investments for both immediate job opportunities and long-term career growth 
in data engineering.

┌────────────┬───────────────┬──────────────┬─────────────────┬───────────────┐
│   skills   │ median_salary │ demand_count │ ln_demand_count │ optimal_score │
│  varchar   │    double     │    int64     │     double      │    double     │
├────────────┼───────────────┼──────────────┼─────────────────┼───────────────┤
│ terraform  │      184000.0 │          193 │             5.3 │          0.97 │
│ python     │      135000.0 │         1133 │             7.0 │          0.95 │
│ aws        │      137320.0 │          783 │             6.7 │          0.91 │
│ sql        │      130000.0 │         1128 │             7.0 │          0.91 │
│ airflow    │      150000.0 │          386 │             6.0 │          0.89 │
│ spark      │      140000.0 │          503 │             6.2 │          0.87 │
│ kafka      │      145000.0 │          292 │             5.7 │          0.82 │
│ snowflake  │      135500.0 │          438 │             6.1 │          0.82 │
│ azure      │      128000.0 │          475 │             6.2 │          0.79 │
│ java       │      135000.0 │          303 │             5.7 │          0.77 │
│ scala      │      137290.0 │          247 │             5.5 │          0.76 │
│ kubernetes │      150500.0 │          147 │             5.0 │          0.75 │
│ git        │      140000.0 │          208 │             5.3 │          0.75 │
│ databricks │      132750.0 │          266 │             5.6 │          0.74 │
│ redshift   │      130000.0 │          274 │             5.6 │          0.73 │
│ gcp        │      136000.0 │          196 │             5.3 │          0.72 │
│ hadoop     │      135000.0 │          198 │             5.3 │          0.71 │
│ nosql      │      134415.0 │          193 │             5.3 │          0.71 │
│ pyspark    │      140000.0 │          152 │             5.0 │           0.7 │
│ docker     │      135000.0 │          144 │             5.0 │          0.67 │
│ mongodb    │      135750.0 │          136 │             4.9 │          0.67 │
│ go         │      140000.0 │          113 │             4.7 │          0.66 │
│ r          │      134775.0 │          133 │             4.9 │          0.66 │
│ github     │      135000.0 │          127 │             4.8 │          0.65 │
│ bigquery   │      135000.0 │          123 │             4.8 │          0.65 │
└────────────┴───────────────┴──────────────┴─────────────────┴───────────────┘

*/