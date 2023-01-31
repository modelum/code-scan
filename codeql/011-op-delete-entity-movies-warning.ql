/**
 * @id javascript/011-op-delete-entity-movies-warning
 * @kind problem
 * @name 011-op-delete-entity-movies-warning
 * @description Warning: Assignment referencing the name of a deleted entity
 * @problem.severity warning
 */
import javascript
import utils

from Assignment assignment
where checkExprEvaluatesToString(assignment.getRhs(), "movies")
select assignment, "movies: This entity has been deleted."
