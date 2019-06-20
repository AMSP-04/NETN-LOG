# NETN LOG

The NATO Education and Training Network Logistics Module (NETN LOG).

Copyright (C) 2019 NATO/OTAN.
This work is licensed under a [Creative Commons Attribution-NoDerivatives 4.0 International License](LICENSE.md).

## Background
Military logistics is the discipline of planning and carrying out the movement and maintenance of military forces including storage, distribution, maintenance and transportation of materiel.

## Description

This module is a specification of how to model logistics services in a federated distributed simulation. 

The specification is based on IEEE 1516 High Level Architecture (HLA) Object Model Template (OMT) and primarily intended to support interoperability in a federated simulation (federation) based on HLA. A Federation Object Model (FOM) Module is used to specify how data is represented and exchanged in the federation. The NETN LOG FOM module is available as an XML file for use in HLA based federations.

## Purpose

NETN LOG provides a common standard interface for negotiation, delivery, and acceptance of logistics services between federates modelling different entities involved in the service transaction. E.g simulation of the transport of a unit modelled in another simulator.

## Scope

NETN LOG covers the following services:

* Supply Service offered by a federate capable of simulating the transfer of supplies between consumer and provider.
* Transport Service offered by a federate capable of simulating loading, transport and/or unloading of non-consumable materiel.
* Repair Service offered by a federate capable of simulating repair of consumer provided non-consumable materiel, e.g platforms.

Examples of use:

* Refuelling of aircraft at an airbase or in the air
* Transport of supplies between facilities
* Repair of damaged platforms in a facility or by unit
* Transport of units, platforms, and humans by train, ship, or aircraft   		
# Overview
 
## Materiel
Materiel are classified as:
* Consumable Supplies
    * Ammunition
    * Mines
    * Medical materiel
    * Spare parts
    * NBC Materiel
    * Fuel (Diesel, Gas, Aviation fuel, etc.)
    * Water
    * Food
* Non-consumable Entities
    * Platforms
    * Humans
    * Units
    * Reconnaissance and Artillery systems (Radar)
    * Missile

Amount of supplies can be specified as a number of items, in cubic meters for liquid bulk goods and in kilograms for solid bulk goods. The type of packaging (fuel in canisters, water in bottles, etc.) is not included.

The type of supplies is based on the SISO-REF-010 standard. Additional supply types can be defined and documented in federation specific agreements.

## Logistics Service Pattern
All NETN LOG services are based on a Logistics Service Pattern that includes negotiation, delivery, and acceptance of logistics services. Federates participating in the logistics service transaction are either a Service Consumer or a Service Provider. 

The pattern defines sequences of service transactions between federates. These transactions are defined in the NETN LOG FOM Module as sub-classes of the `LOG_Service` interaction class. Although the interaction pattern for different types of services may vary slightly, the basic principles and interaction sequences are the same. 

<img src="./images/log_interactionclasses.png">

**Figure: Logistics Services Interaction Classes**

The interactions defined for the Logistics Service Pattern are extended by subclassing in order to provide more detail information required for specific logistics services.

<img src="./images/log_scp_phases.svg" width="1000px"/>

<!--```
DIAGRAM GENERATED IN https://sequencediagram.org/
autonumber 1
space
parallel 
Consumer->Provider: RequestService(ServiceID, ConsumerEntity, ProviderEntity, StartAppointment, RequestTimeOut)
note right of Provider:Multiple potential Providers \ncan receive the ServiceRequest.
parallel off
space
break time >= RequestTimeOut & no service offer
Consumer->Provider: CancelService(ServiceID)
end
space
parallel 
Provider->Consumer: OfferService(ServiceID, OfferID, ProviderEntity, OfferType, StartAppointment, OfferTimeOut)
note right of Provider:Multiple offers from the same and/or \ndifferent Providers are possible.
parallel off
space
opt time >= OfferTimeOut & offer not accepted
Provider->Consumer: CancelOffer(ServiceID, OfferID)
end
space
alt offer accepted
Consumer->Provider: AcceptOffer(ServiceID, OfferID)
else offer rejected
Consumer->Provider: RejectOffer(ServiceID, OfferID, Reason)
end
space
break Cancel before Delivery
Consumer<->Provider:CancelService(ServiceID, Reason)
end

space
abox over Consumer, Provider:Prepare for service Delivery
space
Consumer->Provider: ReadyToReceiveService(ServiceID)
Provider->Consumer: ServiceStarted(ServiceID)
space
loop until service delivered
abox over Consumer, Provider: Delivery of Service
break Cancel during Delivery

Consumer<->Provider:CancelService(ServiceID, Reason)
else Cancel by Provider
end
end
space
Provider->Consumer: ServiceComplete(ServiceID)
Consumer->Provider: ServiceReceived(ServiceID)
autonumber off
```-->
**Figure: Phases of the Logistics Service Pattern**

