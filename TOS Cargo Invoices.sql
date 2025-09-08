SELECT distinct
    InvoiceNumber,
    ApprovalDate,
    InvStatus,
   -- CreationType,
    TotalAmount,
    VATAmount,
    GrandTotal,
    ExchangeRate,
    ExchangeTotalAmount,
    ExchangeVATAmount,
    ExchangeGrandTotal,
    IPInvoiceHeader.Terminal,
    BLInfo.BLNumber,
    BLInfo.BLType,
    IPInvoiceHeader.BLType,
    PaidAmount,
    PaidDate
FROM
    IPInvoiceHeader
    left JOIN IPInvLinks ON IPInvLinks.InvoiceHeaderId = IPInvoiceHeader.InvoiceHeaderId
   left JOIN BLInfo ON BLInfo.BLID = IPInvLinks.BLID
    LEFT JOIN IPPaymentHeader ON IPPaymentHeader.InvoiceHeaderId = IPInvoiceHeader.InvoiceHeaderId
WHERE
    ApprovalDate BETWEEN '2024-07-01 00:00:00' AND '2025-06-30 23:59:59'
    and IPInvoiceHeader.BLType not in ('stv','mar')
    and InvType='i'
    and InvStatus='app'
    and BLInfo.BLNumber is not  NULL
   
    order by InvoiceNumber


-- select *from IPInvoiceHeader WHERE
--     ApprovalDate BETWEEN '2024-07-01 00:00:00' AND '2025-06-30 23:59:59'
--     and IPInvoiceHeader.BLType not in ('stv','mar')
--     and InvType='i'