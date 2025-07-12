with

orders as (

    select 
        customer_id,
        order_id,
        order_date
    from {{ref('stg_jaffle_shop__orders')}}
),

payments as (

    select
        order_id,
        sum(iff(lower(trim(payment_status)) = 'success', amount, 0)) amount

    from {{ref('stg_stripe__payments')}}

    group by all

)

select
    orders.order_id,
    orders.customer_id,
    orders.order_date,
    coalesce(payments.amount, 0) amount
from orders

left join payments
    on payments.order_id = orders.order_id