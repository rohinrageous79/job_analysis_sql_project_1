WITH job_skills AS(
    SELECT 
    skill_id,
    COUNT(*) AS skill_count
FROM
    skills_job_dim AS skills_to_job
INNER JOIN job_postings_fact AS job_postings
ON job_postings.job_id= skills_to_job.job_id
WHERE
    job_postings.job_title_short='Data Analyst'
GROUP BY
    skill_id
)

SELECT 
    job_skills.skill_id,
    job_skills.skill_count,
    skills_dim.skills AS skill_name
FROM job_skills
INNER JOIN skills_dim
ON skills_dim.skill_id=job_skills.skill_id
ORDER BY 
    skill_count DESC
LIMIT 5

