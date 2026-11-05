-- ============================================================
-- COMPRAFÁCIL | ESTUDIANTES - ESPACIOS PARA RESOLVER
-- Archivo 02/02 - 20 ejercicios DQL
-- Base de datos: comprafacil
-- Instrucciones: ejecutar primero el archivo 01_base_datos.sql.
-- Consultas 18, 19 y 20: obligatoriamente con subconsultas.
-- No modificar los datos semilla durante esta evaluacion.
-- Alias y etiquetas visibles al cliente pueden estar en espanol.
-- ============================================================

USE comprafacil;

-- EJEMPLO DE CLASE (no calificable)
SELECT
    p.id AS codigo_producto,
    p.name AS producto,
    p.active AS activo
FROM products AS p;


-- ------------------------------------------------------------
-- 01. Mostrar el código, nombre y correo de los empleados que pueden solicitar compras.
-- Escribe tu SELECT aqui:
SELECT
    e.code AS codigo_empleado,
    e.name AS empleado,
    e.email AS correo
FROM employees AS e
ORDER BY e.code;


-- ------------------------------------------------------------
-- 02. Mostrar los productos activos y su unidad de medida. Usar WHERE.
-- Escribe tu SELECT aqui:
SELECT
    p.sku AS sku,
    p.name AS producto,
    p.unit_of_measure AS unidad_medida
FROM products AS p
WHERE p.active = TRUE
ORDER BY p.sku;


-- ------------------------------------------------------------
-- 03. Listar órdenes con estado PARCIAL o EMITIDA. Usar OR.
-- Escribe tu SELECT aqui:
SELECT
    po.id AS codigo_orden,
    po.supplier_id AS codigo_proveedor,
    po.issued_at AS fecha_emision,
    po.status AS estado
FROM purchase_orders AS po
WHERE po.status = 'PARCIAL' OR po.status = 'EMITIDA'
ORDER BY po.id;


-- ------------------------------------------------------------
-- 04. Mostrar las solicitudes creadas entre el 1 y el 5 de septiembre de 2026. Usar BETWEEN.
-- Escribe tu SELECT aqui:
SELECT
    r.id AS codigo_solicitud,
    r.created_at AS fecha_creacion,
    r.status AS estado,
    r.justification AS justificacion
FROM requests AS r
WHERE r.created_at BETWEEN '2026-09-01 00:00:00' AND '2026-09-05 23:59:59'
ORDER BY r.created_at, r.id;


-- ------------------------------------------------------------
-- 05. Buscar productos cuyo nombre contenga Cable o Teclado. Usar LIKE.
-- Escribe tu SELECT aqui:
SELECT
    p.sku AS sku,
    p.name AS producto
FROM products AS p
WHERE p.name LIKE '%Cable%' OR p.name LIKE '%Teclado%'
ORDER BY p.sku;


-- ------------------------------------------------------------
-- 06. Mostrar cada solicitud con el empleado que la creó, su fecha y estado.
-- Escribe tu SELECT aqui:
SELECT
    r.id AS codigo_solicitud,
    e.name AS empleado,
    r.created_at AS fecha_creacion,
    r.status AS estado
FROM requests AS r
JOIN employees AS e ON r.employee_id = e.id
ORDER BY r.id;


-- ------------------------------------------------------------
-- 07. Mostrar cada orden de compra junto con el proveedor y la justificación de la solicitud que originó la orden.
-- Escribe tu SELECT aqui:
SELECT
    po.id AS codigo_orden,
    s.company_name AS proveedor,
    r.justification AS justificacion
FROM purchase_orders AS po
JOIN suppliers AS s ON po.supplier_id = s.id
JOIN requests AS r ON po.request_id = r.id
ORDER BY po.id;


-- ------------------------------------------------------------
-- 08. Mostrar productos y cantidades requeridas de cada solicitud. Usar JOIN.
-- Escribe tu SELECT aqui:
SELECT
    ri.request_id AS codigo_solicitud,
    p.name AS producto,
    ri.requested_quantity AS cantidad_requerida
FROM request_items AS ri
JOIN products AS p ON ri.product_id = p.id
ORDER BY ri.request_id, p.name;


-- ------------------------------------------------------------
-- 09. Contar las solicitudes por estado.
-- Escribe tu SELECT aqui:
SELECT
    r.status AS estado,
    COUNT(*) AS total_solicitudes
FROM requests AS r
GROUP BY r.status
ORDER BY total_solicitudes DESC, r.status;


-- ------------------------------------------------------------
-- 10. Calcular el valor total de cada orden sumando cantidad ordenada multiplicada por precio unitario.
-- Escribe tu SELECT aqui:
SELECT
    oi.order_id AS codigo_orden,
    SUM(oi.ordered_quantity * oi.unit_price) AS valor_total
FROM order_items AS oi
GROUP BY oi.order_id
ORDER BY oi.order_id;


-- ------------------------------------------------------------
-- 11. Mostrar cada recepción con su número de remisión y proveedor.
-- Escribe tu SELECT aqui:
SELECT
    rc.id AS codigo_recepcion,
    rc.delivery_note AS remision,
    s.company_name AS proveedor
FROM receipts AS rc
JOIN purchase_orders AS po ON rc.order_id = po.id
JOIN suppliers AS s ON po.supplier_id = s.id
ORDER BY rc.id;


