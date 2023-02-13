/**
 * @id javascript/007-op-rename-entity-ticket-warning
 * @kind problem
 * @name 007-op-rename-entity-ticket-warning
 * @description Warning: Assignment referencing the name of a renamed entity
 * @problem.severity warning
 */
import javascript
import utils

from Assignment assignment
where checkExprEvaluatesToString(assignment.getRhs(), "Ticket")
select assignment, "Ticket: This entity has been renamed to \"Active_Ticket\"."
