SELECT
    p.ID AS order_id,
    concat(max( CASE WHEN pm.meta_key = '_billing_first_name'  AND p.ID = pm.post_id THEN pm.meta_value END )," ",max( CASE WHEN pm.meta_key = '_billing_last_name'   AND p.ID = pm.post_id THEN pm.meta_value END ) ) as 'Customer Name',
    DATE(p.post_date) AS post_date,
    cpm.meta_value AS currency,
    (SELECT GROUP_CONCAT(order_item_name SEPARATOR '|') FROM wp_filn_woocommerce_order_items WHERE order_id = p.ID) AS order_items,
    ( select wtr.tax_rate_name from wp_filn_woocommerce_tax_rates wtr where (max( CASE WHEN pm.meta_key = '_shipping_state' and p.ID = pm.post_id THEN pm.meta_value END )) = wtr.tax_rate_state ) as 'Tax Name',
    MAX(CASE WHEN pm.meta_key = '_order_tax' AND p.ID = pm.post_id THEN pm.meta_value END) AS order_tax,
    DATE(MAX(CASE WHEN pm.meta_key = '_paid_date' AND p.ID = pm.post_id THEN pm.meta_value END)) AS paid_date,
    MAX(CASE WHEN pm.meta_key = '_order_total' AND p.ID = pm.post_id THEN pm.meta_value END) AS order_total
    
FROM
    wp_filn_posts p 
    JOIN wp_filn_postmeta cpm ON p.ID = cpm.post_id
    JOIN wp_filn_postmeta pm ON p.ID = pm.post_id
    JOIN wp_filn_woocommerce_order_items oi ON p.ID = oi.order_id
WHERE
    p.post_type = 'shop_order' AND
    p.post_date BETWEEN '2022-07-01' AND '2023-07-01' AND
    p.post_status = 'wc-completed' AND 
    cpm.meta_key = '_order_currency' AND
    cpm.meta_value = 'CAD'

GROUP BY 
    order_id;
//*****------------------------------------------------------
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


##--------------------------------------------------------------------------------
select
	p.ID as order_id,
	DATE(p.post_date) as order_created_on,
	cpm.meta_value AS currency,   
        concat(max( CASE WHEN pm.meta_key = '_billing_first_name'  AND p.ID = pm.post_id THEN pm.meta_value END )," ",max( CASE WHEN pm.meta_key = '_billing_last_name'   AND p.ID = pm.post_id THEN pm.meta_value END ) ) as 'Customer Name',
	( select group_concat( order_item_name separator '|' ) from wp_filn_woocommerce_order_items where order_id = p.ID ) as order_items,
	( select wtr.tax_rate_name from wp_filn_woocommerce_tax_rates wtr where (max( CASE WHEN pm.meta_key = '_shipping_state' and p.ID = pm.post_id THEN pm.meta_value END )) = wtr.tax_rate_state ) as Tax Name,
	max( CASE WHEN pm.meta_key = '_order_tax' and p.ID = pm.post_id THEN pm.meta_value END ) as order_tax,
	DATE(max( CASE WHEN pm.meta_key = '_paid_date' and p.ID = pm.post_id THEN pm.meta_value END )) as paid_on,
	max( CASE WHEN pm.meta_key = '_order_total' and p.ID = pm.post_id THEN pm.meta_value END ) as order_total
from
	wp_filn_posts p 
	JOIN wp_filn_postmeta cpm ON p.ID = cpm.post_id
	JOIN wp_filn_postmeta pm on p.ID = pm.post_id
	JOIN wp_filn_woocommerce_order_items oi on p.ID = oi.order_id

where
	post_type = 'shop_order' and
	post_date BETWEEN DATE '2022-01-01' AND '2022-01-05' and
	cpm.meta_key = '_order_currency' AND
	post_status = 'wc-completed' AND 
	cpm.meta_value = 'CAD'
group by
p.ID
	