The logistics service pattern is divided into three phases:
**Service Negotiation**: the service is requested, offers received and offers are either accepted or rejected.

1. A consumer federate initiates service negotiation using `RequestService`. A unique ServiceID and a reference to a `ConsumerEntity` are required parameters. A reference to a specific `ProviderEntity` and a system wall-clock time for when offers are expected `RequestTimeOut` are optional.

    Requests for specific types of services are defined as subclasses to `RequestService` and include parameters for detailing the requirements of the request. This may include information when, where and how the service should be delivered.

2. If the time, specified in the `RequestTimeOut` parameter, pass without an offer is received, the consumer shall cancel the service using `CancelService`. A `ServiceID` parameter is required to indicate which service is cancelled. After the cancellation the logistics service pattern is terminated.

3. Offers are sent by potential providers using `OfferService` with a required parameter `ServiceID` referenceing the requested service and a unique `OfferID`. The provider can indicate if an complete, modified or no offer is made using the optional parameter `OfferType`. Optional parameters for `ProvidingEntity` and `OfferTimeOut` can be provided. 

4. The provider can cancel an offer using `CancelOffer` as long as it has not been accepted. Required parameters are the `ServiceID` and `OfferID`.

5. The consumer accepts an offer using `AcceptOffer` or 

6. Rejects an offer from a provider using `RejectOffer`. An optional `Reason` information can be provided.

7. Both consumer and provider can cancel the service before service delivery has started using `CancelService` with `ServiceID` and on optional `Reason` parameter. If cancelled the logistics pattern will also terminate.

**Service Delivery**: the consumer indicates that the delivery process can start, and the selected provider starts to deliver, continuing until all the services have been delivered.

8.  The consumer sends a `ReadyToReceiveService` message with `ServiceID` parameter to indicate readiness to start receiving the service. I.e, all neccesary preparations have been made to allow the `ConsumingEntity` to receive the service.

9. The provider sends a `ServiceStarted` message with `ServiceID` parameter to indicate that service delivery has started. This is sent only after receiving a `ReadyToReceiveService` notification from the consumer and after all preparations for have been made to allow the `ProvidingEntity` to deliver the service according to the offer.

10. Both consumer and provider can cancel the service during service delivery using `CancelService` with `ServiceID` and on optional `Reason` parameter. Cancellation during delivery will cause the logistics pattern to continue with Service Acceptance immediately even if not all of the agreed service have been delivered.

**Service Acceptance**: the provider or consumer indicates the completion of the service delivery and waits for acknowledgement/acceptance from the other part.

11. When service delivery is cancelled or completed the provider sends a `ServiceComplete` message with any additional parameters specifying the completeness of the delivery, e.g. if only part of a service was delivered.

12. When the service delivery has been accepted by the consumer a `ServiceReceived` message is sent.

# Transfer of Supplies

Federates can have the capability to provide and/or store supplies. These capabilities can be offered as services to other federates and involve the transfer of materiel between a `ConsumerEntity` and `ProviderEntity` modelled in two different federates. The transfer of supplies can differ in terms of the flow of materiel between consumer and provider. 

The supply service is based on the general Logistics Services Pattern but with some specific extensions.


<img src="./images/log_supply_sequence.svg" width="500px"/>

<!--```
autonumber 
Consumer->Provider:RequestSupply(..., StartAppointment, SuppliesData, TransferDirection)
Provider->Consumer:OfferSupply(..., StartAppointment, SuppliesData)
Consumer->Provider:AcceptOffer(...)
Consumer->Provider: ReadyToReceiveService(...)
Provider->Consumer:ServiceStarted(...)
loop Delivery of Service
alt TransferDirection=fromConsumer
aboxleft over Provider, Consumer: Transfer Supplies
else TransferDirection=fromProvider
aboxright over Provider, Consumer: Transfer Supplies
end
break Cancel during Delivery
Consumer<->Provider: CancelService(...)
end
end
Provider->Consumer:SupplyComplete(..., SuppliesData)
Consumer->Provider:ServiceReceived(...)
autonumber off
```-->

**Figure: Supply Service**

