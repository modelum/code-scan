/**
 * @id javascript/014-op-delete-entity-foods-error
 * @kind problem
 * @name 014-op-delete-entity-foods-error
 * @description Error: Attempting to access a deleted entity
 * @problem.severity error
 */
import javascript
import utils

from Expr expr
where
  checkPropertyAccess(expr, "foods")
  or
  checkExprIsCollectionMethod(expr, "foods")
  or
  checkIsMongooseExport(expr, "foods")
select expr, "foods: This entity has been deleted."