-- ------------------------------------------------------------
-- 12. Mostrar los productos recibidos, su cantidad recibida y la remisión correspondiente.
-- Escribe tu SELECT aqui:
SELECT
    p.name AS producto,
    rci.received_quantity AS cantidad_recibida,
    rc.delivery_note AS remision
FROM receipt_items AS rci
JOIN receipts AS rc ON rci.receipt_id = rc.id
JOIN order_items AS oi ON rci.order_item_id = oi.id
JOIN request_items AS ri ON oi.request_item_id = ri.id
JOIN products AS p ON ri.product_id = p.id
ORDER BY rc.delivery_note, p.name;


-- ------------------------------------------------------------
-- 13. Calcular la cantidad pendiente por renglón de orden: cantidad ordenada menos lo recibido. Mostrar también los renglones sin recepción.
-- Escribe tu SELECT aqui:
SELECT
    oi.id AS codigo_renglon,
    oi.order_id AS codigo_orden,
    p.name AS producto,
    oi.ordered_quantity AS cantidad_ordenada,
    COALESCE(SUM(rci.received_quantity), 0) AS cantidad_recibida,
    oi.ordered_quantity - COALESCE(SUM(rci.received_quantity), 0) AS cantidad_pendiente
FROM order_items AS oi
JOIN request_items AS ri ON oi.request_item_id = ri.id
JOIN products AS p ON ri.product_id = p.id
LEFT JOIN receipt_items AS rci ON oi.id = rci.order_item_id
GROUP BY oi.id, oi.order_id, p.name, oi.ordered_quantity
ORDER BY oi.id;


-- ------------------------------------------------------------
-- 14. Contar las órdenes por proveedor, incluyendo proveedores que todavía no tienen órdenes.
-- Escribe tu SELECT aqui:
SELECT
    s.company_name AS proveedor,
    COUNT(po.id) AS total_ordenes
FROM suppliers AS s
LEFT JOIN purchase_orders AS po ON s.id = po.supplier_id
GROUP BY s.id, s.company_name
ORDER BY total_ordenes DESC, s.company_name;


-- ------------------------------------------------------------
-- 15. Mostrar empleados que hayan realizado dos o más solicitudes. Usar HAVING.
-- Escribe tu SELECT aqui:
SELECT
    e.name AS empleado,
    COUNT(r.id) AS total_solicitudes
FROM employees AS e
JOIN requests AS r ON e.id = r.employee_id
GROUP BY e.id, e.name
HAVING COUNT(r.id) >= 2
ORDER BY total_solicitudes DESC, e.name;


-- ------------------------------------------------------------
-- 16. Mostrar productos presentes en dos o más renglones de órdenes de compra.
-- Escribe tu SELECT aqui:
SELECT
    p.name AS producto,
    COUNT(oi.id) AS total_renglones
FROM products AS p
JOIN request_items AS ri ON p.id = ri.product_id
JOIN order_items AS oi ON ri.id = oi.request_item_id
GROUP BY p.id, p.name
HAVING COUNT(oi.id) >= 2
ORDER BY total_renglones DESC, p.name;


-- ------------------------------------------------------------
-- 17. Mostrar los tres renglones de órdenes con mayor valor total (cantidad por precio). Usar LIMIT.
-- Escribe tu SELECT aqui:
SELECT
    oi.id AS codigo_renglon,
    oi.order_id AS codigo_orden,
    oi.ordered_quantity AS cantidad,
    oi.unit_price AS precio_unitario,
    oi.ordered_quantity * oi.unit_price AS valor_total
FROM order_items AS oi
ORDER BY valor_total DESC, oi.id
LIMIT 3;


-- ------------------------------------------------------------
-- 18 | SUBCONSULTA. SUBCONSULTA: encontrar renglones cuyo precio unitario sea superior al precio unitario promedio.
-- Escribe tu SELECT aqui:
SELECT
    oi.id AS codigo_renglon,
    oi.order_id AS codigo_orden,
    oi.unit_price AS precio_unitario
FROM order_items AS oi
WHERE oi.unit_price > (SELECT AVG(unit_price) FROM order_items)
ORDER BY oi.unit_price DESC, oi.id;


-- ------------------------------------------------------------
-- 19 | SUBCONSULTA. SUBCONSULTA: listar productos que nunca han aparecido en una orden de compra. Usar NOT EXISTS.
-- Escribe tu SELECT aqui:
SELECT
    p.sku AS sku,
    p.name AS producto
FROM products AS p
WHERE NOT EXISTS (
    SELECT 1
    FROM request_items AS ri
    JOIN order_items AS oi ON ri.id = oi.request_item_id
    WHERE ri.product_id = p.id
)
ORDER BY p.sku;


-- ------------------------------------------------------------
-- 20 | SUBCONSULTA. SUBCONSULTA: listar proveedores que tengan al menos una orden PARCIAL. Usar IN.
-- Escribe tu SELECT aqui:
SELECT
    s.id AS codigo_proveedor,
    s.company_name AS proveedor
FROM suppliers AS s
WHERE s.id IN (
    SELECT po.supplier_id
    FROM purchase_orders AS po
    WHERE po.status = 'PARCIAL'
)
ORDER BY s.company_name;