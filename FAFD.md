## Facilities

Facilities are the central element through which services are provided, e.g. material can be transferred to a consuming unit. Facilities may be created during a simulation or may be a part of the infrastructure (railway station, storage tanks depot, port, etc.). A facility may be part of a unit (e.g. ship).

<img src="/objectclasses.png" width="50%">

The object class `LOG_Facility` extends the RPR-FOM v2.0 `EmbeddedSystem` by subclassing and defining attributes for a `StorageList` that specifies the materials that are located in the facility and an attribute `ServiceCapability`used to declare the service capabilities offered by the facility. Since the `LOG_Facility` object class inherits from `EmbeddedSystem` it can be associated to a RPR-FOM 2.0 entity using the `HostObjectIdentifier` and `RelativePosition` attributes. E.g. a facility can be placed on a surface vessel and act as a provider of supply and repair services.

## Consumer-Provider Pattern

<img src="/scp.png" width="50%">

## Supply

Services for resupply of consumable materials include:
* Supply services provided by a facility, a unit or an entity with consumable materials supply capability. Resources are transferred from the provider to the consumer of the service.
* Storage services are provided by a facility, a unit or entity with consumable materials storage capability. Resources are transferred from the consumer to the provider of the service.

These two services are different in terms of flow of materials between service consumer and provider. Both services follow the basic Service Consumer-Provider pattern to establish a service contract and a service delivery. 

Materials are differentiated between:
* Consumable materials:
 1. Ammunition.
 2. Mines.
 3. NBC Materials.
 4. Fuel (Diesel, Gas, Aviation fuel, etc.).
 5. Water.
 6. Food.
 7. Medical materials.
 8. Spare parts.
* Non-consumable materials:
 1. Platforms.
 2. Humans.
 3. Aggregates.
 4. Reconnaissance and Artillery systems (Radar).
 5. Missile.

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
Materials will be transferred after the offer is accepted and the service is started. This service allows partial transfers. This implies that only some of the materials described in the service contract are transferred. The final requested amount of supplies, by type, is specified in the LOG_ReadyToReceiveSupply interaction and shall not exceed the amount of supplies, by type, specified in the LOG_OfferSupply interaction.

To request supplies a `LOG_RequestSupply` interaction is used. The amount and type of requested materials are included as parameters. _In this request, the Consumer specifies a preference for whether the service delivery is controlled by the Provider (default) or by the Consumer._

A `LOG_OfferSupply` interaction is used by potential supplies to provide an offer, including the amount and type of offered materials, as a response to the requested supplies. _In this offer the provider can agree with the Consumer's choice of service delivery control or make a counter-offer._


`LOG_ReadyToReceiveSupply` is used by a Consumer to indicate that supply delivery can start.

If the transfer is controlled by the Provider then LOG_SupplyComplete is used by the Provider to inform the Consumer that the transfer is complete. The consuming entity shall send a LOG_ServiceReceived in response to the LOG_SupplyComplete interaction. Transfer of supplies is considered complete once the LOG_ServiceReceived is issued.

If the transfer is controlled by the Consumer then LOG_ServiceReceived is used by the Consumer to inform the Provider that the transfer is complete. The providing entity shall send a LOG_StorageComplete in response to the LOG_ServiceReceived interaction. Transfer of supplies is considered complete once the LOG_StorageComplete is issued.

The transfer may only be a part of the offered materials (partial transfer); the actual transferred supplies are specified in SuppliesData parameter of the LOG_SupplyComplete interaction. If requested materials are only partially transferred, the consumer may start another LOG_RequestSupply in order to obtain all desired supplies.

If the LOG_CancelService occurs between LOG_ServiceStarted and LOG_SupplyComplete, the Provider shall inform the Consumer of the amount of supplies transferred using LOG_SupplyComplete parameter SuppliesData. This allows for supply pattern interruptions due to operational necessity, death/destruction of either the consumer or provider during resupply, etc. Note that the updated supply amount(s) are subject to the constraint that the amount(s), by type, must be less than or equal to the amount(s), by type, of offered supplies.
 
Figure 9-4: OK Transfer of Resources, Provider Controls the Service Delivery.

The service can be cancelled by both the provider and the consumer with the LOG_CancelService interaction. If the service is cancelled before service delivery has started, the service transaction is terminated.
 
Figure 9-5: Early Cancellation, here by the Provider. Service is terminated.

If the service is cancelled during service delivery, the provider must inform the consumer of the amount and type of material transferred.
 
Figure 9-6: Cancellation by the Provider After the Service 
has Started, Provider Controls the Service Delivery.

The consumer can reject an offer from the provider and no more negotiations shall be done in the rejected service.
 
Figure 9-7: Consumer Rejects the Offer from the Provider.

The provider can inform the Consumer that it is not able to fulfil the required supply data.
 
Figure 9-8: Provider Sends a Negative Offer to the Consumer.


### Storage Service

## Maintenance
### Repair Service

## Transport

### Disaggregation of Units for Transportation 
### Warfare Interactions Against Transporter
### Embarkment Service
### Disembarkment Service
### Transport Services and Attrition
### Scenario Initialization Phase


[scp]: ./scp.png
