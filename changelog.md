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
* Change datatype of attribute `LOG_Service.Provider` from `Callsign` to `UuidArrayOfHLAbyte16`
* Change datatype of attribute `LOG_Service.Consumer` from `Callsign` to `UuidArrayOfHLAbyte16`.

* Change datatype of `LOG_Service.ServiceID` to `TransactionID` defined in NETN-BASE.
* Remove parameter `LOG_Service.ServiceType`.

### Previous structure

Before merged into a single FOM Module, several FOM modules were used to represent different services. A Base FOM Module was used to represent the basic Service-Consumer Provider (SCP) pattern. 

These modules were initially developed by MSG-068, updated by MSG-106 and prepared for release by MSG-134.

Modules in AMSP-04 Ed. A. NATO Education and Training Network Federation Architecture and FOM Design (NETN FAFD) were:
* NETN-SCP-BASE v1.1.3
* NETN-Supply v1.1.2
* NETN-Storage v1.2.2
* NETN-Repair v 1.2.1
* NETN-Transport v1.1.2

