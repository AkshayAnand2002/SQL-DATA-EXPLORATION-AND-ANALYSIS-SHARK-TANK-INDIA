select * from project_shark_tank.dbo.Data;
-- Total EPISODES
-- SELECT [Ep# No#] from project_shark_tank.dbo.Data;
SELECT count(distinct [Ep# No#]) from project_shark_tank.dbo.Data;
SELECT max([Ep# No#]) from project_shark_tank.dbo.Data;
--Total unique brand names
Select count(distinct(Brand)) from project_shark_tank.dbo.Data;
-- No. of brands or startups which got funding.
Select [Amount Invested lakhs],case when [Amount Invested lakhs]>0 then 1 else 0 end as funded_or_not from project_shark_tank.dbo.Data;
Select sum(a.funded_or_not) brands_received_funding,count(*) total_count_brands from (Select [Amount Invested lakhs],case when [Amount Invested lakhs]>0 then 1 else 0 end as funded_or_not from project_shark_tank.dbo.Data) a;
-- PERCENTAGE
Select cast(sum(a.funded_or_not) as float)/cast(count(*) as float)*100 as percentage from (Select [Amount Invested lakhs],case when [Amount Invested lakhs]>0 then 1 else 0 end as funded_or_not from project_shark_tank.dbo.Data) a;
-- TOTAL MALE PARTICIPANT
select sum(Male) from project_shark_tank.dbo.Data;
-- TOTAL FEMALE
select sum(Female) from project_shark_tank.dbo.Data;
-- GENDER RATIO
select sum(Female)/sum(Male) from project_shark_tank.dbo.Data;
select * from project_shark_tank.dbo.Data;
-- Total Amount Invested
select sum([Amount Invested lakhs]) from project_shark_tank.dbo.Data;
-- AVERAGE EQUITY TAKEN
SELECT * from project_shark_tank.dbo.Data WHERE [Equity Taken %] > 0;
SELECT AVG(a.[Equity Taken %]) from (SELECT * from project_shark_tank.dbo.Data WHERE [Equity Taken %] > 0) a;
-- HIGHEST DEAL
SELECT MAX([Amount Invested lakhs]) from project_shark_tank.dbo.Data;
-- NO. OF BRANDS/STARTUPS HAVING ATLEAST 1 WOMAN CONTESTANT.
select Female,case when Female>0 then 1 else 0 end as female_count from project_shark_tank.dbo.Data;
select sum(a.female_count) from(select Female,case when Female>0 then 1 else 0 end as female_count from project_shark_tank.dbo.Data) a;
select case when a.Female>0 then 1 else 0 end as female_count ,a.*from (select * from project_shark_tank.dbo.Data where Deal != 'No Deal') a;
select sum(b.female_count) from(select case when a.Female>0 then 1 else 0 end as female_count ,a.*from (select * from project_shark_tank.dbo.Data where Deal != 'No Deal') a)b;
-- AVERAGE NO. OF TEAM MEMBERS
select avg([Team members]) from project_shark_tank.dbo.Data;
-- AVERAGE AMOUNT INVESTED
SELECT AVG(a.[Amount Invested lakhs]) amount_invested from(select * from project_shark_tank.dbo.Data where Deal != 'No Deal') a;
-- AVERAGE AGE OF CONTESTANT.
SELECT [Avg age],count([Avg age]) count from project_shark_tank.dbo.Data group by [Avg age] order by count desc;
-- LOCATION FROM WHERE MOST CONTESTANTS COME.
SELECT [Location],count([Location]) count from project_shark_tank.dbo.Data group by [Location] order by count desc;
-- MOST STARTUPS BELONG TO WHICH SECTOR?
SELECT [Sector],count([Sector]) count from project_shark_tank.dbo.Data group by [Sector] order by count desc;
-- PARTNER DEALS
SELECT [Partners],count([Partners]) count from project_shark_tank.dbo.Data group by [Partners] order by count;
SELECT [Partners],count([Partners]) count from project_shark_tank.dbo.Data where [Partners] != '-' group by [Partners] order by count;
SELECT [Partners],count([Partners]) count from project_shark_tank.dbo.Data where [Partners] != '-' group by [Partners] order by count desc;
-- NO. OF DEALS OR EPISODES WHERE MR. ASNEEER WAS PRESENT
SELECT COUNT([Ashneer Amount Invested]) from project_shark_tank.dbo.Data where [Ashneer Amount Invested] is not null;
-- NO. OF DEALS COMPLETED BY MR. ASHNEER
SELECT COUNT([Ashneer Amount Invested]) from project_shark_tank.dbo.Data where [Ashneer Amount Invested] is not null AND [Ashneer Amount Invested] != 0;
-- SUM AND AVG AMOUNT INVESTED BY MR. ASHNEER
SELECT SUM(C.[Ashneer Amount Invested]),AVG(C.[Ashneer Amount Invested]) FROM (SELECT * from project_shark_tank.dbo.Data where [Ashneer Amount Invested] is not null AND [Ashneer Amount Invested] != 0) C;
-- JOINING
SELECT a.keyy,a.total_deals_present,b.total_deals from(
select'ASHNEER' AS keyy,COUNT([Ashneer Amount Invested]) total_deals_present from project_shark_tank.dbo.Data where [Ashneer Amount Invested] is not null)a
inner join(
select'ASHNEER' AS keyy,COUNT([Ashneer Amount Invested]) total_deals from project_shark_tank.dbo.Data where [Ashneer Amount Invested] is not null AND [Ashneer Amount Invested] != 0)b
on a.keyy=b.keyy;
-- STARTUP INWHICH HIGHEST AMOUNT HAS BEEN INVESTED IN EACH SECTOR.
SELECT Brand,Sector,[Amount Invested lakhs],rank() over(partition by sector order by [Amount Invested lakhs] desc) rnk from project_shark_tank.dbo.Data;
select c.* from(SELECT Brand,Sector,[Amount Invested lakhs],rank() over(partition by sector order by [Amount Invested lakhs] desc) rnk from project_shark_tank.dbo.Data)c where c.rnk=1;
