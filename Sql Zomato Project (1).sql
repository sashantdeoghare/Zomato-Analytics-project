create database zomato;
use zomato;

SELECT * FROM zomato_sheet1;
SELECT * FROM zomato_sheet2;

UPDATE zomato_sheet1 SET Datekey_Opening = REPLACE(Datekey_Opening,'_','-') WHERE Datekey_Opening LIKE '%_%';
SELECT datekey_opening FROM zomato_sheet1;

ALTER TABLE zomato_sheet1 MODIFY COLUMN Datekey_Opening DATE;
SELECT datekey_opening FROM zomato_sheet1;

#1 Build a country Map Table
SELECT countryid,countryname from zomato_sheet2;


#2 Build a Calendar Table using the Column Datekey
SELECT YEAR(Datekey_Opening)Years ,
MONTH(Datekey_Opening)MonthNO, 
MONTHNAME(Datekey_Opening)MonthName,
CONCAT("Q",QUARTER(Datekey_Opening))Quarter, 
CONCAT(YEAR(Datekey_Opening),"_",DATE_FORMAT(Datekey_Opening,'%b')) YEARMONTH,
weekday(Datekey_Opening) WeekDay,
DAY(Datekey_Opening)Day,
DAYNAME(Datekey_Opening)DayName,
CASE when monthname(Datekey_Opening)='April'then'FM1'
when monthname(Datekey_Opening)='May'then'FM2'
when monthname(Datekey_opening)='June'then'FM3'
when monthname(Datekey_opening)='July'then'FM4'
when monthname(Datekey_opening)='August'then'FM5'
when monthname(datekey_opening)='September'then'FM6'
when monthname(Datekey_opening)='October'then'FM7'
when monthname(Datekey_opening)='November'then'FM8'
when monthname(Datekey_opening)='December'then'FM9'
when monthname(Datekey_opening)='january'then'FM10'
when monthname(Datekey_opening)='February'then'FM11'
when monthname(Datekey_opening)='March'then'FM12'
end as Financial_Months,

case when monthname(Datekey_opening) in ('April','May','June') then 'FQ1'
when monthname(Datekey_opening) in ('July','August','September') then 'FQ2'
when monthname(Datekey_opening) in ('October','November','December') then 'FQ3'
when monthname(Datekey_opening) in ('January','February','March') then 'FQ4'
end as Financial_Quarter
from zomato_sheet1;


#3 The Numbers of Resturants based on City and Country.
SELECT city,count(restaurantid)No_of_Restaurants
from zomato_sheet1 inner join zomato_sheet2
on
zomato_sheet1.countrycode=zomato_sheet2.countryid
group by zomato_sheet1.city;

select countryname, count(restaurantid)  total_in_cities
from zomato_sheet1 inner join zomato_sheet2 on zomato_sheet1.countrycode=zomato_sheet2.countryid
group by zomato_sheet2.countryname;


#4.Numbers of Resturants opening based on Year , Quarter , Month
select year(Datekey_opening)Year,
quarter(Datekey_opening)Quarter,
Monthname(Datekey_opening)MonthName,
count(restaurantid)as No_Of_Restaurants 
from zomato_sheet1 group by Year,Quarter,MonthName
order by year, quarter, monthname; 


#5.Count of Resturants based on Average Ratings
select case when Rating<=2 then '0-2' 
when Rating<=3 then '2-3' when Rating<=4 then '3-4'
 when Rating<=5 
 then '4-5' end Rating_Range,count(restaurantid)No_Of_Restaurants
from zomato_sheet1
group by Rating_range
order by Rating_range;


#6.Create buckets based on Average Price of reasonable size and find out how many resturants falls in each buckets
select case when Average_Cost_for_two<=100 then '0-100' 
when Average_Cost_for_two<=500 then '100-500'  
when Average_Cost_for_two<=1000 then '500-1000' 
when Average_Cost_for_two>1000 then '>1000' 
end "Avg_Cost_For2",count(restaurantid)
from zomato_sheet1
group by Avg_Cost_For2
order by Avg_Cost_For2;

#7.Percentage of Resturants based on "Has_Table_booking"
select Has_Table_booking,concat(round(count(Has_Table_booking)/100,1),"%")Percentage
from zomato_sheet1
group by Has_Table_booking;

select distinct (Currency )from zomato_sheet1;

#8.Percentage of Resturants based on "Has_Online_delivery"
select Has_Online_delivery,concat(round(count(Has_Online_delivery)/100,1),"%")Percentage
from zomato_sheet1
group by Has_Online_delivery;

select  Has_Online_delivery, concat(count(has_online_delivery)/100, "%") percentage from zomato_sheet1
group by has_online_delivery; 

select round(avg(rating),2) AVG_rating from zomato_sheet1;

select  count( distinct(Cuisines)) "Total cuisines" from zomato_sheet1;

select rating, count(rating) Number_of_restaurants from zomato_sheet1 group by Rating 
order by rating;

select  count( distinct(RestaurantName)) "Total Restaurantname" from zomato_sheet1;













