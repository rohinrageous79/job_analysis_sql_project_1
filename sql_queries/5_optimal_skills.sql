WITH skills_demand AS (
    SELECT 
        skills_to_job.skill_id,
        skills_dim.skills AS skill_name,
        COUNT(skills_to_job.job_id) AS demand_count
    FROM job_postings_fact AS job_postings
    INNER JOIN skills_job_dim AS skills_to_job
        ON job_postings.job_id = skills_to_job.job_id
    INNER JOIN skills_dim
        ON skills_to_job.skill_id = skills_dim.skill_id
    WHERE
        job_postings.job_title_short = 'Data Analyst'
        AND job_postings.salary_year_avg IS NOT NULL
        AND job_postings.job_work_from_home = True
    GROUP BY
        skills_to_job.skill_id,
        skills_dim.skills
), 
average_salary AS (
    SELECT 
        skills_to_job.skill_id,
        ROUND(AVG(job_postings.salary_year_avg)) AS avg_salary
    FROM job_postings_fact AS job_postings
    INNER JOIN skills_job_dim AS skills_to_job
        ON job_postings.job_id = skills_to_job.job_id
    WHERE
        job_postings.job_title_short = 'Data Analyst'
        AND job_postings.salary_year_avg IS NOT NULL
        AND job_postings.job_work_from_home = True
    GROUP BY
        skills_to_job.skill_id
)

SELECT
    skills_demand.skill_id,
    skills_demand.skill_name,
    skills_demand.demand_count,
    average_salary.avg_salary
FROM
    skills_demand
INNER JOIN average_salary 
    ON skills_demand.skill_id = average_salary.skill_id
WHERE
    skills_demand.demand_count > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25;