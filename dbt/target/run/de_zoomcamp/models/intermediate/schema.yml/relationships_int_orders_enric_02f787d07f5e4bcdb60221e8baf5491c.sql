
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

with child as (
    select stock_code as from_field
    from "ecom"."public"."int_orders_enriched"
    where stock_code is not null
),

parent as (
    select id as to_field
    from "ecom"."public"."dim_products"
)

select
    from_field

from child
left join parent
    on child.from_field = parent.to_field

where parent.to_field is null



  
  
      
    ) dbt_internal_test