1. The consumer sends a `RequestSupply` interaction to request supplies. The amount and type of supplies are specified in the required `SuppliesData` parameter. An optional parameter `StartAppointment` specifies when and where the service delivery is expected. The `TransferDirection` parameter indicate if the transfer of supplies flows from consumer to provider or from provider to consumer.

2. An `OfferSupply` interaction is used by potential providers to offer supplies. The `SuppliesData` parameter specifies the amount and type of supplies included in the offer. The provider can also specify and alternate `StartAppointment` in the offer.

3. The consumer accepts an offer using `AcceptOffer` or rejects an offer from a provider using `RejectOffer`.

4. The `ReadyToReceiveService` interaction is used by a consumer to indicate that supply delivery can start. 

5. The `ServiceStarted` interaction is sent by the provider to notify that the transfer of supplies has started. 

6. If a `CancelService` occurs during delivery of a supply services, the actual amounts transferred can be less than agreed.

7. A `SupplyComplete` interaction is sent when the transfer of supplies is completed or after a cancellation. The actual amount of supplies transferred is provided as `SuppliesData` and should in the normal case be the same amounts as agreed in the offer. 

8. The consumer sends a `ServiceReceived` interaction as a response to a `SupplyComplete` from the provider. 

# Repair

<img src="./images/log_repair_sequence.svg" width="400px"/>

<!--```
autonumber 
Consumer->Provider:RequestRepair(..., RepairData, StartAppointment)
Provider->Consumer:OfferRepair(..., RepairData, StartAppointment)
Consumer->Provider:AcceptOffer(...)
Consumer->Provider: ReadyToReceiveService(...)
Provider->Consumer:ServiceStarted(...)
loop Delivery of Service
aboxleft over Provider, Consumer: Conduct Repair
break Cancel during Delivery
Consumer<->Provider: CancelService(...)
end
end
Provider->Consumer:RepairComplete(..., RepairData)
Consumer->Provider:ServiceReceived(...)
autonumber off
```-->
**Figure: Repair Service**

A repair can be performed on non-consumable materiel. E.g. damaged platforms can be moved to a maintenance facility for repair or units capable of providing repair services can move to the location of a damaged platform deliver repair services.

1. The consumer sends a `RequestRepair` interaction to request repair service. The materiel to be repaired and type of repair is specified in the required `RepairData` parameter. An optional parameter `StartAppointment` specifies when and where the service delivery is expected.

2. An `OfferRepair` interaction is used by potential providers of repair services. The `RepairData` parameter specifies the materiel and type of repair included in offer. The provider can also specify and alternate `StartAppointment` in the offer.

3. The consumer accepts an offer using `AcceptOffer` or rejects an offer from a provider using `RejectOffer`.

4. The `ReadyToReceiveService` interaction is used by a consumer to indicate that repairs can start. 

5. The `ServiceStarted` interaction is sent by the provider to notify that the repair has begun. 

6. If a `CancelService` occurs during delivery of a repair services, the actual completed repairs can be different from what was agreed.

7. A `RepairComplete` interaction is sent when the repair is completed or after a cancellation. The actual completed repairs is provided as `RepairData` and should in the normal case be the same as agreed in the offer. 

8. The consumer sends a `ServiceReceived` interaction as a response to a `RepairComplete` from the provider. 

# Transport

A logistics transport service is used when there is a need to move non-consumable entities such as platforms, units humans or other battlefield objects using means of transportation simulated in another federated system.

The transport service consists of the following phases in which the change of control over the entities differ:

* Embarkment is the process of mounting, loading and storing entities in a truck, convoy, ship, etc. Control over the entities is transferred from the service consumer to the transport service provider.

* Transport is the process of the transport moving entities from a point of departure to its destination. The provider of the transport service has control over the entities being transported. If required, the change of control over the entities can include a Transfer of Modelling Responsibility (NETN TMR).

* Disembarkment is the process of dismounting or unloading of entities. Control over materiel is transferred from the transport service provider back to the service consumer. 

<img src="./images/log_transport_service.svg" width="550px"/>

