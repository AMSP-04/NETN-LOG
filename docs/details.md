
## ETR Task Handling

The following sections define how tasks shall be handled.

### ETR Task Modes

The ETR FOM module defines two modes for a task: non-concurrent mode and concurrent mode.

In the non-concurrent mode the task is placed on the task list for the entity, which serves as a waiting list. Once the task is at the head of the task list, and the currently executing task completes, it is removed from the task list and started. Using this task mode, tasks are executed one after the other.

In the concurrent mode, the task is executed concurrently with other tasks. With this task mode, there is no task list involved.

The mode value is provided for each task. So, at any point in time an entity has zero or more concurrent mode tasks executing and at most one non-concurrent mode task executing, with zero or more non-concurrent mode tasks waiting on the task list.

### ETR Task States

The following states are defined for a task:

* TaskStatus.Received: the task is received;
* TaskStatus.Waiting: the task is waiting for execution;
* TaskStatus.Executing: the task is executing.

The task state diagram is shown below.

<img src="./images/etr_taskstates.png" width="75%"/>
  
#### Received State
A task in the Received state shall be handled in the following way:
 
1. Determine if the task is supported. The determination is made by the federate application in accordance with section 8.4.3.
2. If the task is not supported then
    * A `TaskStatusReport` (refused) shall be returned to the Tasker.
    * The task is removed.
3. Else
    * For a non-concurrent mode task:
        * The task shall be placed in the entity task list in accordance with section 8.3.3.
    * A `TaskStatusReport` (accepted) shall be returned to the Tasker.
    * The task shall transition to the Waiting state.

#### Waiting State
A task in the Waiting state shall be handled in the following way:
1.	Determine if the task can start using the following conditions:
    * For a non-concurrent mode task:
        * The task’s taskee is not executioning a task, and
        * The task is at head of the task list, and
        * The task has no `StartWhen` time (i.e. the StartWhen is undefined), or the task has a StartWhen time and this time is less than or equal to the current time.
    * For a concurrent mode task:
        * The task has no `StartWhen` time (i.e. the StartWhen is undefined), or the task has a StartWhen time and this time is less than or equal to the current time, and
        * The task does not conflict with other executing tasks (see section 8.3.4).
2.	If the task can start then
    * For a non-concurrent mode task:
        * The task shall be removed from the task list.
        * A `TaskStatusReport` (executing) shall be returned to the Tasker.
        * The task shall transition to the Executing state.
3.	Else
    * The task shall remain in the Waiting state, even if the current time has passed the time specified in the `StartWhen` parameter of the task.

#### Executing State
A task in the Executing state shall be handled in the following way:

1.	Determine if the task has completed. The conditions are scenario specific and the determination is up to the federate application.
2.	If the task has completed then
    * A `TaskStatusReport` (completed) shall be returned to the Tasker.
    * The task is removed.
3.	Else
    * The task shall remain in the Executing state.

#### TaskStatus State
A task in the TaskStatus state shall be handled as specified in the substates, and also in the following way:

1.	If the task is cancelled by either a `CancelAllTasks` or `CancelSpecifiedTask` then
    * A `TaskStatusReport` (cancelled) shall be returned to the Tasker.
    * The task is removed.
2.	If the task cannot be handled due to an internal federate application error then
    * A `TaskStatusReport` (error) shall be returned to the Tasker and a description of the error shall be included in the message.
    * The task is removed.

### Task List Order
Each entity has a task list for non-concurrent mode tasks. The task at the head of the list is the first task to be started once the currently executing task completes. The ordering of tasks in the task list shall be according to the following figure.

<img src="./images/etr_tasklist.png" width="75%"/>
 
The tasklist shall be divided in two parts: a left part that contains tasks where the StartWhen is specified, and a right part that contains tasks where no StartWhen is specified. The division point shall mark the head of the left part and the tail of the right part. A part is empty if there are no tasks for that part.

A task shall be placed in the task list as follows:

1.	If the StartWhen time of the task is specified then the task shall be placed in the left part of the task list, using the StartWhen time to order the tasks in this part (with decreasing StartWhen value towards the head of the list).
2.	If the StartWhen time of the task is not specified then the task shall be placed at the tail of the right part of the task list.

