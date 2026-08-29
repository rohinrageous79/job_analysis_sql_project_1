WITH top_paying_jobs AS(
    SELECT 
    job_title,
    salary_year_avg,
    skills_to_job.skill_id
FROM
    job_postings_fact AS job_postings
INNER JOIN skills_job_dim AS skills_to_job
ON skills_to_job.job_id=job_postings.job_id
WHERE
    job_title_short='Data Analyst' AND
    salary_year_avg IS NOT NULL
GROUP BY
    job_postings.job_title,
    job_postings.salary_year_avg,
    skills_to_job.skill_id
)

SELECT 
    skills_dim.skills,
    ROUND(AVG(salary_year_avg)) AS avg_salary
FROM
    top_paying_jobs
INNER JOIN skills_dim
ON skills_dim.skill_id=top_paying_jobs.skill_id
GROUP BY
    skills_dim.skills
ORDER BY 
    avg_salary DESC
LIMIT 10
    
