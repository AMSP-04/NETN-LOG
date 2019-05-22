# NETN LOG
NATO Education and Training Network (NETN) Logistics FOM Module.

## Purpose


## Scope
The NETN Logistics covers the following services:
* Supply service is provided by a facility, a unit or entity with consumable materials supply capability. Resources are transferred from the providing unit to the consuming unit.
* Storage service is provided by a facility, a unit or entity with consumable materials storage capability. Resources are transferred from the consuming unit to the providing unit.
* Repair service can be performed on equipment (i.e. non-consumables items such as platforms) by facilities or units capable of performing the requested repairs. Modelling responsibility is by default not transferred from the consuming unit (e.g. a damaged platform) to the application with modelling responsibility for the providing unit (i.e. repairing facility). Modelling responsibility can be transferred with the inclusion of the Transfer of Modelling Responsibility (TMR) pattern.
* Transport service is provided by a facility, a unit or entity with transportation capability of non-consumable materials (units). Transported units are embarked, transported and disembarked. Modelling responsibility is by default not transferred from the consuming unit (transported unit) to the application with modelling responsibility for the providing unit (transporter). Modelling responsibility can be transferred with the introduction of the Transfer of Modelling Responsibility pattern.

**Examples of use**:

* Supply of fixed wing aircraft in airports or during aerial refuelling.
* Supply of helicopters in assembly areas.
* Repair of damaged platforms by a maintenance unit without changing platform's location.
* Maintenance of damaged platforms previously deposited in a facility.
* Transport of units, platforms, and humans by train, ship, or aircraft.
* Embarkment and disembarkment of units.

## Changelog
The NETN LOG module is a combination of AMSP-04 NETN FAFD Ed A v1.0 FOM modules NETN-Transport, NETN-Supply, NETN-Storage,  NETN-Repair and the supporting Service Consumer-Provider (SCP) FOM module. Renaming of elements have been made to better align with other NETN modules. The NETN LOG module is not backward compatible with previous NETN Logistics Modules and usage require minor updates to federates to use the new class names and structure.

# Overview
The NETN Logistics services are based on a Service Consumer-Provider Pattern. The pattern is described below and is implemented as base classes in the Logistics FOM Module. 

Detailed description of how these services map to the NETN Logistics FOM modules are included in this document. The NETN Logistics FOM module depends on RPR v2.0 FOM modules due to the fact that a few data types defined in these modules are reused in the definition of parameters for NETN Logistics interactions. 

In addition, a Transfer of Modelling Responsibility pattern is introduced as an option for some logistics services. 

Extensions to RPR v2.0 object classes are also defined. 

## Facilities

Facilities are the central element through which services are provided, e.g. material can be transferred to a consuming unit. Facilities may be created during a simulation or may be a part of the infrastructure (railway station, storage tanks depot, port, etc.). A facility may be part of a unit (e.g. ship).

<img src="/images/log_objects.png" width="50%">

The object class `LOG_Facility` extends the RPR-FOM v2.0 `EmbeddedSystem` by subclassing and defining attributes for a `StorageList` that specifies the materials that are located in the facility and an attribute `ServiceCapability`used to declare the service capabilities offered by the facility. Since the `LOG_Facility` object class inherits from `EmbeddedSystem` it can be associated to a RPR-FOM 2.0 entity using the `HostObjectIdentifier` and `RelativePosition` attributes. E.g. a facility can be placed on a surface vessel and act as a provider of supply and repair services.

## Logistics Service Pattern
The Logistics Service pattern is used for modelling request, negotiation and delivery of logistics services in a distributed federated simulation. Entities participating in the service transaction are considered as either a consumer or a service provider. When modelled in different simulation systems the consumer and provider use HLA interactions defined in the NETN LOG module to model the service transactions. The interaction patterns required for different types of services may vary but the basic principles and interaction class definitions are the same. 

The base classes for the Logistics Service Pattern are extended by subclassing to detail information required for specific logistics services.

<img src="/images/log_scp_interactions.png" width="50%">

The logistics service pattern is divided into three phases:
1.	**Service Negotiation**: the service is requested, offers received and offers are either accepted or rejected.
2.	**Service Delivery**: the consumer indicates that the deliver process can start, and the selected provider starts to deliver, continuing until all the services has been delivered.
3.	**Service Acceptance**: the provider or consumer indicates the completion of the service delivery and waits for acknowledgement/acceptance from the other part.

