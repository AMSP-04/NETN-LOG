# NETN LOG

The NATO Education and Training Network Logistics Module (NETN LOG).

## Background
Military logistics is the discipline of planning and carrying out the movement and maintenance of military forces including storage, distribution, maintenance and transportation of materiel.

## Description

This module is a specification of how to model logistics services in a federated distributed simulation. 

The specification is based on IEEE 1516 High Level Architecture (HLA) Object Model Template (OMT) and primarily intended to support interoperability in a federated simulation (federation) based on HLA. A Federation Object Model (FOM) Module is used to specify how data is represented and exchanged in the federation. The NETN LOG FOM module is available as an [XML file](NETN-LOG.xml) for use in HLA based federations.

## Purpose

NETN LOG provides a common standard interface for negotiation, delivery, and acceptance of logistics services between federates modelling different entities involved in the service transaction. E.g simulation of the transport of a unit modelled in another simulator.

## Scope

NETN LOG covers the following services:

* Supply Service offered by a federate capable of simulating the transfer of supplies to the consumer.
* Storage Service offered by a federate capable of simulating receiving the transfer of supplies from the consumer.
* Transport Service offered by a federate capable of simulating loading, transport and/or unloading of non-consumable materiel.
* Repair Service offered by a federate capable of simulating repair of consumer provided non-consumable materiel, e.g platforms.

Examples of use:

* Refuelling of aircraft at an airbase or in the air
* Transport of supplies between facilities
* Repair of damaged platforms in a facility or by unit
* Transport of units, platforms, and humans by train, ship, or aircraft   		

## [Changelog](changelog.md)

## [License](LICENSE.md)

Copyright (C) 2019 NATO/OTAN.
This work is licensed under a Creative Commons Attribution-NoDerivatives 4.0 International License.

## [Documentation](NETN-LOG.md)
