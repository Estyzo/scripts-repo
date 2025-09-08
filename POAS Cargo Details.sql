SELECT
	commodities.hscode,
    commodities.name AS cargo_name,
    cargo_class.name AS cargo_class,
    cargo_types.name cargo_type,
    cargos.cbm AS declared_cbm,
    cargos.weight_in_tonnes AS declared_weight,
    cargos.quantity AS declared_qty,
    cargos.tally_status AS cargo_tally_status_code,
    CASE WHEN cargos.tally_status = '100' THEN 'Pending'
		WHEN cargos.tally_status = '101' THEN 'Completed'
        WHEN cargos.tally_status = '102' THEN 'On Progress'
        WHEN cargos.tally_status = '103' THEN 'Wait For Amend'
        ELSE 'Tally Amended' END AS cargo_tally_status,
    discharge_tallies.cbm AS discharged_cbm,
    discharge_tallies.weight_in_tonness AS discharged_weight,
    discharge_tallies.quantity AS discharged_qty,
    discharge_tallies.approved_status AS discharge_status_code,
    CASE WHEN discharge_tallies.approved_status = '200' THEN 'Damaged'
        WHEN discharge_tallies.approved_status = '201' THEN 'OK'
        WHEN discharge_tallies.approved_status = '202' THEN 'Short Landed'
        WHEN discharge_tallies.approved_status = '203' THEN 'Over Landed'
        WHEN discharge_tallies.approved_status = '204' THEN 'Excess Landed'
        WHEN discharge_tallies.approved_status = '205' THEN 'Addition'
        WHEN discharge_tallies.approved_status = '206' THEN 'Normal'
        WHEN discharge_tallies.approved_status = '207' THEN 'Tally Approved'
        WHEN discharge_tallies.approved_status = '208' THEN 'Tally Rejected'
        ELSE 'Tally Pending' END AS discharge_status,
    receiving_import_tallies.cbm AS import_received_cbm,
    receiving_import_tallies.weight_in_tonnes AS import_received_weight,
    receiving_import_tallies.quantity AS import_received_qty,
    receiving_import_tallies.status AS import_received_status_code,
    CASE WHEN receiving_import_tallies.status = '200' THEN 'Damaged'
        WHEN receiving_import_tallies.status = '201' THEN 'OK'
        WHEN receiving_import_tallies.status = '202' THEN 'Short Landed'
        WHEN receiving_import_tallies.status = '203' THEN 'Over Landed'
        WHEN receiving_import_tallies.status = '204' THEN 'Excess Landed'
        WHEN receiving_import_tallies.status = '205' THEN 'Addition'
        WHEN receiving_import_tallies.status = '206' THEN 'Normal'
        WHEN receiving_import_tallies.status = '207' THEN 'Tally Approved'
        WHEN receiving_import_tallies.status = '208' THEN 'Tally Rejected'
        ELSE 'Tally Pending' END AS import_received_status,
    receiving_export_tallies.cbm AS export_received_cbm,
    receiving_export_tallies.weight_in_tonnes AS export_received_weight,
    receiving_export_tallies.quantity AS export_received_qtry,
    receiving_export_tallies.status AS export_received_status_code,
    CASE WHEN receiving_export_tallies.status = '200' THEN 'Damaged'
        WHEN receiving_export_tallies.status = '201' THEN 'OK'
        WHEN receiving_export_tallies.status = '202' THEN 'Short Landed'
        WHEN receiving_export_tallies.status = '203' THEN 'Over Landed'
        WHEN receiving_export_tallies.status = '204' THEN 'Excess Landed'
        WHEN receiving_export_tallies.status = '205' THEN 'Addition'
        WHEN receiving_export_tallies.status = '206' THEN 'Normal'
        WHEN receiving_export_tallies.status = '207' THEN 'Tally Approved'
        WHEN receiving_export_tallies.status = '208' THEN 'Tally Rejected'
        ELSE 'Tally Pending' END AS export_received_status,
    delivery_mode,
    container_no,
    container_size,
    container_type,
    vehicle.chasis_no,
    vehicle.make,
    vehicle.type,
    vehicle.model,
    cargos.cargo_status AS cargo_status_code,
    CASE WHEN cargos.cargo_status = '200' THEN 'Damaged'
        WHEN cargos.cargo_status = '201' THEN 'OK'
        WHEN cargos.cargo_status = '202' THEN 'Short Landed'
        WHEN cargos.cargo_status = '203' THEN 'Over Landed'
        WHEN cargos.cargo_status = '204' THEN 'Excess Landed'
        WHEN cargos.cargo_status = '205' THEN 'Addition'
        WHEN cargos.cargo_status = '206' THEN 'Normal'
        WHEN cargos.cargo_status = '207' THEN 'Tally Approved'
        WHEN cargos.cargo_status = '208' THEN 'Tally Rejected'
        ELSE 'Tally Pending' END AS cargo_status,
    collection_centers.name AS collection_center,
    iocds.status AS iocd_status_code,
    CASE WHEN cargos.cargo_status = '600' THEN 'Approved'
        WHEN cargos.cargo_status = '601' THEN 'Pending'
        WHEN cargos.cargo_status = '602' THEN 'Registered'
        WHEN cargos.cargo_status = '603' THEN 'Executed'
        WHEN cargos.cargo_status = '604' THEN 'Cancelled'
        WHEN cargos.cargo_status = '605' THEN 'Issued'
        ELSE 'Loaded' END AS iocd_status,
    iocds.operation_type AS operation_type_code,
    CASE WHEN iocds.operation_type = '901' THEN 'Export' ELSE 'Import' END AS operation_type,
    agents.agent_name,
    customers.first_name,
	customers.last_name,
    countries.name as customer_country,
    import_tran.transire_num AS import_transaire_num,
    import_tran.status AS import_transaire_status,
    export_tran.transire_num AS export_transaire_num,
    export_tran.status AS export_transaire_status,
    sub_services.name AS service_name,
    cargo_service.start_time AS service_start_time,
    cargo_service.end_time AS service_end_time,
    cargo_service.quantity AS service_qty,
    cargo_service.status AS service_status,
    CASE WHEN cargo_service.status = '820' THEN 'Service Billed' ELSE 'Service Cancelled' END AS service_status_name,
    cargo_service.offered_type
