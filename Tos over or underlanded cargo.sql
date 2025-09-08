SELECT bl.BLNumber
      ,[BLMovementType]
      ,ct.[CallUID]    
      ,ct.Terminal
      ,[TotalQuantityOrdered]  
      ,[QuantityHandled]
      ,Over_UnderLnaded=(case when QuantityHandled>TotalQuantityOrdered then 'OverLanded' when QuantityHandled<TotalQuantityOrdered then 'UnderLanded' end  )
      ,[HandledTime]
      ,GCDescription
      ,GCType
      ,QtyUnit
      
      
     
  FROM [IPT_PRDN].[dbo].[CargoTally] ct
  join Cargo c on c.CargoID=ct.CargoID
  left join BLInfo bl on bl.BLID=ct.BLID
  where 
   (QuantityHandled>TotalQuantityOrdered or QuantityHandled<TotalQuantityOrdered)
  and HandledTime BETWEEN '2024-07-01 00:00' and '2025-06-30 23:59:59' and CallType='vs' and [Status]='exe'
  and QuantityHandled>0
;

