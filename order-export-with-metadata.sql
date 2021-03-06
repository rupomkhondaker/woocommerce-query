select
    p.ID as order_id,
    DATE(p.post_date) as post_date,
	cpm.meta_value AS currency,
	 ( select group_concat( order_item_name separator '|' ) from wp_filn_woocommerce_order_items where order_id = p.ID ) as order_items,
    max( CASE WHEN pm.meta_key = '_order_tax' and p.ID = pm.post_id THEN pm.meta_value END ) as order_tax,
     DATE(max( CASE WHEN pm.meta_key = '_paid_date' and p.ID = pm.post_id THEN pm.meta_value END )) as paid_date,
    max( CASE WHEN pm.meta_key = '_order_total' and p.ID = pm.post_id THEN pm.meta_value END ) as order_total
from
    wp_filn_posts p 
	JOIN wp_filn_postmeta cpm ON p.ID = cpm.post_id
    JOIN wp_filn_postmeta pm on p.ID = pm.post_id
    JOIN wp_filn_woocommerce_order_items oi on p.ID = oi.order_id
	
where
    post_type = 'shop_order' and
    post_date BETWEEN '2021-06-01' AND '2021-06-30' and
    post_status = 'wc-completed' AND 
    cpm.meta_key = '_order_currency' AND
    cpm.meta_value = 'USD'
	
group by
    p.ID
