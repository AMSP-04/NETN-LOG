## Changelog

### Changes in v2.0.0 

Version 2.0.0 is the initial version of the new combined NETN LOG FOM module based on previous Logistics related NETN modules.
The NETN LOG module is not backward compatible with previous NETN Logistics Modules and usage require minor updates to federates to use the new class names and structure.

* FOM Modules NETN-SCP-BASE v1.1.3, NETN-Supply v1.1.2, NETN-Storage v1.2.2, NETN-Repair v1.2.1 and NETN-Transport v1.1.2 merged into new module NETN-LOG
* Documentation NETN Logistics updated to reflect new structure and NETN LOG FOM Module.
* Documentation of NETN Logistics module simplified, aligned with other NETN modules and the language used reviewed and updated.

* All interaction classes renamed with prefix LOG_

* Updated releaseRestriction, purpose, description and useLimitation
* Changed securityClassification from Unclassified to Not Classified
* Added note for modelIdentification to provide additional description of FOM module

* `SCP_Facility` changed to be subclass of RPR-FOM `EmbeddedSystem` objectClass
* `SCP_Facility` renamed to `LOG_Facility`
* Updated semantics for `LOG_Facility`
* Added attribute `ServiceCapability` to `LOG_Facility` – Defines the service that the facility can offer
* Removed attribute `DamageState`from `LOG_Facility` – Attribute is defined by RPR host entity
* Removed attribtue `Callsign`from `LOG_Facility` – Attribute is defined by NETN host entity
* Removed attribute `ForceIdentifier` from `LOG_Facility`-  Attribute is defined by RPR host entity
* Removed attribute `PlatformList` from `LOG_Facility` - Attribute (EmbeddedUnitList) is defined by NETN host entity

* Added datatypes `NETN_ArrayOfSupplyStruct` and `NETN_SupplyStruct` - Moved from NETN-BASE
* Renamed datatype `NETN_ArrayOfSupplyStruct` to `ArrayOfSupplyStruct`
* Renamed datatype `NETN_SupplyStruct` to `SupplyStruct`
* Renamed datatype `NETN_ServiceIdentifier` to `ServiceIdentifier`