<img src="/images/log_scp_phases.png" width="50%">

### Service Request and Negotiation
Service Negotiation: the service is requested, offers received and offers are either accepted or rejected.

### Service Delivery
Service Delivery: the consumer indicates that the deliver process can start, and the selected provider starts to deliver, continuing until all the services has been delivered.

### Service Acceptance
Service Acceptance: the provider or consumer indicates the completion of the service delivery and waits for acknowledgement/acceptance from the other part.

## Supply and Storage Services

Services for resupply of consumable materials include:
* Supply services provided by a facility, a unit or an entity with consumable materials supply capability. Resources are transferred from the provider to the consumer of the service.
* Storage services are provided by a facility, a unit or entity with consumable materials storage capability. Resources are transferred from the consumer to the provider of the service.

These two services are different in terms of flow of materials between service consumer and provider. Both services follow the basic Service Consumer-Provider pattern to establish a service contract and a service delivery. 

Materials are differentiated between:
* Consumable materials:
    * Ammunition.
    * Mines.
    * NBC Materials.
    * Fuel (Diesel, Gas, Aviation fuel, etc.).
    * Water.
    * Food.
    * Medical materials.
    * Spare parts.
* Non-consumable materials:
    * Platforms.
    * Humans.
    * Aggregates.
    * Reconnaissance and Artillery systems (Radar).
    * Missile.

Consumable materials, hereafter also referred to as supplies, differ from non-consumables in that the former can be transferred to a unit, thereby "resupplying" that unit with the appropriate consumable material. Consumable materials are further differentiated between piece goods and bulk goods (e.g. fuel, water, decontamination means). Material may therefore be requested as individual pieces (each), or in cubic meters for liquid bulk goods and kilograms for solid bulk goods. The type of packaging (fuel in canisters, water in bottles, etc.) is not taken into account.

The definition of the type of the supply is based on the description in the Bit Encoded Values (SISO-REF-010) for Use with Protocols for Distributed Interactive Simulation Applications. Additional supply types shall be defined and specified in the Federation Agreement Document.

In both the Supply and Storage services the Consumer and Provider are specified and an optional `Appointment` parameter describes where and when the transfer of the consumable materials shall take place. The Provider can change the appointment data from the request, e.g. the Consumer does not specify the appointment data in the request interaction, thereafter the Provider specifies appointment data in the offer interaction, the Consumer than has to accept or reject the offer.

If the time specified in the `RequestTimeOut` parameter of the request passes without the Provider sending a positive offer, the Consumer shall cancel the service. The Consumer may then again initiate a request interaction.

The `LoadingDoneByProvider` parameter is used by the Consumer to propose whether the loading is controlled by the Provider or by the Consumer. This is an agreement between the parties and is specified in the offer from the Provider, which is accepted by the Consumer; the Provider can agree or disagree with the Consumer's proposal. By default the service delivery is controlled by the Provider.

If the service delivery is controlled by the Provider then the consuming entity shall issue a `LOG_ServiceReceived` interaction in response to the `LOG_SupplyComplete` or `LOG_StorageComplete` interaction. Transfer of supplies is considered as complete once the `LOG_ServiceReceived` interaction is issued. The `LOG_SupplyComplete` or `LOG_StorageComplete` interaction informs of the amount, by type, of supplies transferred.

If the service delivery is controlled by the Consumer then the providing entity shall issue a `LOG_SupplyComplete` or `LOG_StorageComplete` in response to the `LOG_ServiceReceived` interaction. Transfer of supplies is considered as complete once the `LOG_SupplyComplete` or `LOG_StorageComplete` is issued. The `LOG_SupplyComplete` or `LOG_StorageComplete` interaction informs of the amount, by type, of supplies transferred.

Early termination of the service request or delivery is possible by either the Consumer or Provider by a cancellation of the service. On early termination, no materials will be transferred. 

Rejection of a service offer is allowed. In this case, no material will be transferred.


### Supply Service
Materials will be transferred after the offer is accepted and the service is started. This service allows partial transfers. This implies that only some of the materials described in the service contract are transferred. The final requested amount of supplies, by type, is specified in the `LOG_ReadyToReceiveSupply` interaction and shall not exceed the amount of supplies, by type, specified in the `LOG_OfferSupply` interaction.

Figure 9-3 

