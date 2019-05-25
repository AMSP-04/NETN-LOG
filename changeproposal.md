# Change Proposal

## Identification information
### CPR identifier
NETN-Logistics-CPR-1

### Title
Merge the NETN-SCP-Base, NETN-Transport, NETN-Supply, NETN-Storage and NETN-Repair MSDL FOM modules to one FOM module, NETN-Logistics.

### Initiator
Lennart Olsson (Sweden) and Bjorn Lofstrand (Sweden)|

### Version
|Version|Date|Comment|
|----|----|----|
|v3|2018-11-06|Approved by MSG-163 for implementation|
|v4|2019-05-25|Moved to GitHub|

## Proposed change / detected problem

The following table lists the effected Configuration Items (CIs) and a summary of the change.

|CI identification|Version|Change/problem description|
|---|---|---|
|NETN-SCP-Base|v1.1.3|The object class SCP_Facility shall be moved from PRPv2 BaseEntity to RPRv2 EmbeddedSystem and renamed to LOG_Facility. An entity can offer more than one services, e.g. both transport and supply, this implies that an entity can have more than one facility as embedded systems.|
|NETN-Supply|v1.1.2|The module will be merged into one module that manage Logistics. The name of the interactions does not follow NETN naming convention, add prefix LOG_.|
|NETN-Storage|v1.2.2|The module will be merged into one module that manage Logistics. The name of the interactions does not follow NETN naming convention, add prefix LOG_.|
|NETN-Repair|v1.2.1|The module will be merged into one module that manage Logistics. The name of the interactions does not follow NETN naming convention, add prefix LOG_.|
|NETN-Transport|v1.1.2|The module will be merged into one module that manage Logistics. The name of the interactions does not follow NETN naming convention, add prefix LOG_.|

## Reason for change / cause of problem
The following items are change reasons.
1. Having the object class Facility as a subclass to RPR BaseEntity makes it hard to use, moving it to EmbeddedSystem makes it more easy to use and use with legacy system.
2. It is not necessary to have four FOM modules that modelling different logistics functionality.
3. The NETN naming convention is not fully used in the current FOM modules.
4. Consequences of change processing (technical)
The use of the object class SCP_Facility is very limited, there are not any (know) system that uses it today. 

The changes in this proposal are not backward compatible with current version, but since the object class SCP_Facility is not currently used by any (known) system this will not be a big issue.

The FOM module merging will not make any major problems for systems that use this functionality (Transport, Supply, Repair and Storage) today. The renaming (with a prefix) of the four Logistics FOM modules may cause problems for legacy systems that are not updated with newer versions.

The transaction of a service is done between two entities (NETN-Aggregate and/or NETN Physical instances) where the provider has an embedded LOG_Facility instance. This implies that it will be possible to implement a Logistics server in a separate federate using legacy federates entities as a hosts.

There are consequences for all users of the four NETN Logistics FOM modules. Effected simulation systems include:
* Pitch Actors (Pitch)
* SWORD (MASA)
* …

## Consequences of not processing change
The current version is not suited for implementation in legacy federates. 

## Trade-offs and alternatives
Implementing a federate (component) that manages the logistics besides a legacy federate is possible with this change proposal.

It is more natural to have the LOG_Facility object class as an embedded system at an hosting entity, e.g. an Aggregate, CulturalFeature or a SurfaceVessel. Displaying the facility in a map is not necessary, the host object is displayed in a map. No movement methods are needed to move a SCP_Facility, it follows with the host object. The damage state is defined at the host entity, an attribute (IsOperational) at the LOG_Facility instance specifies if it is operational or not.

A system subscribing to the object class LOG_Facility with a requesting entity can derive possible providers using the attributes LOG_Facility.ServiceCapability, location, ForceIdentifier and DamageState at host entities.

## Evaluation considerations
None.

## Proposed changes details

### NETN-SCP-Base change proposal
 
Move the object class SCP_Facility from PRPv2 BaseEntity to RPRv2 EmbeddedSystem and rename it to LOG_Facility. An entity can offer more than one services, e.g. both transport and supply, this implies that the entity can have more than one LOG_Facility systems embedded.
 
Add the following attribute to the LOG_Facility object class:
* ServiceCapability – Defines the service that the facility is offer.
Remove the following attributes from the LOG_Facility object class:
* DamageState – Attribute is defined at a RPRv2 host entity.
* Callsign – Attribute is defined at a NETN host entity.
* ForceIdentifier -  Attribute is defined at a RPRv2 host entity.
* PlatformList - Attribute (EmbeddedUnitList) is defined at a NETN host entity (from MSG-106).