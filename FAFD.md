## Facilities and Materials


## Consumer-Provider Pattern

## Supply

### Supply Service
Materials will be transferred after the offer is accepted and the service is started. This service allows partial transfers. This implies that only some of the materials described in the service contract are transferred. The final requested amount of supplies, by type, is specified in the LOG_ReadyToReceiveSupply interaction and shall not exceed the amount of supplies, by type, specified in the LOG_OfferSupply interaction.

To request supplies a LOG_RequestSupply interaction is used. The amount and type of requested materials are included as parameters. _In this request, the Consumer specifies a preference for whether the service delivery is controlled by the Provider (default) or by the Consumer._

A LOG_OfferSupply interaction is used by potential supplies to provide an offer, including the amount and type of offered materials, as a response to the requested supplies. _In this offer the provider can agree with the Consumer's choice of service delivery control or make a counter-offer._


LOG_ReadyToReceiveSupply is used by a Consumer to indicate that supply delivery can start.

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
## Repair Service

## Transport

### Disaggregation of Units for Transportation 
### Warfare Interactions Against Transporter
### Embarkment Service
### Disembarkment Service
### Transport Services and Attrition
### Scenario Initialization Phase
