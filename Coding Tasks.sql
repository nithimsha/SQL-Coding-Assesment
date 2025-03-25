Use nithim_db

--Quetion 1:Select all open incidents.

select * from Crime where status='open';

--Quetion 2: Find the total number of incidents.

select count(*) as total_number_of_incidents from Crime;

--Quetion 3: List all unique incident types.

select distinct IncidentType from Crime;

--Quetion 4: Retrieve incidents that occurred between '2023-09-01' and '2023-09-10'.

select * from Crime where IncidentDate between '2023-09-01' and '2023-09-10';

--Quetion 5: List persons involved in incidents in descending order of age.

select name, age, crimeid from victim
union all
select name, age, crimeid from suspect
order by age desc;

--Quetion 6: Find the average age of persons involved in incidents.

select avg(v.age) as victim_avg_age, avg(s.age) as suspect_avg_age
from victim v 
full join suspect s on 1=1;


--Quetion 7: List incident types and their counts, only for open cases.

select IncidentType, count(*) as total_case from Crime where Status='Open'
Group by IncidentType;

--Quetion 8: Find persons with names containing 'Doe'.

select * from Victim where name like '%Doe%'
union all
select *  from Suspect where name like '%Doe%';

--Quetion 9: Retrieve the  names of persons involved in open cases and closed cases.

select distinct v.name from victim v
join crime c on v.crimeid = c.crimeid
where c.status in ('Open', 'Closed')
union 
select distinct s.name from suspect s
join crime c on s.crimeid = c.crimeid
where c.status in ('Open', 'Closed');


--Quetion 10: List incident types where there are persons aged 30 or 35 involved.

select distinct c.incidenttype from crime c
join victim v on c.crimeid = v.crimeid where v.age in (30, 35)
union 
select distinct c.incidenttype from crime c
join suspect s on c.crimeid = s.crimeid
where s.age in (30, 35);


--Quetion 11: Find persons involved in incidents of the same type as 'Robbery'.

select distinct v.name  from victim v
join crime c on v.crimeid = c.crimeid where c.incidenttype = 'Robbery'
union
select distinct s.name  from suspect s
join crime c on s.crimeid = c.crimeid
where c.incidenttype = 'Robbery';

--Quetion 12: List incident types with more than one open case.

select incidenttype from crime
where status = 'Open'
group by incidenttype
having count(*) > 1;

--Quetion 13: List all incidents with suspects whose names also appear as victims in other incidents.

select distinct c.* from crime c
join suspect s on c.crimeid = s.crimeid
join victim v on s.name = v.name and s.crimeid <> v.crimeid;

--Quetion 14: Retrieve all incidents along with victim and suspect details.

select c.*, v.name as victim_name, v.contactinfo, s.name as suspect_name, s.description from crime c
left join victim v on c.crimeid = v.crimeid
left join suspect s on c.crimeid = s.crimeid;

--Quetion 15: Find incidents where the suspect is older than any victim.

select distinct c.* from crime c
join suspect s on c.crimeid = s.crimeid
join victim v on c.crimeid = v.crimeid where s.age > v.age;

--Quetion 16: Find suspects involved in multiple incidents.

select name, count(*) as incident_count from suspect
group by name
having count(*) > 1;

--Quetion 17: List incidents with no suspects involved.

select c.* from crime c
left join suspect s on c.crimeid = s.crimeid where s.suspectid is null;

--Quetion 18: List all cases where at least one incident is of type 'Homicide' and all other incidents are of type 'Robbery'. 

select c.* from crime c where exists (select 1 from crime where incidenttype = 'Homicide')
and not exists (select 1 from crime where incidenttype not in ('Homicide', 'Robbery'));

--Quetion 19: Retrieve a list of all incidents and the associated suspects, showing suspects for each incident, or 'No Suspect' if there are none.

select c.*, coalesce(s.name, 'No Suspect') as suspect_name from crime c
left join suspect s on c.crimeid = s.crimeid;

--Quetion 20: List all suspects who have been involved in incidents with incident types 'Robbery' or 'Assault'

select name  from suspect 
where crimeid in (select crimeid from crime where incidenttype in ('Robbery', 'Assault'));

