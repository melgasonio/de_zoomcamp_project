
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

with child as (
    select stock_code as from_field
    from `de-zoomcamp-488912`.`de_zoomcamp`.`fct_order_items`
    where stock_code is not null
),

parent as (
    select id as to_field
    from `de-zoomcamp-488912`.`de_zoomcamp`.`dim_products`
)

select
    from_field

from child
left join parent
    on child.from_field = parent.to_field

where parent.to_field is null



  
  
      
    ) dbt_internal_test