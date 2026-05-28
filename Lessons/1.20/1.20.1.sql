SELECT job_posted_date::DATE AS dt,
    COUNT(job_id) AS job_postings
FROM job_postings_fact
WHERE job_posted_date::DATE = '2024-12-31'
GROUP BY dt;