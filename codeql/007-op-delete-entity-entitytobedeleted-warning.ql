/**
 * @id javascript/007-op-delete-entity-entitytobedeleted-warning
 * @kind problem
 * @name 007-op-delete-entity-entitytobedeleted-warning
 * @description Warning: Assignment referencing the name of a deleted entity
 * @problem.severity warning
 */
import javascript
import utils

from Assignment assignment
where checkExprEvaluatesToString(assignment.getRhs(), "EntityToBeDeleted")
select assignment, "EntityToBeDeleted: This entity has been deleted."
