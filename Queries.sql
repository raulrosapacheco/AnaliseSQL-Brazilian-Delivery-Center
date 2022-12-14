# 1- Qual o número de hubs por cidade?
SELECT H.hub_city, COUNT(H.hub_id) qtdd_hub
FROM delivery.hubs H
GROUP BY H.hub_city
ORDER BY qtdd_hub DESC;

# 2- Qual o número de pedidos (orders) por status?
SELECT O.order_status, COUNT(O.order_id) qtdd_orders
FROM delivery.orders O
GROUP BY O.order_status
ORDER BY qtdd_orders;

# 3- Qual o número de lojas (stores) por cidade dos hubs?
SELECT H.hub_city, COUNT(S.store_id) qtdd_store
FROM delivery.hubs H 
RIGHT JOIN delivery.stores S ON H.hub_id = S.hub_id
GROUP BY H.hub_city;

# 4- Qual o maior e o menor valor de pagamento (payment_amount) registrado?
SELECT MAX(payment_amount) maximo, MIN(payment_amount) minimo
FROM delivery.payments;

# 5- Qual tipo de driver (driver_type) fez o maior número de entregas?
SELECT Dr.driver_type, COUNT(Dl.delivery_id) qtdd_deliveries
FROM delivery.drivers Dr
JOIN delivery.deliveries Dl ON Dr.driver_id = Dl.driver_id
GROUP BY Dr.driver_type
ORDER BY qtdd_deliveries DESC;

# 6- Qual a distância média das entregas por tipo de driver (driver_modal)?
SELECT Dr.driver_modal, ROUND(AVG(Dl.delivery_distance_meters),2) avg_distance
FROM delivery.drivers Dr
JOIN delivery.deliveries Dl ON Dr.driver_id = Dl.driver_id
GROUP BY Dr.driver_modal
ORDER BY avg_distance DESC;

# 7- Qual a média de valor de pedido (order_amount) por loja, em ordem decrescente?
SELECT S.store_name, ROUND(AVG(O.order_amount),2) avg_order_amount
FROM delivery.stores S
JOIN delivery.orders O ON S.store_id = O.store_id
GROUP BY S.store_name
ORDER BY avg_order_amount DESC;

# 8- Existem pedidos que não estão associados a lojas? Se caso positivo, quantos?
SELECT COALESCE(S.store_name, "Sem loja"), COUNT(O.order_id) contagem
FROM delivery.stores S
RIGHT JOIN delivery.orders O ON S.store_id = O.store_id
GROUP BY S.store_name
ORDER BY contagem DESC;	

# 9- Qual o valor total de pedido (order_amount) no channel 'FOOD PLACE'?
SELECT C.channel_name, ROUND(SUM(O.order_amount),2) sum_order_amount
FROM delivery.channels C
JOIN delivery.orders O ON C.channel_id = O.channel_id
WHERE C.channel_name = 'FOOD PLACE'
GROUP BY C.channel_name;

# 10- Quantos pagamentos foram cancelados (chargeback)?
SELECT payment_status, COUNT(payment_id)
FROM delivery.payments
WHERE payment_status = 'CHARGEBACK'
GROUP BY payment_status;

# 11- Qual foi o valor médio dos pagamentos cancelados (chargeback)?
SELECT payment_status, ROUND(AVG(payment_amount),2) avg_payment_amount
FROM delivery.payments
WHERE payment_status = 'CHARGEBACK'
GROUP BY payment_status;

# 12- Qual a média do valor de pagamento por método de pagamento (payment_method)
# em ordem decrescente?
SELECT payment_method, ROUND(AVG(payment_amount),2) avg_payment_amount
FROM delivery.payments
GROUP BY payment_method
ORDER BY avg_payment_amount;

# 13- Quais métodos de pagamento tiveram valor médio superior a 100?
SELECT payment_method, ROUND(AVG(payment_amount),2) avg_payment_amount
FROM delivery.payments
GROUP BY payment_method
HAVING avg_payment_amount > 100
ORDER BY avg_payment_amount;

