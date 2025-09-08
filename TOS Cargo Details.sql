SELECT
    decleared.BLNumber,
    decleared.BLType,
    decleared.Calluid,
    decleared.LoadPort,
    decleared.Dischargeport,
    decleared.Consignee,
    CFA.FirstName AS CFACode,
    CFA.MiddleName AS CFAName,
    decleared.Terminal,
    decleared.BLStatus,
    decleared.TradeType,
    decleared.BlPackingType,
    decleared.Crn,
    Cargo.CargoType,
    Cargo.PackingType,
    Cargo.GCType,
    Cargo.CargoStatus,
    Cargo.ContainerId,
    Cargo.CONTISO,
    Cargo.ContainerLength,
    Cargo.FullOrEmpty,
    Cargo.ContLoadStatus,
    Cargo.ContGrossWeight,
    Cargo.MVVIN,
    Cargo.MVMake,
    Cargo.MVModel,
    Cargo.GCSpec,
    Cargo.GCDescription,
    Cargo.GCVolume,
    Cargo.QtyUnit,
    Cargo.QtyOrdered,
    Cargo.CargoWeight,
    Cargo.WeightUnit,
    discharged.QuantityHandled AS DischargeQty,
    discharged.[Status] AS DischargeStatus,
    delivery.QuantityHandled AS DeliveryQty,
    delivery.[Status] AS DeliveryStatus,
    reception.QuantityHandled AS ExportRecvQty,
    reception.[Status] AS ExportRecvtatus,
    stauffing.QuantityHandled AS StauffingQty,
    stauffing.[Status] AS StauffingStatus,
    loading.QuantityHandled AS LoadingQty,
    loading.[Status] AS LoadingStatus
FROM
    BLInfo decleared
JOIN 
    Cargo ON Cargo.BLID = decleared.BLID
LEFT JOIN 
    CargoTally discharged ON discharged.CargoID = Cargo.CargoID AND discharged.BLMovementType = 'DIS'
LEFT JOIN 
    CargoTally delivery ON delivery.CargoID = Cargo.CargoID AND delivery.BLMovementType = 'DEL'
LEFT JOIN 
    CargoTally reception ON reception.CargoID = Cargo.CargoID AND reception.BLMovementType = 'REC'
LEFT JOIN 
    CargoTally stauffing ON stauffing.CargoID = Cargo.CargoID AND stauffing.BLMovementType = 'STU'
LEFT JOIN 
    CargoTally loading ON loading.CargoID = Cargo.CargoID AND loading.BLMovementType = 'LOD'
LEFT JOIN 
    BLInfo del ON del.BLID = delivery.BLID
OUTER APPLY (
    SELECT FirstName, MiddleName
    FROM Organization
    WHERE OrgId = 
        CASE 
            WHEN decleared.BLType = 'REC' THEN decleared.CFA
            WHEN del.BLType = 'DEL' THEN del.CFA
            ELSE NULL
        END
) CFA
WHERE
    (
        discharged.HandledTime BETWEEN '2024-07-01 00:00:00' AND '2025-06-30 23:59:59'
        OR
        reception.HandledTime BETWEEN '2024-07-01 00:00:00' AND '2025-06-30 23:59:59'
    )
    AND decleared.BLType IN ('DIS', 'REC')
