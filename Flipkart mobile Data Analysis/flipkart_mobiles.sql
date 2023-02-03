use flipkart_mobiles;

/*
drop table if exists flipkart_mobiles;

create table flipkart_mobiles (
            name varchar(100),
            brand varchar(20),
            ratings float,
            no_of_ratings varchar(20),
            no_of_reviews varchar(20),
            product_features varchar(1000),
            msp int,
            mrp int,
            discount int
		);

create table flipkart_mobiles_dup like flipkart_mobiles;
insert into flipkart_mobiles_dup
(select * from flipkart_mobiles)
*/

-- Data Cleaning

describe flipkart_mobiles;

select * from flipkart_mobiles;

-- 1). Convert no_of_reviews data type varchar to int

alter table flipkart_mobiles
modify no_of_reviews int ;

-- 2). Convert no_of_ratings data type varchar to double but first replace comma 

-- select replace(no_of_ratings, ',','') from flipkart_mobiles;
update flipkart_mobiles
set no_of_ratings =  replace(no_of_ratings, ',','');

alter table flipkart_mobiles
 modify no_of_ratings double;
 
 -- Data Analysis
 
 -- 1). Total records 
 
select count(*) from flipkart_mobiles;

-- 2). Total distinct records
  
   select distinct * from flipkart_mobiles;

-- 3). How many brands available

select  count(distinct brand) from flipkart_mobiles;

-- 4). no. of mobiles in each brand 

select brand , count(brand) as total_product from flipkart_mobiles group by brand;

-- 5). Top 5 expensive mobile overall

select * from flipkart_mobiles order by msp desc limit 5;

-- 6). Top 1  expensive mobile in each brand category

with cte as(
select * , row_number() over(partition by brand order by msp desc ) as rn from flipkart_mobiles )
select * from cte where rn = 1 order by msp desc;

-- 7). top 5 mobiles offers high discount

select * from flipkart_mobiles order by discount desc limit 5;

-- 8). top 5 mobiles with highest ratings

select * from flipkart_mobiles order by ratings desc limit 5;

-- 9). top mobiles with highest ratings

select * from flipkart_mobiles where ratings > 4 and no_of_ratings >100000 order by ratings desc;

-- 10). Best mobiles  in each brand where ratings higher than 4 and no. of users who given ratings more than 100000

with cte as (
select * , row_number() over(partition by brand order by ratings desc) as rn from flipkart_mobiles where ratings > 4 
and no_of_ratings >100000 order by ratings desc)
select * from cte  where rn = 1;

-- 11). Best mobiles with 8 GB RAM , ratings higher than 4 and no. of users who given ratings more than 50000

select * from flipkart_mobiles where substring(product_features, 3,8) = '8 GB RAM' and ratings > 4 
and no_of_ratings >50000  order by msp desc;

