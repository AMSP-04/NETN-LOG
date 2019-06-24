## Changelog

### Changes in v2.0.0

Version 2.0.0 is the initial version of the new combined NETN LOG FOM module based on previous Logistics related NETN modules. This version was developed by MSG-163.

The NETN LOG module is not backward compatible with previous NETN Logistics Modules and usage require minor updates to federates to use the new class names and structure.

#### NETN-LOG#1 Rename interaction classes
* Prefix dropped from all interaction classes except interaction class LOG_Service

#### NETN-LOG#2 Harmonize interaction diagrams
* Use online sequence diagram generator tool to produce SVG based interaction diagrams. https://sequencediagram.org

#### NETN-LOG#3 Update documentation
* Documentation NETN Logistics updated to reflect new structure and NETN LOG FOM Module.
* Documentation of NETN Logistics module simplified, aligned with other NETN modules and the language used reviewed and updated.
* Added note for modelIdentification to provide additional description of FOM module
* Added glyph

#### NETN-LOG#5 Supply transfer modelled by provider
* Removed parameter `RequestSupply.LoadingDoneByProvider` - always by provider.
* Removed parameter `OfferSupply.LoadingDoneByProvider`. always by provider.


#### NETN-LOG#6 Remove SCP_Facility
* Removed object class `SCP_Facility`

#### NETN-LOG#7 Merge LOG modules
* FOM Modules NETN-SCP-BASE v1.1.3, NETN-Supply v1.1.2, NETN-Storage v1.2.2, NETN-Repair v1.2.1 and NETN-Transport v1.1.2 merged into new module NETN-LOG
* Introduced dependency to RPR-Enumeration v2.0
* Renamed datatype `NETN_ServiceIdentifier` to `ServiceIdentifier`
* Renamed datatype field `RepairStruct.MaterialID` to `RepairStruct.MaterielID`
* Changed datatype for `ArrayOfRepairTypeEnum` from `NETN_RepairTypeEnum16` to `RepairTypeEnum16`
* Renamed parameter `OfferService.RequestTimeOut` to `OfferService.OfferTimeOut`
* Removed parameter `LOG_Service.Consumer` - use `RequestService.ConsumerEntity`
* Removed parameter `LOG_Service.Provider` - use `RequestService.ProviderEntity`
* Added parameter `RequestService.ConsumerEntity`
* Added parameter `RequestService.ProviderEntity`
* Added interaction class `LOG_Service.CancelOffer`
* Removed parameter `LOG_Service.ServiceType` - use subclasses and ServiceID
* Added parameter `OfferService.OfferID`
* Added parameter `AcceptOffer.OfferID`
* Added parameter `OfferService.ProviderEntity`
* Changed parameter datatype for `LOG_Service.ServiceID` to `TransactionID`
* Removed datatype `ServiceIdentifier` 
* Removed datatype `LOG_ServiceTypeEnum8` 
* Removed datatype `ServiceDescription` 
* Removed datatype `NETN_RepairTypeEnum16`

#### NETN-LOG#8 Merge Supply and Storage services
* Removed interaction class `RequestStorage` - use `RequestSupply.TransferDirection`
* Removed interaction class `OfferStorage` - use `OfferSupply`
* Removed interaction class `StorageComplete` - use `SupplyComplete`

#### NETN-LOG#9 Change securityClassification
* Updated releaseRestriction, purpose, description and useLimitation
* Changed securityClassification from Unclassified to Not Classified

#### NETN-LOG#10 Do do allow change of service agreement
* Removed interaction class `ReadyToReceiveStorage` - use `ReadyToReceiveService`
* Removed interaction class `ReadyToReceiveRepair` - use `ReadyToReceiveService`
* Removed interaction class `ReadyToReceiveSupply` - use `ReadyToReceiveService`
* Added parameter `RequestSupply.TransferDirection`


#### NETN-LOG#11 Harmonize Offer Type
* Removed parameter `OfferTransport.OfferType` - use `OfferService.OfferType`
* Removed parameter `OfferService.IsOffering` - use `OfferService.OfferType`
* Added parameter `OfferService.OfferType`

#### NETN-LOG#12 Harmonize use of Appointment
* Removed parameter `RequestRepair.Appointment` - use `RequestService.StartAppointment`
* Removed parameter `RequestSupply.Appointment` - use `RequestService.StartAppointment`
* Removed parameter `OfferRepair.Appointment` - use `OfferService.StartAppointment`
* Removed parameter `OfferSupply.Appointment` - use `OfferService.StartAppointment`
* Added parameter `RequestService.StartAppointment`
* Added parameter `RequestTransport.EndAppointment`
* Added parameter `OfferService.StartAppointment`
* Added parameter `OfferTransport.EndAppointment`
* Changed parameter datatype for `RequestTransport.TransportData` to `ArrayOfUuid`.
* Changed parameter datatype for `OfferTransport.TransportData` to `ArrayOfUuid`.
* Removed datatype `TransportStruct`
* Removed datatype `DataTStruct`
* Removed datatype `DataEDStruct`
* Removed datatype `TransportTypeEnum32`

### Previous structure

Before merged into a single FOM Module, several FOM modules were used to represent different services. A Base FOM Module was used to represent the basic Service-Consumer Provider (SCP) pattern. 

These modules were initially developed by MSG-068, updated by MSG-106 and prepared for release by MSG-134.

Modules in AMSP-04 Ed. A. NATO Education and Training Network Federation Architecture and FOM Design (NETN FAFD) were:
* NETN-SCP-BASE v1.1.3
* NETN-Supply v1.1.2
* NETN-Storage v1.2.2
* NETN-Repair v 1.2.1
* NETN-Transport v1.1.2

