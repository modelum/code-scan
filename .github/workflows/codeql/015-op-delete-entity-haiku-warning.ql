/**
 * @id javascript/015-op-delete-entity-haiku-warning
 * @kind problem
 * @name 015-op-delete-entity-haiku-warning
 * @description Warning: Assignment referencing the name of a deleted entity
 * @problem.severity warning
 */
import javascript
import utils

from Assignment assignment
where checkExprEvaluatesToString(assignment.getRhs(), "haiku")
select assignment, "haiku: This entity has been deleted."
