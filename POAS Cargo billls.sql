SELECT DISTINCT
	inv.invoice_no,
    inv.control_no,
    invoice_types.invoice_name AS invoice_type,
	CASE WHEN inv.status = 800 THEN 'Not Approved'
			WHEN inv.status = 801 THEN 'Approved'
            WHEN inv.status = 802 THEN 'Submited to Gateway'
            WHEN inv.status = 803 THEN 'Waiting Control Number'
            WHEN inv.status = 804 THEN 'Gateway Submission Failed'
            WHEN inv.status = 805 THEN 'Paid'
            WHEN inv.status = 806 THEN 'Partial Paid'
            WHEN inv.status = 807 THEN 'Not Paid'
            WHEN inv.status = 808 THEN 'Canceling'
            WHEN inv.status = 809 THEN 'Cancel Pending'
            WHEN inv.status = 810 THEN 'Cancelled'
            WHEN inv.status = 811 THEN 'Cancel Failed'
            WHEN inv.status = 812 THEN 'Fail to obtain Control Number'
            WHEN inv.status = 813 THEN 'Cleared'
            WHEN inv.status = 814 THEN 'Rejected'
            WHEN inv.status = 815 THEN 'Expired'
            WHEN inv.status = 816 THEN 'Exempted'
            END AS status,
    inv.created_at,
    inv.generated_time,
    inv.call_id,
    inv.iocd_num,
    it.qty1 Quantity,
    it.uom1 Unit,
    inv.entry_pass_id,
    ports.name PortName,
    stations.name Station,
    vessels.full_name VesselName,
    agents.agent_name AgentName,
    app.name Creator,
    pre.name Approver,
    inv.exchange_rate ExRate,
    inv.currency InvoiceCurrency,
    inv.payment_currency CurrencyPaid,
    inv.total_vat Vat,
    inv.total_amount Total,
    inv.total_vated_amount GrandTotal,
    bill_amount,
    paid_amount
FROM
	all_invoices inv
    join invoice_types on invoice_types.id = inv.invoice_type_id
    join ports on inv.port_id = ports.id
    join stations on stations.id = ports.station_id
    left join vessel_calls calls on inv.call_id = calls.id
    left join invoice_items it on it.invoice_no=inv.invoice_no
    left join vessels on calls.vessel_id = vessels.id
    left join agents on agents.id = inv.agent_id
    left join users app on app.id = inv.approved_by
    left join users pre on pre.id = inv.prepared_by
    left join transaction_bills  bills on bills.transaction_code = inv.control_no
where
	generated_time between '2024-07-01 00:00:00' and '2025-06-30 23:59:59'
    AND invoice_type_id not in (3,8)
  