To request supplies a `LOG_RequestSupply` interaction is used. The amount and type of requested materials are included as parameters. _In this request, the Consumer specifies a preference for whether the service delivery is controlled by the Provider (default) or by the Consumer._

A `LOG_OfferSupply` interaction is used by potential supplies to provide an offer, including the amount and type of offered materials, as a response to the requested supplies. _In this offer the provider can agree with the Consumer's choice of service delivery control or make a counter-offer._


`LOG_ReadyToReceiveSupply` is used by a Consumer to indicate that supply delivery can start.

If the transfer is controlled by the Provider then `LOG_SupplyComplete` is used by the Provider to inform the Consumer that the transfer is complete. The consuming entity shall send a `LOG_ServiceReceived` in response to the `LOG_SupplyComplete` interaction. Transfer of supplies is considered complete once the `LOG_ServiceReceived` is issued.

If the transfer is controlled by the Consumer then `LOG_ServiceReceived` is used by the Consumer to inform the Provider that the transfer is complete. The providing entity shall send a `LOG_StorageComplete` in response to the `LOG_ServiceReceived` interaction. Transfer of supplies is considered complete once the `LOG_StorageComplete` is issued.

The transfer may only be a part of the offered materials (partial transfer); the actual transferred supplies are specified in SuppliesData parameter of the `LOG_SupplyComplete` interaction. If requested materials are only partially transferred, the consumer may start another `LOG_RequestSupply` in order to obtain all desired supplies.

If the `LOG_CancelService` occurs between `LOG_ServiceStarted` and `LOG_SupplyComplete`, the Provider shall inform the Consumer of the amount of supplies transferred using `LOG_SupplyComplete` parameter `SuppliesData`. This allows for supply pattern interruptions due to operational necessity, death/destruction of either the consumer or provider during resupply, etc. Note that the updated supply amount(s) are subject to the constraint that the amount(s), by type, must be less than or equal to the amount(s), by type, of offered supplies.
 
Figure 9-4: OK Transfer of Resources, Provider Controls the Service Delivery.

The service can be cancelled by both the provider and the consumer with the `LOG_CancelService` interaction. If the service is cancelled before service delivery has started, the service transaction is terminated.
 
Figure 9-5: Early Cancellation, here by the Provider. Service is terminated.

If the service is cancelled during service delivery, the provider must inform the consumer of the amount and type of material transferred.
 
Figure 9-6: Cancellation by the Provider After the Service 
has Started, Provider Controls the Service Delivery.

The consumer can reject an offer from the provider and no more negotiations shall be done in the rejected service.
 
Figure 9-7: Consumer Rejects the Offer from the Provider.

The provider can inform the Consumer that it is not able to fulfil the required supply data.
 
Figure 9-8: Provider Sends a Negative Offer to the Consumer.


### Storage Service
Materials will be transferred after the offer is accepted and the service is started. This service allows partial transfers. This implies that only some of the materials described in the service contract are transferred. The final requested amount of stored supplies, by type, is specified in the `ReadyToReceiveStorage` interaction and shall not exceed the amount of supplies, by type, specified in the `OfferStorage` interaction.

Figure 9-9: Storage FOM Interaction Classes.

`RequestStorage` is used by a Consumer to initiate a request for storage of supplies. Amount and type of materials are included in the request.

`OfferStorage` is used by a Provider to indicate which (amount and type) of the requested materials can be stored.

`ReadyToReceiveStorage` is used by a Consumer to indicate that supply delivery can start.

`SCP_ServiceStarted` is used by a Provider to indicate that the storage of requested materials has started.

If the transfer is controlled by the Provider then `StorageComplete` is used by the Provider to inform the Consumer that the transfer is complete. The consuming entity shall send a `SCP_ServiceReceived` in response to the StorageComplete interaction. Transfer of supplies is considered complete once the `SCP_ServiceReceived` is issued.

If the transfer is controlled by the Consumer then `SCP_ServiceReceived` is used by the Consumer to inform the Provider that the transfer is complete. The providing entity shall send a StorageComplete as response to the `SCP_ServiceReceived` interaction. Transfer of supplies is considered complete once the `StorageComplete` is issued.

The transfer may only be part of the offered materials (partial transfer); the actual transferred supplies are specified in `SuppliesData` parameter of the `StorageComplete` interaction. If requested materials are only partially transferred, the consumer may start another `RequestStorage` in order to transfer all desired supplies.