###	Concurrent Tasks
The following table defines which tasks for the same entity can execute concurrently. The table shows which tasks can transition from the Waiting state to the Execution state given another task that is already in Execution state for the same entity. 

|Number|Task in Execution state|Tasks allowed to go to Execution state|
|---|---|---|
|1|Move|6, 7, 10, 11, 12, 13, 14, 15, 17, 22|
|2|MoveToLocation|10, 11, 12, 13, 14, 15, 17, 22|
|3|MoveToEntity|10, 11, 12, 13, 14, 15, 17, 22|
|4|MoveIntoFormation|10, 11, 12, 13, 14, 15, 17|
|5|FollowEntity|10, 11, 12, 13, 14, 15, 17|
|6|TurnToHeading|1|
|7|TurnToOrientation|1|
|8|MountVehicle| |
|9|DismountVehickle| |
|10|FireAtLocation|1, 2, 3, 4, 5, 18, 19|
|11|FireAtLocationWM|1, 2, 3, 4, 5, 18, 19|
|12|FireAtEntity|1, 2, 3, 4, 5, 18, 19|
|13|FireAtEntityWM|1, 2, 3, 4, 5, 18, 19|
|14|SetOrderedSpeed|1, 2, 3, 4, 5, 18, 19|
|15|SetOrderedAltitude|1, 2, 3, 4, 5, 18, 19|
|16|Wait| |
|17|SetRulesOfEngagement|1, 2, 3, 4, 5, 18, 19|
|18|Patrol|10, 11, 12, 13, 14, 15, 17|
|19|PatrolRepeating|10, 11, 12, 13, 14, 15, 17|
|20|EstablishCheckPoint| |
|21|OperateCheckPoint| |
|22|StopAtSideOfRoad|1, 2, 3|
|23|RemoveCheckPoint| |
|24|CreateObstacle| |
|25|CreateMinefield| |
|26|ClearObstacle| |
|27|AddPassage| |
|28|RemovePassage| |

## ETR SimCon Handling
A Simulation Control message for an entity shall be executed immediately, regardless the presence of any (concurrent or non-concurrent) executing task.

### Magic Move
A `MagicMove` for an entity shall implicitly cancel all tasks for the entity. A TaskStatusReport (cancelled) shall be issued for each task in accordance with the task state diagram.

### Magic Resources
A `MagicResource` shall update the entity resources. Waiting or executing tasks of the entity are effected in the sense that these tasks have more or less resources available after the MagicResource.

### Entity Task and Reporting Capabilities
It shall be possible to query an entity for the ETR tasks and ETR reports that it supports. The set of tasks and reports that an entity supports is implementation specific, and shall be used in the Received state of a task to determine if the task is supported.

With the interaction class `QueryCapabilitiesSupported` an entity can be queried for the supported ETR tasks and ETR reports. The result is provided via the interaction class `CapabilitiesSupported`.

## Implementation Requirements
This section lists the requirements for federate applications that implement Entity Tasking and Reporting. The requirements are provided from receiver point of view (entity taskee, the federate application modelling the entity) and sender point of view (entity tasker, the federate application sending a task or receiving a report for an entity).

The receiver:
1.	SHALL support all ETR TaskManagement and ETR SimCon classes.
2.	MAY support a subset of the ETR Task and ETR Report classes.
3.	SHALL provide all interaction class parameters when sending an ETR interaction.
The sender:
4.	SHALL provide all interaction class parameters when sending an ETR interaction.
In addition, for the receiver, the following SHALL be documented in the federation agreements:
5.	Distance tolerances of supported tasks (for the tasks `Mount`, `EstablishCheckPoint`, `OperateCheckPoint`, `RemoveCheckPoint`, `CreateObstacle`, `ClearObstacle`, `CreateMinefield`, `AddPassage`, and `RemovePassage`).
6.	Entities that provide ETR Reports.
7.	Time frequencies and conditions for the supported ETR Reports.
8.	Modeling agreements related to checkpoints (if supported, see `EstablishCheckPoint`, `OperateCheckPoint`, and `RemoveCheckPoint`).
9.	Modeling agreements related to minefields (if supported, see `CreateMineField`).