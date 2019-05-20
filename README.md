# NETN-LogisticsA combined module of the NETN2 modules, NETN-Transport, NETN-Supply, NETN-Storage and NETN-Repair.## Purpose## Scope
### LOG_FacilityLogistics LOG_Facility dedicated for supplying, storaging, reparing, and other services.Federates shall send the time at which the data is valid in the user defined tag with every attribute values update and interaction.  The time shall be in the first 8 bytes (octets) of the user defined tag, using the DIS timestamp field format (see section 5.2.31 of IEEE 1278.1-1995) converted into hexadecimal ASCII character representation (0-9 and A-F).  The ordering of the characters shall be in accordance with section 5.1.1 of IEEE 1278.1-1995, that is most significant octet first, with the most significant bits first (i.e. the character for bits 4-7 precedes the character for bits 0-3). 
 
All federates shall transmit this field, even if they do not use it themselves, so that other federates can use its value to compensate for network transport delays.
### LOG_RequestRepairSent by the consumer when a repair for needed. Specifies entity and type of repair
### LOG_RequestStorageLOG_RequestStorage is used by a consumer to initiate a request for storage of supplies. The amount and type of material is included in the request.
### LOG_RequestSupplyLOG_RequestSupply is used by a consumer to initiate a request for supply from a supply service provider. The amount and type of material is included in the request. In this request the consumer propose whether the loading is done by the provider or by the consumer.
### LOG_RequestTransportA request for a Transport support. 
The request to transport, embark or disembark a platform is initiated by a LOG_RequestTransport interaction;
### LOG_OfferRepairThe LOG_OfferRepair interaction class shall be sent by a federate simulating the service providing entity in response to a LOG_RequestRepair interaction.
### LOG_OfferStorageLOG_OfferStorage is used by a storage service provider to indicate which (amount and type) of the requested material can be stored.
### LOG_OfferSupplyLOG_OfferSupply is used by a supply service provider to indicate which of the requested materials (amount and type) can be offered. In this request the consumer decides whether the loading is done by the provider or by the consumer.
### LOG_OfferTransportAn Offer for a Transport support. 
The LOG_OfferTransport interaction shall be sent by the service providing federate in response to a LOG_RequestTransport interaction.
### LOG_AcceptOfferThe LOG_AcceptOffer is used to accept an offer made by a service providing entity as indicated in a SCP_OfferService interaction. By issuing a LOG_AcceptOffer interaction the service consuming entity enters a contract for service delivery with the service producing entity. 
 
The LOG_AcceptOffer interaction does not define any additional parameters but subclasses may include parameters with additional information.
### LOG_ServiceStartedThe LOG_ServiceStarted interaction is issued by a service providing entity to inform about the start of service delivery. The time of service delivery start may be significantly later then receiving a indication from the consumer that the service delivery can start. 
 
The SCP_ServiceStarted interaction does not define any additional parameters.
### LOG_ServiceCompleteThe LOG_ServiceCompleted interaction is used by a service providing entity to inform the service consuming entity that the service has been delivered. 
 
The LOG_ServiceCompleted interaction does not define any additional parameters.
### LOG_SupplyCompleteThis interaction is sent by the provider when the supply is delivered to the consumer
### LOG_StorageCompleteThis interaction is sent by the provider when the supply is delivered to the provider
### LOG_RepairCompleteThis interaction is sent by the provider when the repair service is delivered to the consumer
### LOG_ServiceReceivedThe LOG_ServiceReceived interaction is used by a service consuming entity to inform the service providing entity that the service has been delivered. 
 
TheLOG_ ServiceReceived interaction does not define any additional parameters.
### LOG_RejectOfferThe LOG_RejectOffer is used to reject an offer made by a service providing entity as indicated in a LOG_OfferService interaction. By issuing a LOG_RejectOffer interaction the service consuming entity informs the providing entity that the offer has been rejected.
### LOG_CancelServiceThe LOG_CancelService interaction is used by either a service consuming entity or a service providing entity to inform about early termination of the service delivery or in some cases termination of the service request before delivery has begun.
### LOG_ReadyToReceiveServiceThe LOG_ReadyToReceiveService interaction is issued by a service consuming entity to indicate that the start of service delivery can start. The time of service delivery start may be significantly later then indicating ready for service delivery. 
 
The LOG_ReadyToReceiveService interaction does not define any additional parameters.
### LOG_ReadyToReceiveRepairThis interaction is sent when the consumer is ready to receive the repair service. 
(At same location as the provider)
### LOG_ReadyToReceiveSupplyThis interaction is sent when the consumer is ready to receive the supply. (At same location as the provider)
### LOG_ReadyToReceiveStorageThis interaction is sent when the consumer is ready to deliver the supply (receive storage). 
(At same location as the provider)
### LOG_TransportDestroyedEntitiesThe LOG_TransportDestroyedEntities interaction is used by the service provider federate to give information on managed element to the consumer. This interaction is used only if the provider simulate the destruction of elements managed
### LOG_TransportDisembarkmentStatusThe LOG_TransportDisembarkmentStatus interaction shall be sent by the service provider federate, to inform the service consumer of the disembarkment state, after the LOG_ServiceStarted interaction
### LOG_TransportEmbarkmentStatusThe LOG_TransportEmbarkmentStatus interaction shall be sent by the service provider federate, to inform the service consumer of the embarkment state, after the LOG_ServiceStarted interaction

[objectclasses]: ./objectclasses.png