If the `SCP_CancelService` occurs during `SCP_ServiceStarted` and `StorageComplete`, the Provider shall inform the Consumer of the amount of supplies transferred using StorageComplete parameter `SuppliesData`. This allows for supply pattern interruptions due to operational necessity, death/destruction of either the consumer or provider during storage actions, etc. Note that the updated supply amount(s) are subject to the constraint that the amount(s), by type, must be less than or equal to the amount(s), by type, of offered supplies.
 
Figure 9-10: OK Transfer of Resources, Provider Controls the Service Delivery.

The service can be cancelled by both the provider and the consumer with the `SCP_CancelService` interaction. If the service is cancelled before the service delivery has started, the service transaction is terminated.
 
Figure 9-11: Early Cancellation, here by the 
Consumer. The service is terminated.

If the service is cancelled during service delivery, the provider must inform the consumer of the amount and type of material transferred.
 
Figure 9-12: Cancellation by the Consumer After the Service 
has Started, Provider Controls the Service Delivery.

The consumer can reject an offer from the provider and no more negotiations shall be done in the rejected service.
 
Figure 9-13: Consumer Rejects the Offer from the Provider.

The provider can inform the Consumer that it is not able to fulfil the required supply data.
 
Figure 9-14: Provider Sends a Negative Offer to the Consumer.


## Maintenance and Repair Services
Repair service can be performed on equipment (i.e. non-consumables items such as platforms). Damaged platforms can be delivered to maintenance location or maintenance equipment can be moved to the requesting equipment. Providers of this service are facilities capable of performing requested repairs. The required effort for the repair of damaged material is determined by the providing model. It is calculated, based on the degree of damage to the material. If the consuming entity is an aggregate entity, its damaged equipment has to be listed in a platform list to get repaired.
 
Figure 9-15: Repair FOM Interaction Classes.

The service is initiated with a `RequestRepair` interaction, sent by a federate with modelling responsibility of damaged equipment (for example damaged platforms). The service provider offers the repair service by sending the `OfferRepair` interaction. The NETN Service Consumer-Provider interactions are used to complete the service.

The `RepairData`parameter in the request interaction is a list of equipment and type of repairs. The list of offered repairs may be different from the list of requested repairs. If the HLA object (equipment to be repaired) has a damaged state, the list of requested repairs could be empty. The providing federate models the efforts to repair a damaged platform.

The consuming entity shall send a `SCP_ServiceReceived` as a response to the `RepairComplete` interaction. The repair is considered as complete once the `SCP_ServiceReceived` is sent.

If the `SCP_CancelService` is sent either by the Consumer or Provider, before the service has started, no repair of equipment is done.

If the `SCP_CancelService` occurs during `SCP_ServiceStarted` and `RepairComplete`, the Provider shall inform the Consumer of the amount of repair done using `RepairComplete` parameter `RepairData`. This allows for interruptions due to operational necessity, e.g. death/destruction of either the consumer or provider during repair actions.

By default the Maintenance Pattern does not include a transfer of modelling responsibility of the damaged platform to the application with modelling responsibility for the repairing facility, but could be included in the service delivery if applications are aware of the Transfer of Modelling Responsibility (TMR) pattern.
 
Figure 9-16: OK Repair.

The service can be cancelled by both the provider and the consumer with the `SCP_CancelService` interaction. If the service is cancelled before service delivery has started, the service transaction is terminated.
 
Figure 9-17: Early Cancellation by the Provider.
 
Figure 9-18: Service Cancelled by the Consumer After Service Started.
 
Figure 9-19: Service Offer Rejected.
 
Figure 9-20: Provider Sends a Negative Offer to the Consumer.

###	Repair Types
The `NETN_RepairTypeEnum16` enumerated data type is defined in the NETN-Repair FOM and identifies a large set of repair types. These enumerations are also defined in the RPR-Enumerations FOM module. DIS does not define the enumerated values as part of the core specification.

