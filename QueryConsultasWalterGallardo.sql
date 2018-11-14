use usairlineflights;
/*1.Quantitat de registres de la taula de vols:*/ 
select count(*) from flights;

/*2. Retard promig de sortida i arribada segons l’aeroport origen*/

select origin , avg(ArrDelay) as ArrivalDelay , avg(DepDelay) as DepartureDelay 
From flights 
group by origin

/* 3.Retard promig d’arribada dels vols, per mesos i segons l’aeroport origen. */

select origin, colYear as Year , colMonth as Month,
 if(ArrDelay >0 , "Retard","") as Estatus
From flights a
where ArrDelay > 0
group by origin

/*4.Retard promig d’arribada dels vols, per mesos i segons l’aeroport origen
(mateixa consulta que abans i amb el mateix ordre).
 Però a més, ara volen que en comptes del codi de l’aeroport es mostri el nom de la ciutat. */
 
select b.city, b.iata as AirportOrigen,a.colYear as Year ,  a.colMonth as Month,
if(a.ArrDelay >0 , "Retard","") as Estatus
From flights as a inner join usairports as b  on a.Origin=b.IATA
where  a.ArrDelay > 0
group by b.Airport
 
 /*5.Les companyies amb més vols cancelats. 
 A més, han d’estar ordenades de forma que les companyies amb més cancelacions apareguin les primeres. */
 
 Select a.Description as Companys, count(b.Cancelled) as VolsCancelled
 from carriers as a
 inner join flights as b 
 on a.CarrierCode=b.UniqueCarrier
 where b.Cancelled=1
 group by a.Description
 order by VolsCancelled desc
 
  
 
/*6.L’identificador dels 10 avions que més distància han recorregut fent vols. */


Select  TailNum, sum(Distance) as TotalDistance
from flights 
group by TailNum
order by TotalDistance desc
limit 10




/*Companyies amb el seu retard promig només d’aquelles les quals els seus vols arriben
 al seu destí amb un retràs promig major de 10 minuts. */
 
Select a.Description as Company , avg(b.ArrDelay) as Arrival
from flights as  b
inner join carriers as a
on a.CarrierCode=b.UniqueCarrier
group by a.Description
having Arrival > 10






