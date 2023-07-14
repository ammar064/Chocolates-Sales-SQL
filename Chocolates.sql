show tables;

desc sales;


/*------------------Select Sales Table------------------*/

select * from sales;


Select SaleDate,Amount,Customers,Boxes 
from sales;

/*--------------Count Amount per Box----------------*/

Select SaleDate,Amount,Amount/Boxes as 'Amount per Box'
from sales;


/*--------------Filter  Amount bigger than 500 and in 2022-01-28----------------*/

select *from sales
where Amount<500;

select *from sales
where Amount<500 and SaleDate='2022-01-28 00:00:00';

/*-----------Filter  Amount  between 500 and 1000-----------------*/

select *from sales
where Amount  between 500 and 1000 order by Amount Desc;

/*-----------Filter with GeoID and order by PID,  Amount Des0-------------*/

select *from sales
where GeoID  ='G4' order by PID,  Amount Desc;

/*-----------Filter all the Amount greater than 1000 in 2022-------------*/

select  SaleDate,Amount,Customers,Boxes from sales
where Amount<1000 and year(SaleDate)=2022 ;

/*-----------Filter with the number of Boxes between 0 and 50 in 2022-------------*/
select  * from sales
where Boxes between 0 and 50 and year(SaleDate)=2022 ;

/*-----------Filter and using function weekday  in 2022-------------*/

select  SaleDate,Amount,Customers,Boxes,weekday(SaleDate) as 'Day' from sales
where  year(SaleDate)=2022 ;


/*-----------Select people table and filter with same conditions-------------*/

select * from people;

select * from people
where Team='Jucies'or 'Yummies' and Location='Paris' ;

select * from people 
where Salesperson like '%B%';



/*----------create Category---------------*/
select  * from sales;

Select SaleDate ,Amount,
case when Amount <2000 then 'Under 2K'
     when Amount <5000 then 'Under 5K'
     when Amount <10000 then 'Under 10K'
else  '10K or more than'
end  as  'Category' 
from sales;



/*--------------use join to marge two or more tables----------------------*/

Select s.SaleDate,s.Amount,p.Salesperson
from sales s
join people p on p.SPID =s.SPID ;


select * from Products;

Select s.SaleDate,s.Amount,pr.Product
from sales s
left join products pr on pr.PID =s.PID ;


/*----Join multiple Tables---*/

Select s.SaleDate,s.Amount,p.Salesperson,pr.Product,p.Team
from sales s
join people p on p.SPID =s.SPID 
join products pr on pr.PID =s.PID 
where Team ='Jucies'and Amount<=500;

select * from geo;

select GeoID,sum(Amount),avg(Amount),sum(Boxes)
from sales
group by GeoID;


/*----------Sales per team and Years---------------*/

Select year(s.SaleDate),p.Team ,sum(s.Amount),sum(s.Boxes)
from sales s
join people p on p.SPID =s.SPID 
join products pr on pr.PID =s.PID 
join geo g on g.GeoID =s.GeoID

group by year(s.SaleDate),p.Team 
order by sum(s.Amount) desc;



/*---------Sales per team and Countries ------*/

Select g.Geo,sum(s.Amount),avg(s.Amount),sum(s.Boxes)
from sales s
join people p on p.SPID =s.SPID 
join products pr on pr.PID =s.PID 
join geo g on g.GeoID =s.GeoID

group by g.Geo;



/*---------Sales per team and Countries ------*/
Select g.Geo,p.Team,sum(s.Amount),sum(s.Boxes)
from sales s
join people p on p.SPID =s.SPID 
join products pr on pr.PID =s.PID 
join geo g on g.GeoID =s.GeoID

group by g.Geo,p.Team
order by p.Team ;


select pr.Product,sum(s.Amount) as 'Total Amount'
from sales s
join products pr on pr.PID =s.PID 

group by pr.Product
order by 'Total Amount' desc;


/*---------What is the Top 10 Product ------*/

select pr.Product,sum(s.Amount) as 'Total Amount'
from sales s
join products pr on pr.PID =s.PID 
group by pr.Product
order by 'Total Amount' desc
limit 10;

/*---------less  Product ------*/

select pr.Product,sum(s.Amount) as 'Total Amount'
from sales s
join products pr on pr.PID =s.PID 
group by pr.Product
order by 'Total Amount' ASC;



/*----------which country has top sales-----*/

Select year(s.SaleDate),g.Geo,sum(s.Amount),sum(s.Boxes)
from sales s
join people p on p.SPID =s.SPID 
join products pr on pr.PID =s.PID 
join geo g on g.GeoID =s.GeoID

group by year(s.SaleDate),g.Geo 
order by sum(s.Amount) desc;


/*----------which country has top sales-----*/

Select year(s.SaleDate),g.Geo,sum(s.Amount),sum(s.Boxes)
from sales s
join people p on p.SPID =s.SPID 
join products pr on pr.PID =s.PID 
join geo g on g.GeoID =s.GeoID

group by year(s.SaleDate),g.Geo 
order by sum(s.Amount) desc;


/*----------which Region has top sales-----*/

Select year(s.SaleDate),g.Region,sum(s.Amount),sum(s.Boxes)
from sales s
join people p on p.SPID =s.SPID 
join products pr on pr.PID =s.PID 
join geo g on g.GeoID =s.GeoID

group by year(s.SaleDate),g.Region 
order by sum(s.Amount) desc;


/* Select the new Chocolates database Form Four tables in the SQL server which include :
1.Salesmen name 
2.city 
3.Date of order 
4.Category name of product 
5.How many of units
6.Stores names
7.Product name
8.Reveneu
9.TotalCost
10.Profit
*/



select s.PID,pro.Product ,
pro.Category ,pro.Cost_per_box ,
g.GeoID,g.Geo,s.Boxes,
 s.Boxes*pro.Cost_per_box AS TotalCost,
 s.Amount as Reveneu,
 s.Amount-( s.Boxes*pro.Cost_per_box) as Profit,
 s.SaleDate,s.Customers ,
 s.SPID,p.Salesperson,
 p.Team
from sales s
join geo g 
on g.GeoID=s.GeoID
join people p
on p.SPID=s.SPID
join products pro
on pro.PID=s.PID

;

