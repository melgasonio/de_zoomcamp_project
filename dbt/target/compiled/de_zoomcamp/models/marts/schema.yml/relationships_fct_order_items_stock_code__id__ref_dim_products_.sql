
    
    

with child as (
    select stock_code as from_field
    from "ecom"."public"."fct_order_items"
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