In the RPR FOM modules values are defined as a fixed part of some enumerated data types. In order not to violate the modular FOM merging rules, the NETN Logistics FOM modules does not define any extensions to these data types as part of the FOM module. A separate table for adding values to the existing range of enumerations defined in the RPR FOM modules is allowed instead. This table shall be part of any federation specific agreements where extensions to an enumerated data type are required. It is also recommended but not required that any additional enumerated values added to this data type shall be submitted as Change Requests to the SISO RPR-FOM Product Development Group. All existing enumerators in RPR FOM modules and their values are reserved. Additional repair types are documented in the federation specific agreements.

 
## TRANSPORT PATTERN
1.	Transport services are used when there are needs to transport non-consumable materials such as platforms, units or battlefield entities. The providing federate models the transport. The Transport pattern follows the basic NETN Service Consumer-Provider pattern for establishing a service contract and a service delivery. Services for Transport include:
a.	Transport service provided by a facility, a unit or entity with transportation capability of storing and delivering non-consumable materials.
b.	Embarkment service provided by a facility, a unit or entity with transportation capability of storing non-consumable materials.
c.	Disembarkment service provided by a facility, a unit or entity with transportation capability of delivering non-consumable materials.
2.	Transport services differ in terms of the flow of units between service consumer and service provider:
a.	In Disembarkment service, units are transferred from a service provider to a service consumer.
b.	In Embarkment service, units are transferred from a service consumer to a service provider.
c.	The Transport service consists of both Embarkment and Disembarkment service.
3.	The Embarkment and Disembarkment services could also be extended to management of facilities; with the capability of delivering and storing non-consumable materials to/from other facilities, units or battlefield entities. The Transport pattern includes an optional Transfer of Modelling Responsibility mechanism between a service consumer and a service provider (see Transfer of Modelling Responsibility).
 
Figure 9-21: Transport FOM Module.
4.	The following interaction classes are extensions of the NETN Service Consumer-Provider base interactions:
a.	RequestTransport interaction is used by the consumer to initiate a request of transport to a transport service provider. Units and appointment data are included in the request. The appointment data specifies when and where embarkment and disembarkment shall take place.
b.	OfferTransport interaction is used by the transport service provider to indicate which of the requested units can be transported. In the offer, the provider can also change the appointment data specified in the request.
5.	During execution of transport services, the service provider shall inform the service consumer about the service progress using the following interactions:
a.	TransportEmbarkmentStatus interaction is used by the service provider to indicate precisely when units are embarked.
b.	TransportDisembarkmentStatus interaction is used by a service provider to indicate precisely when units are disembarked.
c.	TransportDestroyedEntities interaction is used by a service provider to indicate the damage state of units during the transport.
6.	The following NETN Service Consumer-Provider base interactions are also used in the Transport Pattern:
a.	SCP_AcceptOffer.
b.	SCP_ReadyToReceiveService.
c.	SCP_ServiceStarted.
d.	SCP_ServiceComplete.
e.	SCP_ServiceReceived.
f.	SCP_CancelService.
 
Figure 9-22: Transport Service Requested and Delivered.
7.	A Consumer makes a request for transport with the following data in a RequestTransport interaction:
a.	List with units to transport; and
b.	Time and location for embarkment and disembarkment.
8.	A Provider offers a response to the consumer request with an OfferTransport interaction with the following parameters which may be modified from the originating request:
a.	List with units that the provider can transport;
b.	Time and location for embarkment and disembarkment; and
c.	List of units that will execute the transport.
9.	An offer is accepted with the interaction SCP_AcceptOffer or rejected with the interaction SCP_RejectOffer by the Consumer. The offer is accepted when both service Consumer and Provider have agreed about the conditions for delivery of the service. To achieve the transport service, the units listed for transport must be present on time at the embarkment location in order to embark and declare it with the SCP_ReadyToReceiveService interaction.
10.	During the execution of the transport service, each transporting unit enters a loop where:
a.	It publishes a list of embarked units.
b.	It publishes a list of disembarked entities. If modelling responsibility has been transferred to the Provider; the responsibility of entities specified in this list is restored to the Consumer when disembarked (see Transfer of Modelling Responsibility).
11.	Both TransportEmbarkmentStatus and TransportDisembarkmentStatus interactions can be repeated as much as needed, if transportation needs to be realized in several iterations. Unit management during delivery of services:
a.	When Embarkment: Federate with modelling responsibility for the embarked units shall set these units as inactive. The unit is no more taken into account in simulation execution.
b.	During Transport: The modelling responsibility of spatial attributes for the units specified in this list can be transferred to the Provider until disembarkment (see Transfer of Modelling Responsibility) or the consumer shall update the Spatial attribute or IsPartOf and RelativeSpatial attributes.
c.	When Disembarkment: Federate with modelling responsibility for the disembarked units shall set these units as active and assign their location to the disembarkment location.
12.	A Transport service is considered as closed:
a.	When the Consumer receives a SCP_ServiceCompleted interaction and sends a SCP_ServiceReceived interaction.
b.	When a SCP_RejectOffer is issued by the service Consumer.
c.	When a SCP_CancelService is issued by either the service Provider or service Consumer.
 
