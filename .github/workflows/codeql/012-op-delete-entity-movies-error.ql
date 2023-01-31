/**
 * @id javascript/012-op-delete-entity-movies-error
 * @kind problem
 * @name 012-op-delete-entity-movies-error
 * @description Error: Attempting to access a deleted entity
 * @problem.severity error
 */
import javascript
import utils

from Expr expr
where
  checkPropertyAccess(expr, "movies")
  or
  checkExprIsCollectionMethod(expr, "movies")
  or
  checkIsMongooseExport(expr, "movies")
select expr, "movies: This entity has been deleted."
