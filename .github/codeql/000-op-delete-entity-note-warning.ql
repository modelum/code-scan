/**
 * @id javascript/000-op-delete-entity-note-warning
 * @kind problem
 * @name 000-op-delete-entity-note-warning
 * @description Warning: Assignment referencing the name of a deleted entity
 * @problem.severity warning
 */
import javascript
import utils

from Assignment assignment
where checkExprEvaluatesToString(assignment.getRhs(), "Note")
select assignment, "Note: This entity has been deleted."