select
    p.ID as order_id,
    p.post_date,
    max( CASE WHEN pm.meta_key = '_billing_email' and p.ID = pm.post_id THEN pm.meta_value END ) as billing_email,
    max( CASE WHEN pm.meta_key = '_billing_first_name' and p.ID = pm.post_id THEN pm.meta_value END ) as _billing_first_name,
    max( CASE WHEN pm.meta_key = '_billing_last_name' and p.ID = pm.post_id THEN pm.meta_value END ) as _billing_last_name,
    max( CASE WHEN pm.meta_key = '_billing_address_1' and p.ID = pm.post_id THEN pm.meta_value END ) as _billing_address_1,
    max( CASE WHEN pm.meta_key = '_billing_address_2' and p.ID = pm.post_id THEN pm.meta_value END ) as _billing_address_2,
    max( CASE WHEN pm.meta_key = '_billing_city' and p.ID = pm.post_id THEN pm.meta_value END ) as _billing_city,
    max( CASE WHEN pm.meta_key = '_billing_state' and p.ID = pm.post_id THEN pm.meta_value END ) as _billing_state,
    max( CASE WHEN pm.meta_key = '_billing_postcode' and p.ID = pm.post_id THEN pm.meta_value END ) as _billing_postcode,
    max( CASE WHEN pm.meta_key = '_shipping_first_name' and p.ID = pm.post_id THEN pm.meta_value END ) as _shipping_first_name,
    max( CASE WHEN pm.meta_key = '_shipping_last_name' and p.ID = pm.post_id THEN pm.meta_value END ) as _shipping_last_name,
    max( CASE WHEN pm.meta_key = '_shipping_address_1' and p.ID = pm.post_id THEN pm.meta_value END ) as _shipping_address_1,
    max( CASE WHEN pm.meta_key = '_shipping_address_2' and p.ID = pm.post_id THEN pm.meta_value END ) as _shipping_address_2,
    max( CASE WHEN pm.meta_key = '_shipping_city' and p.ID = pm.post_id THEN pm.meta_value END ) as _shipping_city,
    max( CASE WHEN pm.meta_key = '_shipping_state' and p.ID = pm.post_id THEN pm.meta_value END ) as _shipping_state,
    max( CASE WHEN pm.meta_key = '_shipping_postcode' and p.ID = pm.post_id THEN pm.meta_value END ) as _shipping_postcode,
    max( CASE WHEN pm.meta_key = '_order_total' and p.ID = pm.post_id THEN pm.meta_value END ) as order_total,
    max( CASE WHEN pm.meta_key = '_order_tax' and p.ID = pm.post_id THEN pm.meta_value END ) as order_tax,
    max( CASE WHEN pm.meta_key = '_paid_date' and p.ID = pm.post_id THEN pm.meta_value END ) as paid_date,
    ( select group_concat( order_item_name separator '|' ) from wp_woocommerce_order_items where order_id = p.ID ) as order_items
from
    wp_filn_posts p 
    join wp_filn_postmeta pm on p.ID = pm.post_id
    join wp_filn_woocommerce_order_items oi on p.ID = oi.order_id
where
    post_type = 'shop_order' and
    post_date BETWEEN '2015-01-01' AND '2015-07-08' and
    post_status = 'wc-completed' and
    oi.order_item_name = 'Product Name'
group by
    p.ID


//---------------------------Export Inventory-------------------------------
SELECT p.ID AS product_id, p.post_title AS product_name, pm1.meta_value AS stock_quantity
FROM wp_filn_posts p
INNER JOIN wp_filn_postmeta pm1 ON p.ID = pm1.post_id
INNER JOIN wp_filn_postmeta pm2 ON p.ID = pm2.post_id
WHERE p.post_type = 'product'
AND p.post_status = 'publish'
AND pm1.meta_key = '_stock'
AND pm2.meta_key = '_stock_status'


//----------------------------------------Inventory with variations-----------------

SELECT 
    p.ID AS item_id,
    p.post_title AS item_name,
    CASE 
        WHEN p.post_type = 'product_variation' THEN 
            (SELECT post_title FROM wp_filn_posts WHERE ID = p.post_parent) 
        ELSE p.post_title 
    END AS product_name,
    CASE 
        WHEN p.post_type = 'product_variation' THEN 'variation'
        ELSE 'product' 
    END AS item_type,
    pm_stock.meta_value AS stock_quantity,
    pm_status.meta_value AS stock_status,
    CASE 
        WHEN p.post_type = 'product_variation' THEN 
            (SELECT meta_value FROM wp_filn_postmeta WHERE post_id = p.post_parent AND meta_key = '_sku')
        ELSE pm_sku.meta_value
    END AS parent_sku,
    pm_sku.meta_value AS item_sku,
    pm_manage.meta_value AS manage_stock
FROM 
    wp_filn_posts p
LEFT JOIN 
    wp_filn_postmeta pm_stock ON p.ID = pm_stock.post_id AND pm_stock.meta_key = '_stock'
LEFT JOIN 
    wp_filn_postmeta pm_status ON p.ID = pm_status.post_id AND pm_status.meta_key = '_stock_status'
LEFT JOIN 
    wp_filn_postmeta pm_sku ON p.ID = pm_sku.post_id AND pm_sku.meta_key = '_sku'
LEFT JOIN 
    wp_filn_postmeta pm_manage ON p.ID = pm_manage.post_id AND pm_manage.meta_key = '_manage_stock'
WHERE 
    (p.post_type = 'product' OR p.post_type = 'product_variation')
    AND p.post_status = 'publish'
ORDER BY 
    product_name, item_type DESC, item_name;

