/**
 * @id javascript/013-op-delete-entity-foods-warning
 * @kind problem
 * @name 013-op-delete-entity-foods-warning
 * @description Warning: Assignment referencing the name of a deleted entity
 * @problem.severity warning
 */
import javascript
import utils

from Assignment assignment
where checkExprEvaluatesToString(assignment.getRhs(), "foods")
select assignment, "foods: This entity has been deleted."
