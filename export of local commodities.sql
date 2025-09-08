select DISTINCT 
BLNumber,
BLMovementType,
CT.CallUID,
C.Terminal,
HandledTime,
C.TotalQtyHandled,
QtyUnit,
fullorempty,
contloadstatus,
WeightUnit,
ContainerId,
ContainerLength,
CargoWeight,
GCDescription,
loadport,
dischargeport,
placeoforigin,
placeofdestination,
consignee,
transitornot
from Cargo C
JOIN CargoTally CT  ON C.CargoID=CT.CargoID
JOIN BLInfo B ON B.BLID=C.BLID
 where  BLMovementType IN('dis')
 AND HandledTime BETWEEN '2024-07-01 00:00:00' AND '2025-06-30 23:59:59'
 AND CargoStatus='EXE'
 and cargotype<>'cn'
-- and fullorempty<>'E'
 --and transitornot='local'
 -- AND GCDescription LIKE '%COFFEE%'
 ORDER BY BLNumber,BLMovementType
;

--remove coffee table
--select top 10  *from cargo 