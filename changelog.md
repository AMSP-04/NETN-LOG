## Changelog NETN-LOG

### Changes in v3.0

Version 3.0 is the initial version of the new combined NETN-LOG FOM module based on previous Logistics related NETN modules. This version was developed by MSG-163.

The NETN-LOG module is not backward compatible with previous NETN Logistics Modules and usage require minor updates to federates to use the new class names and structure.

* FOM Modules NETN-SCP-BASE v1.1.3, NETN-Supply v1.1.2, NETN-Storage v1.2.2, NETN-Repair v1.2.1 and NETN-Transport v1.1.2 merged into new module NETN-LOG
* Prefix dropped from all interaction classes except interaction class LOG_Service
* Added note for modelIdentification to provide additional description of FOM module
* Added glyph
* Updated releaseRestriction, purpose, description and useLimitation
* Changed securityClassification from Unclassified to Not Classified

* Removed object class `SCP_Facility`
* Removed interaction class `RequestStorage`
* Removed interaction class `OfferStorage`
* Removed interaction class `StorageComplete`
* Removed interaction class `ReadyToReceiveStorage`
* Removed interaction class `ReadyToReceiveRepair`
* Removed interaction class `ReadyToReceiveSupply`

* Removed parameter `LOG_Service.Consumer`
* Removed parameter `LOG_Service.Provider`
* Removed parameter `RequestSupply.LoadingDoneByProvider`
* Removed parameter `OfferSupply.LoadingDoneByProvider`
* Removed parameter `LOG_Service.ServiceType`
* Removed parameter `OfferTransport.OfferType`
* Removed parameter `OfferService.IsOffering`
* Removed parameter `RequestRepair.Appointment`
* Removed parameter `RequestSupply.Appointment`
* Removed parameter `OfferRepair.Appointment`
* Removed parameter `OfferSupply.Appointment`

* Removed datatype `TransportStruct`
* Removed datatype `DataTStruct`
* Removed datatype `DataEDStruct`
* Removed datatype `TransportTypeEnum32`
* Removed datatype `ServiceIdentifier` 
* Removed datatype `LOG_ServiceTypeEnum8` 
* Removed datatype `ServiceDescription` 
* Removed datatype `NETN_RepairTypeEnum16`

* Added interaction class `LOG_Interaction.CancelOffer`
* Renamed interaction class `CancelService` to `CancelRequest`
* Renamed interaction class `LOG_Service` to `LOG_Interaction`

* Added parameter `RequestService.ConsumerEntity`
* Added parameter `RequestService.ProviderEntity`
* Added parameter `OfferService.OfferId`
* Added parameter `AcceptOffer.OfferId`
* Added parameter `OfferService.ProviderEntity`
* Added parameter `OfferService.OfferType`
* Added parameter `RequestService.StartAppointment`
* Added parameter `RequestTransport.EndAppointment`
* Added parameter `OfferService.StartAppointment`
* Added parameter `OfferTransport.EndAppointment`
* Added parameter `RequestSupply.TransferDirection`

* Renamed parameter `LOG_Service.TransactionId` to `LOG_Interaction.RequestId`
* Renamed parameter `OfferService.RequestTimeOut` to `OfferService.OfferTimeOut`
* Changed parameter datatype for `LOG_Service.ServiceID` to `TransactionId`
* Changed parameter datatype for `RequestTransport.TransportData` to `ArrayOfUuid`.
* Changed parameter datatype for `OfferTransport.TransportData` to `ArrayOfUuid`.

* Renamed datatype `NETN_ServiceIdentifier` to `ServiceIdentifier`
* Renamed datatype field `RepairStruct.MaterialID` to `RepairStruct.MaterielId`
* Changed datatype for `ArrayOfRepairTypeEnum` from `NETN_RepairTypeEnum16` to `RepairTypeEnum16`


### Logistics in NETN-FOM v2.0

Before merged into a single FOM Module, several FOM modules were used to represent different services. A Base FOM Module was used to represent the basic Service-Consumer Provider (SCP) pattern. 

These modules were initially developed by MSG-106 and prepared for release by MSG-134.

Modules in AMSP-04 Ed. A. NATO Education and Training Network Federation Architecture and FOM Design (NETN FAFD) were:
* NETN-SCP-BASE v1.1.3
* NETN-Supply v1.1.2
* NETN-Storage v1.2.2
* NETN-Repair v 1.2.1
* NETN-Transport v1.1.2

### Logistics in NETN-FOM v1.0

* NETN_Logistics_v1.1.2
