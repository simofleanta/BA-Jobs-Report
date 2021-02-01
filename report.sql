select * from company
limit 5;


-- average salary per person

SELECT Fn, Location, Job, Salary,(select avg(Salary)from company)
from company
GROUP BY Location;


-- number of sectors per job /per location
--1 query for count(*)
--2 outer query with the alias 

 select Location,Fn, Sum(Sector_s),Sector, Job from(
    Select Sector,Job,Fn,Location,count(*) as Sector_s 
    from company
    GROUP BY Job) sub
GROUP BY Job;

-- number of jobs per location per job, per person
 select Location,Job,Fn, Sum(Job_s) from(
    Select Sector,Job,Fn,Location,count(*) as Job_s 
    from company
    GROUP BY Sector) sub
GROUP BY Sector;

-- avg salary /Job/location

 select Location,Job, Salary_av from(
    Select Sector,Job,Location,avg(Salary) as Salary_av 
    from company
    GROUP BY Sector) sub
GROUP BY Sector;


 select Location,Sector,Job, Age_av from(
    Select Sector,Job,Location,avg(Age) as Age_av 
    from company
    GROUP BY Sector,Job) sub
GROUP BY Sector;


with avg_age as (Select Sector,Job,Location,avg(Age) as Age_av 
    from company
    GROUP BY Sector,Job
)

SELECT Job, Age_av
from avg_age
Group by Sector;

-- Average age per job ;
select* from company;
select Job,AVG(Age) from company
GROUP BY Job;

-- Salary per location;

SELECT Job, Salary, Location from company;

--How many people work as BA?

select count(FN) from company where Job='Business Analyst';

--How many people work in Berlin?

select count(FN) from company WHERE Location='Berlin';

-- collect all data for Berlin

select Salary, Job,FN from company where Location='Berlin'
GROUP BY  Salary,Job
Order by Salary asc;

-- How many business analysts do we have in Berlin?
select FN, Location, Job from company WHERE Location='Berlin' 
and Job='Business Analyst';

--
select FN, Salary from company WHERE Location='Berlin, Perth';

-- Inner join the tables company and employee so that further insights can be extracted

SELECT * from company;
select * from employee;

select company.Location,company.FN,company.Salary,company.Job,employee.FN,employee.KPI
from company
inner JOIN employee on company.FN=employee.FN;

-- used with function to take the joined table and work through the process of
-- data extraction

with joined_t as
    (select company.Location,company.FN,company.Salary,company.Job,employee.KPI
    from company
    inner JOIN employee on company.FN=employee.FN
)

select * from joined_t;

select* from employee 
group by KPI
order Rating asc;

-- merge databases and slect avg salary per kpi form the joine_t TABLE 
    select company.Location,company.FN,company.Salary,company.Job,employee.FN,employee.KPI
from company
inner JOIN employee on company.FN=employee.FN;

with joined_t as
    (select company.Location,company.FN,company.Salary,company.Job,employee.KPI
    from company
    inner JOIN employee on company.FN=employee.FN
)

select Location, KPI, Salary from joined_t where KPI >17;


-- Avg salary per kpi 
with KPI_t as
    (select company.Location,company.FN,company.Salary,company.Job,employee.KPI
    from company
    inner JOIN employee on company.FN=employee.FN
)
select FN, Job, Location,KPI, AVG(Salary)
from KPI_t
where KPI >17
Group by Location;


with Max_t as
    (select company.Location,company.FN,company.Salary,company.Job,employee.KPI,employee.Problem_solved
    from company
    inner JOIN employee on company.FN=employee.FN
)
select Problem_solved, Fn, Location,Job,max(KPI)from Max_t;


with Max_kpi as
    (select company.Location,company.FN,company.Salary,company.Job,employee.KPI,employee.Problem_solved
    from company
    inner JOIN employee on company.FN=employee.FN
)
select Problem_Solved,  Fn, Location,Job,min(KPI), avg(Salary) from Max_kpi
Group by Problem_Solved;

--Is there a relatonship between kpi and problem solving?
with Max_Salary as
    (select company.Location,company.FN,company.Salary,company.Job,employee.KPI,employee.Problem_solved
    from company
    inner JOIN employee on company.FN=employee.FN
)
select Problem_Solved,  Fn, Location,Job,KPI, max(Salary) from Max_Salary
Group by Problem_Solved
ORDER BY  KPI ASC ;

--the more problem solved the higher the kpi. And salary

















