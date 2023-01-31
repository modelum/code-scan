/**
 * @id javascript/017-op-delete-entity-theaters-warning
 * @kind problem
 * @name 017-op-delete-entity-theaters-warning
 * @description Warning: Assignment referencing the name of a deleted entity
 * @problem.severity warning
 */
import javascript
import utils

from Assignment assignment
where checkExprEvaluatesToString(assignment.getRhs(), "theaters")
select assignment, "theaters: This entity has been deleted."