FROM 
	cargos
    JOIN commodities ON commodities.hscode = cargos.hscode
    JOIN cargo_class ON cargo_class.id = commodities.cargo_class_id
    JOIN cargo_types ON cargo_types.id = commodities.cargo_type_id
    LEFT JOIN iocds ON iocds.id = cargos.iocd_num
    LEFT JOIN collection_centers on collection_centers.id = iocds.collection_center_id 
    LEFT JOIN agents ON agents.id = iocds.agent_id
    LEFT JOIN transires import_tran ON import_tran.id = iocds.transire_id AND iocds.operation_type='900'
     LEFT JOIN transires export_tran ON export_tran.id = iocds.transire_id AND iocds.operation_type='901'
    JOIN customers ON customers.id = cargos.customer_id
    JOIN countries ON countries.id = customers.country_id
    LEFT JOIN container_details container ON container.cargo_id = cargos.id AND is_container = 1
    LEFT JOIN motor_vehicle_details vehicle ON vehicle.cargo_id = cargos.id AND is_motor_vehicle = 1
    LEFT JOIN cargo_service_offered cargo_service ON cargo_service.cargo_id = cargos.id
	LEFT JOIN tariff_services ON tariff_services.id = cargo_service.tariff_service_id
    LEFT JOIN sub_services ON sub_services.id = tariff_services.sub_service_id
    LEFT JOIN cargo_has_tally ON cargo_has_tally.cargo_id = cargos.id
    LEFT JOIN discharge_tallies ON discharge_tallies.tallies_id = cargo_has_tally.tally_id
    LEFT JOIN receiving_import_tallies ON receiving_import_tallies.tallies_id = cargo_has_tally.tally_id
    LEFT JOIN receiving_export_tallies ON receiving_export_tallies.tallies_id = cargo_has_tally.tally_id
WHERE
	cargos.created_at BETWEEN '2024-07-01 00:00:00' AND '2025-06-30 23:59:59'
