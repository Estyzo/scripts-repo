SELECT
	full_name AS vesselName,
    registration_num,
    short_name,
    gross_tonnage,
    net_tonnage,
    loa,
    vessel_types.name AS VesselType,
    vessel_group,
    CASE WHEN vessel_group = '130' THEN 'Deep Sea'
		WHEN vessel_group = '131' THEN 'Coaster'
        WHEN vessel_group = '132' THEN 'Demostic'
        ELSE 'Non Demostic' END AS vessel_group_desc,
    owner,
    draft,
    reg.name as RegistrationCountry,
    imo_num,
    call_sign,
    zone,
    pre_arrival_time,
    arrival_time,
    payment_option,
    CASE WHEN payment_option = '50' THEN 'Normal Payment'
		WHEN payment_option = '51' THEN 'Pre Payment'
        ELSE 'Post Payment' END AS payment_option_desc,
    departure_time,
    agents.agent_name,
    last_visit_port,
    lastvisit.name AS last_visit_port_name,
    destination_port,
    destination.name destination_port_name,
    entry_draft,
    entry_crew,
    exit_draft,
    exit_crew,
    vessel_calls.status AS callStatus,
    CASE WHEN vessel_calls.status = '700' THEN 'Active'
		WHEN vessel_calls.status = '701' THEN 'Registered'
        WHEN vessel_calls.status = '702' THEN 'Executed'
        ELSE 'Cancelled' END AS callStatusName,
    berth_id,
    berths.name AS berthName,
    discharge_tonnage,
    loading_tonnage,
    sub_services.name AS service_name,
    vessel_service.start_time AS service_start_time,
    vessel_service.end_time AS service_end_time,
    vessel_service.quantity AS service_qty,
    vessel_service.status AS service_status,
    CASE WHEN vessel_service.status = '820' THEN 'Service Billed' ELSE 'Service Cancelled' END AS service_status_name,
    vessel_service.offered_type
FROM
	vessel_calls
    JOIN vessels ON vessels.id = vessel_calls.vessel_id
    JOIN vessel_types ON vessel_types.id = vessels.vessel_type_id
    JOIN countries reg ON reg.id = vessels.country_id
    JOIN agents ON agents.id = vessel_calls.agent_id
    JOIN berths ON berths.id = vessel_calls.berth_id
    JOIN ports lastvisit ON lastvisit.id = last_visit_port
    JOIN ports destination ON destination.id = destination_port
    LEFT JOIN marine_service_offered vessel_service ON vessel_service.call_id = vessel_calls.id
	LEFT JOIN tariff_services ON tariff_services.id = vessel_service.tariff_service_id
    LEFT JOIN sub_services ON sub_services.id = tariff_services.sub_service_id
WHERE
	vessel_calls.created_at BETWEEN '2024-07-01 00:00:00' AND '2025-06-30 23:59:59'