# 14- Qual a média de valor de pedido (order_amount) por estado do hub (hub_state),
# segmento da loja (store_segment) e tipo de canal (channel_type)?
SELECT H.hub_state, S.store_segment, C.channel_type, ROUND(AVG(O.order_amount),2) avg_amount
FROM delivery.hubs H
JOIN delivery.stores S USING(hub_id)
JOIN delivery.orders O USING(store_id)
JOIN delivery.channels C USING(channel_id)
GROUP BY H.hub_state, S.store_segment, C.channel_type;

# 15- Qual estado do hub (hub_state), segmento da loja (store_segment) e tipo de canal
# (channel_type) teve média de valor de pedido (order_amount) maior que 300?
SELECT H.hub_state, S.store_segment, C.channel_type, ROUND(AVG(O.order_amount),2) avg_amount
FROM delivery.hubs H
JOIN delivery.stores S USING(hub_id)
JOIN delivery.orders O USING(store_id)
JOIN delivery.channels C USING(channel_id)
GROUP BY H.hub_state, S.store_segment, C.channel_type
HAVING avg_amount > 300;

# 16- Qual o valor total de pedido (order_amount) por estado do hub (hub_state),
# segmento da loja (store_segment) e tipo de canal (channel_type)? Demonstre os totais
# intermediários e formate o resultado.
SELECT 
	IF(GROUPING(H.hub_state), 'Total Hub State', hub_state) AS hub_state, 
    IF(GROUPING(store_segment), 'Total Segmento', store_segment) AS store_segment,
	IF(GROUPING(channel_type), 'Total Tipo de Canal', channel_type) AS channel_type,
	ROUND(SUM(O.order_amount),2) sum_amount
FROM delivery.hubs H
JOIN delivery.stores S USING(hub_id)
JOIN delivery.orders O USING(store_id)
JOIN delivery.channels C USING(channel_id)
GROUP BY H.hub_state, S.store_segment, C.channel_type WITH ROLLUP;


# 17- Quando o pedido era do Hub do Rio de Janeiro (hub_state), segmento de loja
# 'FOOD', tipo de canal Marketplace e foi cancelado, qual foi a média de valor do pedido (order_amount)?
SELECT H.hub_state, S.store_segment, C.channel_type, O.order_status, ROUND(AVG(O.order_amount),2) avg_amount
FROM delivery.hubs H
JOIN delivery.stores S USING(hub_id)
JOIN delivery.orders O USING(store_id)
JOIN delivery.channels C USING(channel_id)
WHERE H.hub_state = 'RJ'
AND S.store_segment = 'FOOD'
AND C.channel_type = 'MARKETPLACE'
AND O.order_status = 'CANCELED'
GROUP BY H.hub_state, S.store_segment, C.channel_type, O.order_status;

# 18- Quando o pedido era do segmento de loja 'GOOD', tipo de canal Marketplace e foi
# cancelado, algum hub_state teve total de valor do pedido superior a 100.000?
SELECT H.hub_state, S.store_segment, C.channel_type, O.order_status, ROUND(SUM(O.order_amount),2) sum_amount
FROM delivery.hubs H
JOIN delivery.stores S USING(hub_id)
JOIN delivery.orders O USING(store_id)
JOIN delivery.channels C USING(channel_id)
WHERE S.store_segment = 'GOOD'
AND C.channel_type = 'MARKETPLACE'
AND O.order_status = 'CANCELED'
GROUP BY H.hub_state, S.store_segment, C.channel_type, O.order_status
HAVING sum_amount > 100000;

# 19- Em que data houve a maior média de valor do pedido (order_amount)?
# Dica: Pesquise e use a função SUBSTRING().
SELECT SUBSTRING(order_moment_created, 1, 9) AS date_order, ROUND(AVG(order_amount),2) AS avg_order
FROM delivery.orders orders
GROUP BY date_order
ORDER BY avg_order DESC;


# 20- Em quais datas o valor do pedido foi igual a zero (ou seja, não houve venda)?
# Dica: Use a função SUBSTRING().
SELECT SUBSTRING(order_moment_created, 1, 9) AS date_order, MIN(order_amount) AS min_order
FROM delivery.orders orders
GROUP BY date_order
HAVING min_order = 0
ORDER BY date_order ASC;

