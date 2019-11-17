# NETN LOG
NATO Education and Training Network (NETN) Logistics (LOG) Module

## Introduction

Military logistics is the discipline of planning and carrying out the movement and maintenance of military forces including storage, distribution, maintenance and transportation of materiel.

The NATO Education and Training Network Logistics Module (NETN LOG) is a specification of how to model logistics services in a federated distributed simulation. 

The specification is based on IEEE 1516 High Level Architecture (HLA) Object Model Template (OMT) and primarily intended to support interoperability in a federated simulation (federation) based on HLA. A Federation Object Model (FOM) Module is used to specify how data is represented and exchanged in the federation. The NETN-LOG FOM module is available as an XML file for use in HLA based federations.

### Purpose

The NETN-LOG FOM Module provides a common standard interface for negotiation, delivery, and acceptance of logistics services between federates modelling different entities involved in the service transaction. E.g simulation of the transport of a unit modelled in another simulator.

### Scope

NETN-LOG covers the following services:

* Supply Service offered by a federate capable of simulating the transfer of supplies between consumer and provider.
* Transport Service offered by a federate capable of simulating loading, transport and/or unloading of non-consumable materiel.
* Repair Service offered by a federate capable of simulating repair of consumer provided non-consumable materiel, e.g platforms.

Examples of use:

* Refuelling of aircraft at an airbase or in the air
* Transport of supplies between facilities
* Repair of damaged platforms in a facility or by unit
* Transport of units, platforms, and humans by train, ship, or aircraft   		

## License

Copyright (C) 2019 NATO/OTAN.
This work is licensed under a [Creative Commons Attribution-NoDerivatives 4.0 International License](LICENCE.md). 

The work includes the [NETN-LOG.xml](NETN-LOG.xml) FOM Module and documentation NETN-LOG.md.

Above license gives you the right to use and redistribute the NETN FOM Module (XML file and Documentation) in its entirety without modification. You are also allowed to develop your own new FOM Modules (in separate XML files and separate documentation) that build-on/extends the NETN module by reference and including neccessary scaffolding classes. You are NOT allowed to modify this FOM Module or its documentation without prior permission by the NATO Modelling and Simulation Group. 

## Versions, updates and extentions

All updates and versioning of this work is coordinated by the NATO Modelleing and Simulation Coordination Office (MSCO), managed by the NATO Modelling and Simulation Group (NMSG) and performed as NATO Science and Technology Organization (STO) technical activities in support of the NMSG Modelling and Simulation Standards Subgroup (MS3).

Feedback on the use of this work, suggestions for improvements and identified issues are welcome and can be provided using GitGub issue tracking. To engage in the development and update of this FOM Module please contact your national NMSG representative.

Version numbering of this FOM Module and associated documentation is based on the following principles:

* New official version number is assigned and in effect only when new release is made in the Master branch.
* Updates in the Develop branch will not change version number.
* In the FOM Module useHistory information include only information on official releases.
* Update of the major version number is made if the change constitute a major restructuring, merging, addition or redefinition of semantics that breaks backward compatibility or cover entirely new concepts.
* Update of the minor version number is made if the change constitute a minor additions to existing concepts and editorial changes that do not break backward compatibility but may require updates of software to use new concepts.
* Patches are released to fix minor issues that do not break backward compatibility.

|Version|Description|
|---|---|
|v1.1.2 |Version 1.1.2 of NETN-LOG FOM Module developed by MSG-068 and included in NETN FOM v1.0. |
|v2.0 |Version 2.0 of NETN-LOG FOM Module developed by MSG-106 including SCP Base, Repair, Supply, Transport and Storage FOM Modules. Included in NETN FOM v2.0 as part of AMSP-04 Ed A.|
|v3.0 |Version 3.0 of NETN-LOG FOM Module developed by MSG-163 merging back NETN-SCP, NETN-Supply, NETN-Storage, NETN-Repair and NETN-Transport in a single NETN-LOG FOM Module included in NETN FOM v3.0 as part of AMSP-04 Ed B. |

[Changelog](changelog.md)

## Documentation

[Full Documentation](NETN-LOG.md)
