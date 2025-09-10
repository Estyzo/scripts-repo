UPDATE cargo_details cd
SET discharged_quantity = u.quantity
FROM consignments c
JOIN updatecrago u 
  ON c.master_bill_of_lading = u.blnumber
WHERE c.manifest_id = 'e1db59b0-c8e6-4c6f-a515-4f7b050ad094'
  AND cd.consignment_id = c.consignment_id;