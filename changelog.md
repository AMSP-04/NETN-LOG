## Changelog

### Changes in v2.0.0

Version 2.0.0 is the initial version of the new combined NETN LOG FOM module based on previous Logistics related NETN modules. This version was developed by MSG-163.

The NETN LOG module is not backward compatible with previous NETN Logistics Modules and usage require minor updates to federates to use the new class names and structure.

* FOM Modules NETN-SCP-BASE v1.1.3, NETN-Supply v1.1.2, NETN-Storage v1.2.2, NETN-Repair v1.2.1 and NETN-Transport v1.1.2 merged into new module NETN-LOG
* Documentation NETN Logistics updated to reflect new structure and NETN LOG FOM Module.
* Documentation of NETN Logistics module simplified, aligned with other NETN modules and the language used reviewed and updated.

* Updated releaseRestriction, purpose, description and useLimitation
* Changed securityClassification from Unclassified to Not Classified
* Added note for modelIdentification to provide additional description of FOM module
* Added glyph

* `SCP_Facility` removed

* Renamed datatype `NETN_ServiceIdentifier` to `ServiceIdentifier`
* Renamed field `MaterialID` of datatype `RepairStruct` to `MaterielID`

* Removed `NETN_RepairTypeEnum16`
* Introduced dependency to RPR-Enumeration v2.0
* Changed datatype of `ArrayOfRepairTypeEnum` from `NETN_RepairTypeEnum16` to `RepairTypeEnum16` (from RPR_Enumeration). 

* Change datatype of `LOG_Service.ServiceID` to `TransactionID` defined in NETN-BASE.
* Remove parameter `LOG_Service.ServiceType`.

* Move and rename parameter `LOG_Service.Consumer` to `LOG_Service.RequestService.ConsumerEntity` and change datatype from `Callsign` to `UuidArrayOfHLAbyte16`
* Move and rename parameter `LOG_Service.Provider` to `LOG_Service.RequestService.ProviderEntity` and `LOG_Service.OfferService.ProviderEntity` and change datatype from `Callsign` to `UuidArrayOfHLAbyte16`
* Add parameter `LOG_Service.OfferService.OfferID` with datatype `TransactionID` defined in NETN-BASE.
* Add parameter `LOG_Service.AcceptOffer.OfferID` with datatype `TransactionID` defined in NETN-BASE.
* Change parameter `LOG_Service.OfferService.IsOffering` to Optional with default value TRUE.
* Rename parameter `LOG_Service.OfferService.RequestTimeOut` to `LOG_Service.OfferService.OfferTimeOut`
* Add interaction class `LOG_Service.CancelOffer` to allow providers to withdraw offers before they are accepted when `OfferTimeOut` has been reached.
* Remove interaction classes `ReadyToReceiveRepair`, `ReadyToReceiveSupply` and `ReadyToReceiveStorage`. Change of accepted offer not allowed to be modified and therefore subclasses are not required.
* Remove parameter `RequestStorage.LoadingDoneByProvider`. Loading will always be modelled by provider.
* Remove parameter `RequestSupply.LoadingDoneByProvider`. Loading will always be modelled by provider.
* Remove parameter `OfferStorage.LoadingDoneByProvider`. Loading will always be modelled by provider.
* Remove parameter `OfferSupply.LoadingDoneByProvider`. Loading will always be modelled by provider.

* Change datatype of parameter `RequestTransport.TransportData` to `ArrayOfUuid`.
* Change datatype of parameter `OfferTransport.TransportData` to `ArrayOfUuid`.

* Remove datatype `TransportStruct`.
* Remove datatype `DataTStruct`.
* Remove datatype `DataEDStruct`.

* Add parameter `RequestTransport.Embarkment` specifying time and location for loading/embarking onto transport.
* Add parameter `RequestTransport.Disembarkment` specifying time and location for unloading/disembarking from transport.
* Add parameter `OfferTransport.Embarkment` specifying time and location for loading/embarking onto transport.
* Add parameter `OfferTransport.Disembarkment` specifying time and location for unloading/disembarking from transport.

* Remove datatype `TransportTypeEnum32` - not used.
* Remove datatype `ServiceIdentifier` - not used.
* Remove datatype `LOG_ServiceTypeEnum8` - not used.
* Remove datatype `ServiceDescription` - not used.


* Remove parameter `OfferTransport.OfferType` (use IsOffering)
* Remove datatype OfferTypeEnum32

### Previous structure

Before merged into a single FOM Module, several FOM modules were used to represent different services. A Base FOM Module was used to represent the basic Service-Consumer Provider (SCP) pattern. 

These modules were initially developed by MSG-068, updated by MSG-106 and prepared for release by MSG-134.

Modules in AMSP-04 Ed. A. NATO Education and Training Network Federation Architecture and FOM Design (NETN FAFD) were:
* NETN-SCP-BASE v1.1.3
* NETN-Supply v1.1.2
* NETN-Storage v1.2.2
* NETN-Repair v 1.2.1
* NETN-Transport v1.1.2