Figure 9-23: Early Cancellation of the Service, here by the 
Provider. The service transaction is terminated.
13.	If a Transport service is cancelled:
a.	During negotiation phase (before service delivery start):
(1)	The transaction between service Consumer and Provider is considered as closed without delivery of service.
b.	During delivery phase (after service start and before disembarkment has started):
(1)	All units already embarked or partially embarked are kept by the service Provider. The service Provider needs a new Request to continue, either to embark remaining units or to disembark the already embarked units.
 
c.	During delivery phase (after disembarkment has started and before complete):
(1)	All units already disembarked or partially disembarked are kept by the service Consumer. The service Provider needs a Cancellation of the transport service after it is started, and transported units will remain on the transporter.
 
Figure 9-24: Cancellation of the Transport Service after Disembarkment is Started, Units not yet Disembarked will Remain on the Transporter.
 
Figure 9-25: The Consumer Requests a New Transport Service, Disembarkment of Transported Units after a Cancellation of a Previous Transport Service.
 
###	Disaggregation of Units for Transportation 

In the case when a unit is too large for transportation on one transporter, e.g. echelon size does not permit a unit to be transported in a single transportation, the consumer of the service shall disaggregate the large unit in to a number of subunits, which shall be indivisible. The originating unit is set as inactive if it is fully disaggregated according to the definitions in 1278.1a-1998 document, otherwise it shall remain active. All subunits are then included in a transport request, and any offer may then be accepted or rejected.

When a unit is disaggregated for transport these subunits are embarked on more than one transporter or one transporter used repeatedly. At disembarkment, a temporary Bridgehead unit is activated at the disembarkment location, together with disembarked subunits. The bridgehead unit shall be assigned the callsign from the originating aggregate unit with an additional "-bh" to indicate that the unit represents a bridgehead. When all subunits are disembarked the originating unit is aggregated and set as active at the disembarkment location and subunits are then either deleted or set as inactive. The bridgehead is either deleted or set as inactive.

### Warfare Interactions Against Transporter 

Whenever a transport service provider receives warfare interactions (e.g. MunitionDetonation), damage on the transporter is calculated. If the transporter is destroyed then units on board the transporter shall also be destroyed.

If the transporter is not destroyed then damage is assessed against embarked units.

The transport service provider sends a list of destroyed units to the service consumer. The transport service consumer can use this list to update its situation or to cancel a transaction in progress. A transport service provider shall use the TransportDestroyedEntities interaction to define destroyed transported units during the service delivery.

If a transport service consists of one embarkment and one disembarkment event:
* If the transporter is destroyed, the consumer service is cancelled and the transported unit(s) is never reactivated.
else:
* If a transporter is destroyed with transported units on board, transport service continues with remaining transporters until service is completed. Units on destroyed transporter are deleted or set as inactive for the remainder of the federation execution.
 
###	Embarkment Service 

A Consumer makes a request for embarkment with the following data:
* List with units to embark.
* Time and location for embarkment.

A Provider offers a response to the consumer request with the following parameters which may be modified from the originating request:
* List with units that the provider can embark.
* Time and location for embarkment.
* List of units that will execute the embarkment.

An offer is accepted or rejected by the Consumer. The offer is accepted when both service Consumer and Provider are agreeing about the conditions for delivery of the service. To achieve the embarkment service, the units listed for embarkment must be present on time at the embarkment location in order to embark and declare it with the SCP_ReadyToReceiveService interaction.

The TransportEmbarkmentStatus interaction can be repeated as much as needed, if embarkment needs to be realized in several iterations. During an Embarkment service execution, each transporter enters a loop publishing a list of embarked units. If the modelling responsibility is transferred to the application that provides the service then it shall remain there in this protocol. An Embarkment service is considered as closed:
* When the service Consumer receives a SCP_ServiceCompleted interaction and sends a SCP_ServiceReceived interaction.
* When a SCP_RejectOffer is used by the service Consumer.
* When a SCP_CancelService is used by the service Provider or Consumer.

