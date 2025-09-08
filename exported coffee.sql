select DISTINCT BLNumber,BLMovementType,CT.CallUID,C.Terminal,HandledTime,C.TotalQtyHandled,QtyUnit,WeightUnit,ContainerId,ContainerLength,CargoWeight,GCDescription from Cargo C
JOIN CargoTally CT  ON C.CargoID=CT.CargoID
JOIN BLInfo B ON B.BLID=C.BLID
 where  BLMovementType IN('lod')
 AND HandledTime BETWEEN '2024-07-01 00:00:00' AND '2025-06-30 23:59:59'
 AND CargoStatus='EXE' AND GCDescription LIKE '%COFFEE%'
 ORDER BY BLNumber,BLMovementType
;

--remove coffee table
