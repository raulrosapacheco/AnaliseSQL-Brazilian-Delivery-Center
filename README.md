# AnaliseSQL-Brazilian-Delivery-Center
 
Análise de Dados usando linguaguem SQL

Fonte de Dados: Delivery Center: Food & Goods orders in Brazil. 
Com seus diversos hubs operacionais espalhados pelo Brasil, o Delivery Center é uma plataforma integra lojistas e marketplaces, criando um ecossistema para vendas de good (produtos) e food (comidas) no varejo brasileiro.
Os dados utilizados nesse projeto estão disponíveis na plataforma Kaggle em: https://www.kaggle.com/datasets/nosbielcs/brazilian-delivery-center 

Descrição dos datasets
- channels: Este dataset possui informações sobre os canais de venda (marketplaces) onde são vendidos os good e food.
- deliveries: Este dataset possui informações sobre as entregas realizadas.
- drivers: Este dataset possui informações sobre os entregadores parceiros. 
- hubs: Este dataset possui informações sobre os hubs do Delivery Center (centros de distribuição dos pedidos).
- orders: Este dataset possui informações sobre as vendas processadas através da plataforma do Delivery Center.
- payments: Este dataset possui informações sobre os pagamentos realizados ao Delivery Center.
- stores: Este dataset possui informações sobre os lojistas que utilizam a Plataforma do Delivery Center para vender seus itens (good e/ou food) nos marketplaces.

As Perguntas Negócio foram desenvolvidas pelo curso SQL Para Data Science da Data Science Academy: https://www.datascienceacademy.com.br/course/sql-para-data-science-dsa
1. Qual o número de hubs por cidade?
2. Qual o número de pedidos (orders) por status?
3. Qual o número de lojas (stores) por cidade dos hubs?
4. Qual o maior e o menor valor de pagamento (payment_amount) registrado?
5. Qual tipo de driver (driver_type) fez o maior número de entregas?
6. Qual a distância média das entregas por tipo de driver (driver_modal)?
7. Qual a média de valor de pedido (order_amount) por loja, em ordem decrescente?
8. Existem pedidos que não estão associados a lojas? Se caso positivo, quantos?
9. Qual o valor total de pedido (order_amount) no channel 'FOOD PLACE'?
10. Quantos pagamentos foram cancelados (chargeback)?
11. Qual foi o valor médio dos pagamentos cancelados (chargeback)?
12. Qual a média do valor de pagamento por método de pagamento (payment_method) em ordem decrescente?
13. Quais métodos de pagamento tiveram valor médio superior a 100?
14. Qual a média de valor de pedido (order_amount) por estado do hub (hub_state), segmento da loja (store_segment) e tipo de canal (channel_type)?
15. Qual estado do hub (hub_state), segmento da loja (store_segment) e tipo de canal (channel_type) teve média de valor de pedido (order_amount) maior que 450?
16. Qual o valor total de pedido (order_amount) por estado do hub (hub_state), segmento da loja (store_segment) e tipo de canal (channel_type)? Demonstre os totais intermediários e formate o resultado.
17. Quando o pedido era do Hub do Rio de Janeiro (hub_state), segmento de loja 'FOOD', tipo de canal Marketplace e foi cancelado, qual foi a média de valor do pedido (order_amount)?
18. Quando o pedido era do segmento de loja 'GOOD', tipo de canal Marketplace e foi cancelado, algum hub_state teve total de valor do pedido superior a 100.000?
19. Em que data houve a maior média de valor do pedido (order_amount)?
20. Em quais datas o valor do pedido foi igual a zero (ou seja, não houve venda)? 

