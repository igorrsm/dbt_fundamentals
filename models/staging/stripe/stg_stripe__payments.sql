select
    id payment_id,
    orderid order_id,
    paymentmethod payment_method,
    status payment_status,
    amount,
    created
from {{source('stripe', 'payment')}}