If an Embarkment service is cancelled:
* During negotiation phase (before service delivery start):
    * The transaction between the service Consumer and Provider is considered as closed without delivery of service.
* During delivery phase (after service start and before service completed):
    * All units already embarked are kept by the service Provider. The service Provider needs a new Request to continue, either to embark remaining units or to disembark the already embarked units.

### Disembarkment Service 

A Consumer makes a request for disembarkment with the following data:
* List with units to disembark.
* Time and location for disembarkment.

A Provider offers a response to the consumer request with the following parameters which may be modified from the originating request:
* List with units that the provider can disembark.
* Time and location for disembarkment.
* List of units that will execute the disembarkment.

An offer is accepted or rejected by the Consumer. The offer is accepted when both service Consumer and Provider are agreeing about the conditions for delivery of the service. To achieve a Disembarkment service, Consumer shall publish the `SCP_ReadyToReceiveService` interaction.

A TransportDisembarkmentStatus interaction can be repeated as much as needed, if disembarkment needs to be realized in several iterations. During a Disembarkment service execution, each transporter enters a loop where it publishes a list of disembarked units. If the modelling responsibility is transferred to the application that provides the service then it shall be returned back to the application that consumed the service.

A Disembarkment service is considered as closed:
* When the service Consumer receives a SCP_ServiceCompleted interaction and issues a SCP_ServiceReceived interaction.
* When a SCP_RejectOffer is issued by the service Consumer.
* When a SCP_CancelService is issued by the service Provider or Consumer.

If a Disembarkment service is cancelled:
* During negotiation phase (before service delivery start):
    * The transaction between the service Consumer and Provider is considered as closed without delivery of service.
* During delivery phase (after service start and before service completed):
    * All embarked units are kept by the service Provider. The service Provider needs a new Request to continue, either to disembark remaining units or to embark the already disembarked units.

Variations:
* Disembarkment protocol can start with a Consumer interaction instead of a Provider one. If a Provider initiates a Disembarkment (planned operation), the protocol execution starts directly at the second step (SCP_OfferService), without processing the query phase (RequestTansport).

### Transport Services and Attrition 

The TransportDestroyedEntities interaction can take place at any time between the start of the service (SCP_ServiceStarted interaction) and the end of the service (SCP_ServiceComplete interaction). Impact on the transport service pattern could be the following example.

Vessel « 1 » and « 2 » are transporters. Some units need to be transported in two rotations on each Vessel. We study the case where Vessel « 1 » is destroyed during its first rotation and Vessel « 2 » is destroyed during its second rotation:

Event	Interaction
Negotiation phase and start of the service	…
First rotation: Vessel 1 and Vessel 2 embark units	Provider send: TransportEmbarkmentStatus (list1, Vessel1) TransportEmbarkmentStatus (list2, Vessel2)
During transport, service Provider receives MunitionDetonation; Vessel 1 is destroyed	Provider send: TransportDestroyedEntities (list1)
Vessel 2 disembark his units	Provider send: TransportDisembarkmentStatus (list2, Vessel2)
Second rotation: Vessel 2 embark units	Provider send: TransportEmbarkmentStatus (list3, Vessel2)
During transport, service Provider receives MunitionDetonation; Vessel 2 is destroyed	Provider send: TransportDestroyedEntities (list3)
End of service or Cancel	

### Scenario Initialization Phase 

Units can start as embarked units and have a planned disembarkment location. The transporters attribute EmbeddedUnitList shall identify these units with their UniqueId (UUID) which is specified in the scenario (MSDL) file for the initialization of the federation execution. Embarked units shall be published by the consumer during the scenario preparation/initialization phase.

The embarkment phase is assumed to have taken place during the scenario preparation phase, so applications do not need to interact for embarkment. The interaction sequence for the disembarkment service is:
* The Consumer sends a request for disembarkment with units, time and location.
* The Provider offers the service.
* If the offer conditions are OK, it is accepted by the Consumer.
* Consumer directly sends a ReadyToReceive interaction.
* Provider directly sends a SCP_ServiceStarted.
* Provider sends TransportDisembarkStatus when it arrives at the location.
* Provider sends a SCP_ServiceCompleted when all units have disembarked.
* Consumer sends a SCP_ServiceReceived.
 


