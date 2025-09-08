SELECT
	bl_num AS manual_bl_num_iocd,
    agents.agent_name,
    vessel_name,
    customers.first_name,
    customers.last_name,
    countries.name AS country_name,
    commodities.hscode,
    commodities.name AS cargo_name,
    cargo_class.name AS cargo_class,
    cargo_types.name cargo_type,
    weight_in_tonnes,
    cbm,
    quantity,
    weight_metric,
    sub_services.name AS service_name,
    cargo_service.start_time AS service_start_time,
    cargo_service.end_time AS service_end_time,
    cargo_service.name AS service_desc,
    cargo_service.status AS service_status,
    CASE WHEN cargo_service.status = '820' THEN 'Service Billed' 
		WHEN cargo_service.status = '821' THEN 'Service Cancelled' 
        ELSE cargo_service.status END AS service_status_name
    
FROM
	manual_cargo_handle
    JOIN agents ON agents.id = manual_cargo_handle.cfa_id
    JOIN customers ON customers.id = manual_cargo_handle.customer_id
    JOIN countries ON countries.id = manual_cargo_handle.country_id
    JOIN manual_cargo_details cargo ON cargo.manual_cargo_id = manual_cargo_handle.id
	JOIN commodities ON commodities.hscode = cargo.hscode
    JOIN cargo_class ON cargo_class.id = commodities.cargo_class_id
    JOIN cargo_types ON cargo_types.id = commodities.cargo_type_id
	LEFT JOIN manual_cargo_service_offered cargo_service ON cargo_service.cargo_handle = cargo.id
	LEFT JOIN tariff_services ON tariff_services.id = cargo_service.tariff_service_id
    LEFT JOIN sub_services ON sub_services.id = tariff_services.sub_service_id
WHERE
	manual_cargo_handle.created_at BETWEEN '2024-07-01 00:00:00' AND '2025-06-30 23:59:59'