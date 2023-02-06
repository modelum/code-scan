/**
 * @id javascript/009-op-rename-entity-entitytobedeleted-warning
 * @kind problem
 * @name 009-op-rename-entity-entitytobedeleted-warning
 * @description Warning: Assignment referencing the name of a renamed entity
 * @problem.severity warning
 */
import javascript
import utils

from Assignment assignment
where checkExprEvaluatesToString(assignment.getRhs(), "EntityToBeDeleted")
select assignment, "EntityToBeDeleted: This entity has been renamed to \"NewRenamedEntity\"."
