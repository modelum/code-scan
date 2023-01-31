/**
 * @id javascript/002-op-rename-entity-note-warning
 * @kind problem
 * @name 002-op-rename-entity-note-warning
 * @description Warning: Assignment referencing the name of a renamed entity
 * @problem.severity warning
 */
import javascript
import utils

from Assignment assignment
where checkExprEvaluatesToString(assignment.getRhs(), "Note")
select assignment, "Note: This entity has been renamed to \"NewNote\"."
