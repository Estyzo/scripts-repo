select distinct
final.InvoiceNumber CreditNote,
final.InvStatus,
final.ExchangeGrandTotal,
final.blnumber,
final.Terminal,
final.vesselcallid,
final.BLType,
final.ExchangeCurrency,
final.ActualInvNumber interim,
interim.ExchangeGrandTotal,
interim.ExchangeCurrency
from IPInvoiceHeader final
 left join IPInvoiceHeader interim on interim.InvoiceNumber=final.ActualInvNumber 
where final.InvType='C'
and final.ApprovalDate BETWEEN '2024-07-01 00:00:00' and '2025-06-30 23:59:59'
;
