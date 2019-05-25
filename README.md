# NETN LOG
The NATO Education and Training Network (NETN) Logistics FOM Module.

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

## [Changelog](changelog.md)

## License

This work is licensed under a Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License.

## [Documentation](NETN-LOG.md)