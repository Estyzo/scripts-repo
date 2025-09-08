SELECT
	entry_passes.id AS entry_pass_number,
	commodities.hscode,
    commodities.name AS cargo_name,
  --  cargo_class.name AS cargo_class,
    cargo_types.name cargo_type,
	entry_passes.cbm,
    entry_passes.weight_in_tonnes,
    weight_metric,
    entry_passes.quantity,
    entry_passes.description,
    entry_time,
   -- entry_passes.status AS entry_passes_status_code,
    CASE WHEN entry_passes.status = '202' THEN 'Short Landed'
        WHEN entry_passes.status = '203' THEN 'Over Landed'
        WHEN entry_passes.status = '204' THEN 'Excess Landed'
        WHEN entry_passes.status = '205' THEN 'Addition'
        WHEN entry_passes.status = '206' THEN 'Normal'
        WHEN entry_passes.status = '207' THEN 'Tally Approved'
        WHEN entry_passes.status = '208' THEN 'Tally Rejected'
        ELSE 'Tally Pending' END AS entry_passes_status,
   -- operation_type AS operation_type_code,
    CASE WHEN entry_passes.operation_type = '901' THEN 'Export' ELSE 'Import' END AS operation_type,
    customers.first_name,
	customers.last_name,
    countries.name AS country_name,
    vessels.full_name AS vessel_name,
    vessel_calls.arrival_time,
    vessel_calls.departure_time,
    collection_centers.name AS collection_center,
    stations.name Station
    -- sub_services.name AS service_name,
    -- entry_service.start_time AS service_start_time,
    -- entry_service.end_time AS service_end_time,
    -- entry_service.quantity AS service_qty,
    -- entry_service.status AS service_status,
    -- entry_service.offered_type
FROM
	entry_passes
    JOIN commodities ON commodities.hscode = entry_passes.hscode
	JOIN cargo_class ON cargo_class.id = commodities.cargo_class_id
    JOIN cargo_types ON cargo_types.id = commodities.cargo_type_id
    JOIN customers ON customers.id = entry_passes.customer_id
	JOIN countries ON countries.id = entry_passes.country_id
    LEFT JOIN vessel_calls ON vessel_calls.id = entry_passes.call_id
    LEFT JOIN vessels ON vessels.id = vessel_calls.vessel_id
    LEFT JOIN collection_centers on collection_centers.id = entry_passes.collection_center_id
   -- LEFT JOIN entrypass_service_offered entry_service ON entry_service.entry_pass_id = entry_passes.id
--	LEFT JOIN tariff_services ON tariff_services.id = entry_service.tariff_service_id
   -- LEFT JOIN sub_services ON sub_services.id = tariff_services.sub_service_id
    LEFT JOIN ports p on p.id=collection_centers.port_id
    left join stations on stations.id=p.station_id
WHERE
	entry_passes.entry_time BETWEEN '2024-07-01 00:00:00' AND '2025-06-30 23:59:59'
	