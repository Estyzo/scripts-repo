-- select manifest_id from manifests where manifest_reference_number='';
update consignments set discharge_status='COMPLETED' 
where manifest_id=(select manifest_id from manifests where manifest_reference_number='');

-- select consignment_id from consignments where manifest_id='1d01c29c-3ad2-4b94-935e-80b291fbf1e1';
update cargo_details set discharge_status='COMPLETED', discharged_quantity=1 
where consignment_id in (select consignment_id from consignments where manifest_id='');

INSERT INTO public.cargo_transactions(
			action_date, 
			created_date,
			crn,
			
			message_type, 
			mode_of_transport,
			movement_reference,
			
			mrn,
			number_of_package, 
			operator_code, 
			
			terminal_code,
			transaction_type, 
			vin,
			
			weight
	)
 

SELECT 
	CD.created_date,
	CD.created_date,
	CO.crn,	
	'DISCHARGE_REPORT', 
	'N/A',
	CD.cargo_detail_id,
	MN.manifest_reference_number,
	CD.discharged_quantity, 
	MN.terminal_operator,	
	MN.terminal,
	'MOVEMENT',
	CD.vehicle_vin,
	CD.net_weight
	FROM public.cargo_details CD 
	JOIN public.consignments CO
	ON CD.consignment_id = CO.consignment_id
	JOIN public.manifests MN 
	ON CO.manifest_id = MN.manifest_id
	WHERE MN.manifest_id = '1d01c29c-3ad2-4b94-935e-80b291fbf1e1';