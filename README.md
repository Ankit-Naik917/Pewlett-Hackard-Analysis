# Pewlett-Hackard-Analysis
PH Analysis was completed using PostGreSQL and the queries were written and executed in PGAdmin
## Overview of the PH Employee Retirement Plan analysis:
The purpose of this analysis is to determine the number of retiring employees and provide the numbers based on the employees title. This analysis will provide an overview on how many employees position by their titles will need to be refilled once they retire. The other part of the the analysis is to help identify how many employees are available for mentorship program. This will fill the gap of employees that will be retiring in short term.

## Results:
1) Based on the analysis, approximately 24% of staff at Pewlett-Hackard will be retiring in near future
2) The highest number of staff that are retiring holds "Senior Engineer" (total # 25,916 retiring) and "Senior Staff" (total # 24,926 retiring) title.
3) The concerning factor is the percentage of employees retiring from each department.
   86% of employees with "Senior Engineer" title are retiring <br/>
   27% of employees with "Senior Staff" title are retiring <br/>
   24% of employees with "Technical Leader" title are retiring <br/>
   19% of employees with "Staff" title are retiring <br/>
4) Current mentorship qualification plan doesn't meet the needs to fill the gap of retiring employees.
   

## Summary

Current Mentorship eligibility doesn't even fill the gap by 10%. The mentorship eligibility criteria needs be loosen so that more employee can get eligible to fill the gap for retiring employees and other employees can back fill the vacant position created by employees qualified under mentorship program. New hiring will still be needed to fill all resources. Below are 3 queries that provides different scenarios.

#### Query 1 - This query shows the number of employees available for mentorship based on the birthday between 1965-01-01 to 1965-12-31
First query gives eligible employees based on their birth year of 1965. As mentioned above, the current eligibility criteria doesn't even fill the gap to 10%. </br>

SELECT COUNT (e.emp_no), </br>
	ti.title </br>
FROM employees as e </br>
LEFT JOIN titles as ti </br>
ON (e.emp_no = ti.emp_no) </br>
WHERE (ti.to_date = '9999-01-01') AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31') </br>
GROUP BY ti.title </br>
ORDER BY COUNT (e.emp_no)DESC;

#### Query 2 - This query shows the number of employees available for mentorship based on the birthday between 1963-01-01 to 1965-12-31
The second query is altered to change the eligibility to get more current employees to be eligible for succession planning. Running this query shows that if the employee born between 1963 to 1965 are eligible for mentorship program, it fills over 50% of the gap.<br/>

SELECT COUNT (e.emp_no), </br>
	ti.title </br>
FROM employees as e </br>
LEFT JOIN titles as ti </br>
ON (e.emp_no = ti.emp_no) </br>
WHERE (ti.to_date = '9999-01-01') AND (e.birth_date BETWEEN '1963-01-01' AND '1965-12-31') </br>
GROUP BY ti.title </br>
ORDER BY COUNT (e.emp_no)DESC;
#### Query 3 - This query shows the number of employees available for mentorship based on the birthday between 1961-03-01 to 1965-12-31
The third query is altered to change the eligibility to get more current employees to be eligible for succession planning. Running this query shows that if the employee born between March 01, 1963 to December 31, 1965 are eligible for mentorship program, it fills over 100% of the gap.<br/>

SELECT COUNT (e.emp_no), </br>
	ti.title </br>
FROM employees as e </br>
LEFT JOIN titles as ti </br>
ON (e.emp_no = ti.emp_no) </br>
WHERE (ti.to_date = '9999-01-01') AND (e.birth_date BETWEEN '1961-03-01' AND '1965-12-31') </br>
GROUP BY ti.title </br>
ORDER BY COUNT (e.emp_no)DESC;
