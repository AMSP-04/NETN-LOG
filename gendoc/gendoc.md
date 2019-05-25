# NETN LOGThe NATO Education and Training Network (NETN) Logistics FOM Module.

This module is a specification of how to represent logistics services provided to participants in a federated distributed simulation. The specification is based on IEEE 1516 High Level Architecture (HLA) Object Model Template (OMT) and primarily intended to support interoperability in a federated simulation (federation) based on HLA. An HLA OMT based Federation Object Model (FOM) is used to specify types of data and how it is encoded on the network. The NETN FOM FOM module is available as a XML file for use in HLA based federations.

## Purpose

The NETN LOG module provides a common standard interface for negotiation, delivery and acceptance of logistics services where service providers and consumers are represented in different systems in a federated distributed simulation.	

## Scope

The NETN Logistics module covers the following services:

* Supply Service offered by a facility, unit or entity with a capability to provide supplies to the consumer. The supplies are transferred from the provider to the consumer of this service.
* Storage Service offered by a facility, unit or entity with a capability to store supplies. The supplies are transferred from the consumer to the provider of this service.
* Transport Service offered by a facility, unit or entity with a capability to transport non-consumable materiel. Units can embark, be transported and then disembark.
* Repair service offered by a facility, unit or entity with the capability to repair non-consumables materiel, e.g platforms.

Examples of use:

* Refuelling of aircraft at an airbase or in the air
* Transport of supplies between facilities
* Repair of damaged platforms in facility or by unit
* Transport of units, platforms, and humans by train, ship, or aircraft
* Embarkment and disembarkment of units on platforms
        	
	
# Overview
All NETN Logistics services are based on a Logistics Service Pattern that include negotiation, delivery and acceptance of logistics services. The pattern is described below and is implemented as base classes in the NETN LOG FOM Module. 
 
The NETN LOG FOM module extends RPR-FOM v2.0 FOM. Datatypes are re-used and extensions to object classes are defined.

## Facility
The facility concept is central and all logistics services are provided through facilities. Facilities can be railway stations, storage tanks depot, port, etc. and a facility can also be part of a unit or platform. 
 
The `LOG_Facility` extends the RPR-FOM v2.0 object class `EmbeddedSystem` as a subclass and can therefore be associated with a RPR-FOM 2.0 entity using the `HostObjectIdentifier` and `RelativePosition` attributes. E.g. a facility can be placed on a surface vessel and act as a provider of supply and repair services.

<img src="/images/log_facility.png" width="500px"/>


|Attribute|Datatype|Description|
|---|---|---|
|IsOperational|HLAboolean|The operational status of the facility (true = is operational)| 
|StorageList|ArrayOfSupplyStruct|List of the material located in the facility.| 
|UniqueID|UuidArrayOfHLAbyte16|The unique identifier for the facility| 
|ServiceCapability|LOG_ServiceTypeEnum8|Describes the service capability of the LOG_Facility instance.| 
