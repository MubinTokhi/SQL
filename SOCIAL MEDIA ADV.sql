create table agents(
Market char(3),
Marketing_agent varchar(30)
);
insert into agents(Market,Marketing_agent) 
values 
('NZ', 'Helen'),
("AUS", 'Helen'),
("IND", 'Andrew'),
("PAK", 'Andrew'),
("CH", 'Felipe'),
("RSA", 'Andrew'),
("ARG", 'Felipe');

show tables;
select * from project.sqlsample;
-- Google market cost for all markets

select cost, market from project.sqlsample;
select count(market), count(cost) from project.sqlsample where campaign = 'Google';
select market, cost from project.sqlsample where campaign = 'Google';
select round(sum(cost),2) as Total_cost_Google from project.sqlsample where campaign = 'Google';


-- CPC per Audiance

select audience, sum(cost)/sum(clicks)  from project.sqlsample group by audience;


-- market total clicks more than 500

select market,sum(clicks) as TOTAL_CLICKS from project.sqlsample 
group by market having sum(clicks)>500
order by TOTAL_CLICKS desc;

-- cost more than $20 

select *,
CASE 
when cost>20 then 'abovethrshold'
else 'below'
END as Costnew
from project.sqlsample order by costnew;



-- Agents with the total fee

select Agents.Marketing_agent, round(sum(sample.fees),2) as TOTAL_FEES 
from project.sqlsample sample inner join agents Agents
on Agents.Market = sample.Market group by Agents.Marketing_agent order by TOTAL_FEES desc;



-- market total impressions for facebok campagin

select market, sum(impressions) from project.sqlsample where campaign = 'Facebook' group by market
having sum(impressions)>10000 order by market;  