<!--```
autonumber 
Consumer->Provider:RequestTransport(..., TransportData, \nStartAppointment, EndAppointment)
Provider->Consumer:OfferTransport(..., TransportData, \nStartAppointment, EndAppointment, \nTransporters)
Consumer->Provider: AcceptOffer(...)
opt if StartAppointment
abox over Provider, Consumer: Prepare for Embarkment
end
Consumer->Provider: ReadyToReceiveService(...)
Provider->Consumer: ServiceStarted(...)
opt if StartAppointment
loop until all entities embarked
abox over Provider, Consumer:Embarkment
Provider->Consumer: TransportEmbarkmentStatus(..., EmbarkedObjects, TransportUnitIdentifier)
end
end
opt if EndAppointment
loop until at DisembarkmentAppointment
abox over Provider, Consumer:Transport
opt if TransportUnitDestroyed
Provider->Consumer: TransportDestroyedEntities(..., DestroyedObjects)
end
end
loop until all entities disembarked
abox over Provider, Consumer:Disembarkment

Provider->Consumer: TransportDisembarkmentStatus(..., DisembarkedObjects, TransportUnitIdentifier)
end
end
Provider->Consumer: ServiceComplete(...)
Consumer->Provider: ServiceReceived(...)
autonumber off
```-->
**Figure: Transport Service**

Negotiation, delivery, and acceptance of transport service are based on the Logistics Service Pattern:

1. To request a transport, the consumer sends a `RequestTransport` interaction that includes `TransportData` information specifying the entities to transport. If a `StartAppointment` is provided the service include embarkment of the entities at a specified time and location. If a `EndAppointment` is provided the service include the transport between the specified Start and End locations and subsequent disembarkment of specified entities.

2. An `OfferTransport` message is used by potential service providers to make an offer for transport. The offer includes information regarding which of the requested entities can be transported and appointment information for the transport. This offered `TransportData` information can that potentially differ from the requested `TransportData`. The offer also includes `Transporters` - a list of entities that will conduct the transport.

3. The consumer accepts an offer using `AcceptOffer` or rejects an offer from a provider using `RejectOffer`.

4. If a `StartAppointment` has been agreed all entities to be transported must be at the agreed embarkment location before a `ReadyToReceiveService` message is sent. If no `StartAppointment` has been agreed the consumer can send a `ReadyToReceiveService` immediately.

5. The delivery of the transport service starts when the provider sends a `ServiceStarted` message. 

6. During embarkment the provider informs the service consumer about the progress using `TransportEmbarkmentStatus` interactions indentifying which entities are embarked on which transport.

7. During transport the provider can inform the consumer about entities lost or destroyed using the `TransportDestroyedEntities` interaction. The `Status` attribute of embarked entities is set to `Inactive` during transport.

8. During disembarkment, the provider send `TransportDisembarkmentStatus` interactions to inform the consumer which entities have disembarked from which transport. Location of disembarked entities should be set to the location of `EndAppointment` and `Status` is set to `Active`.

9. The provider sends a `ServiceComplete` interaction after transport is complete and after any disembarkment of entities. 

10. The consumer sends a `ServiceReceived` as a response to the `ServiceComplete` interaction.

If a `CancelService` is sent by either consumer or provider, before `ReadyToReceiveService` and `ServiceStarted` has been sent, then the transport service delivery will not start and all involved entities remain in their current state.

If a `CancelService` is sent during delivery of the service but before starting to disembark, all entities already embarked or partially embarked remain on the transport. A new transport service can be used to continue embarking, and/or perform transport and disembarkment with the already embarked entities.

If a `CancelService` is sent during delivery of the service after starting to disembark, all entities not already disembarked or partially disembarked remain on the transport. To complete disembarkment, a new transport service can be requested with only `EndAppointment` and list of the remaining entities to disembark.

## Bridgehead

If a `NETN_Aggregate` unit is too large for transport, e.g. size of a unit requires multiple transports to be conducted, then the service consumer may require the unit to be disaggregated into subunits before requesting transport, using e.g. the NETN MRM FOM Module. If multiple transports are required, the consumer can create a temporary `NETN_Aggregate` entity to represent a bridgehead on the disembarkment location. The `Callsign`of the bridgehead should be the same as the aggregate being transported with a "-bh" suffix. 

When all subunits have embarked on transports the `Status` of the original `NETN_Aggregate` unit can be set to `Inactive` until all subunits have disembarked. 

When all subunits have disembarked from their transports the `Status` of the original `NETN_Aggregate` unit can be set to `Active` and the location set to the disembarkment position. Any bridgehead unit can be removed or status set to `Inactive`.

## Initial Transport State

A scenario can start with some entities already embarked on transports. The attribute `EmbeddedUnitList` of transporting entities identifies which units are already embarked by referenceing their UniqueId (UUID). The embarked units are published during the scenario initialization and their `Status` attribute should be set to `Inactive`.


 


