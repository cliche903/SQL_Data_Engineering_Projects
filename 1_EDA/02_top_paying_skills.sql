/*
 Question: What are the highest-paying skills for data engineers?
 - Calculate the median salary for each skill required in data engineer positions
 - Focus on remote positions with specified salaries
 - Include skill frequency to identify both salary and demand
 - Why? 
    - Helps identify which skills command the highest compensation while also showing 
    - how common those skills are, providing a more complete picture for skill development priorities
 */

SELECT 
    sd.skills,
    ROUND(MEDIAN(jpf.salary_year_avg), 0) AS median_salary,
    COUNT(jpf.*) AS demand_count
FROM 
    job_postings_fact AS jpf
JOIN skills_job_dim AS sjd ON jpf.job_id = sjd.job_id
JOIN skills_dim AS sd ON sjd.skill_id = sd.skill_id
WHERE 
    jpf.job_title_short = 'Data Engineer'
    AND jpf.job_work_from_home = TRUE
GROUP BY 
    sd.skills
HAVING 
    COUNT(jpf.*) >= 100
ORDER BY 
    median_salary DESC
LIMIT 25;

/*

Rust tops the list with a $210K median salary, though its demand remains relatively limited at just 232 job postings. 
A step below, Terraform and Golang both have high median salaries at $184K — and with far broader demand (3,248 and 912 postings respectively), 
they represent a more practical target for most engineers.

Several other skills strike a strong balance between pay and availability. 
Spring ($175.5K), Neo4j ($170K), GDPR ($169.6K), and GraphQL ($167.5K) all sit in a competitive salary band with hundreds of postings each. 
Further down the pay scale but with massive demand, Kubernetes ($150.5K, 4,202 postings) and Airflow ($150K, nearly 10,000 postings) 
stand out as near-essential tools in the modern data stack. 
Bitbucket, Ruby, Redis, Ansible, and Jupyter also crack the top 25.

What's notable across the list is that very few of these skills are statistical outliers 
driven by scarcity. Most combine strong salaries with genuine, widespread hiring demand.

Bottom line: Rust aside, the highest-paying skills aren't rarities — they're widely used 
tools with real market pull. For engineers looking to maximize both earning potential and 
employability, Terraform, Golang, and core orchestration tools like Airflow and Kubernetes
are the most compelling investments.

┌────────────┬───────────────┬──────────────┐
│   skills   │ median_salary │ demand_count │
│  varchar   │    double     │    int64     │
├────────────┼───────────────┼──────────────┤
│ rust       │      210000.0 │          232 │
│ golang     │      184000.0 │          912 │
│ terraform  │      184000.0 │         3248 │
│ spring     │      175500.0 │          364 │
│ neo4j      │      170000.0 │          277 │
│ gdpr       │      169616.0 │          582 │
│ zoom       │      168438.0 │          127 │
│ graphql    │      167500.0 │          445 │
│ mongo      │      162250.0 │          265 │
│ fastapi    │      157500.0 │          204 │
│ bitbucket  │      155000.0 │          478 │
│ django     │      155000.0 │          265 │
│ crystal    │      154224.0 │          129 │
│ c          │      151500.0 │          444 │
│ atlassian  │      151500.0 │          249 │
│ typescript │      151000.0 │          388 │
│ kubernetes │      150500.0 │         4202 │
│ node       │      150000.0 │          179 │
│ css        │      150000.0 │          262 │
│ ruby       │      150000.0 │          736 │
│ airflow    │      150000.0 │         9996 │
│ redis      │      149000.0 │          605 │
│ vmware     │      148798.0 │          136 │
│ ansible    │      148798.0 │          475 │
│ jupyter    │      147500.0 │          400 │
└────────────┴───────────────┴──────────────┘
   
*/
