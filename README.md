# NETN LOGA combined module of the NETN2 modules, NETN-Transport, NETN-Supply, NETN-Storage and NETN-Repair.## Purpose## Scope
The NETN LOG FOM module is dependent on RPR-FOM v2.0 FOM modules due to the fact that a few data types defined in these modules are reused in the definition of parameters for NETN Logistics interactions. 
In addition, a Transfer of Modelling Responsibility pattern is introduced as an option for some logistics services. 
Extensions to RPR v2.0 object classes are introduced. 

The NETN Logistics covers the following services:
* Supply service is provided by a facility, a unit or entity with consumable materials supply capability. Resources are transferred from the providing unit to the consuming unit.
* Storage service is provided by a facility, a unit or entity with consumable materials storage capability. Resources are transferred from the consuming unit to the providing unit.
* Repair service can be performed on equipment (i.e. non-consumables items such as platforms) by facilities or units capable of performing the requested repairs. Modelling responsibility is by default not transferred from the consuming unit (e.g. a damaged platform) to the application with modelling responsibility for the providing unit (i.e. repairing facility). Modelling responsibility can be transferred with the inclusion of the Transfer of Modelling Responsibility (TMR) pattern.
* Transport service is provided by a facility, a unit or entity with transportation capability of non-consumable materials (units). Transported units are embarked, transported and disembarked. Modelling responsibility is by default not transferred from the consuming unit (transported unit) to the application with modelling responsibility for the providing unit (transporter). Modelling responsibility can be transferred with the introduction of the Transfer of Modelling Responsibility pattern.
## Overview
The NETN LOG FOM Module is composed of base interactions to the support a service consumer-provider pattern and more specialised classes for specific logistics operations.

The module also contains one object class, LOG_Facility which inherits from the RPR v2.0 object class EmbeddedSystem. The attribute StorageList specifies the materials that are located at a facility and the attribute ServiceCapability – Defines the service that the facility is offer. Since the LOG_Facility object class inherits from RPR v2.0 object class EmbeddedSystem, it has the attributes HostObjectIdentifier and RelativePosition, it can be given a spatial relation to a RPR 2.0 instance, e.g. a facility can be placed on a surface vessel and act as a provider of supply and repair services.

![][objectclasses]
	

[objectclasses]: ./objectclasses.png
