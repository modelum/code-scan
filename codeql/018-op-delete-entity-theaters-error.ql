/**
 * @id javascript/018-op-delete-entity-theaters-error
 * @kind problem
 * @name 018-op-delete-entity-theaters-error
 * @description Error: Attempting to access a deleted entity
 * @problem.severity error
 */
import javascript
import utils

from Expr expr
where
  checkPropertyAccess(expr, "theaters")
  or
  checkExprIsCollectionMethod(expr, "theaters")
  or
  checkIsMongooseExport(expr, "theaters")
select expr, "theaters: This entity has been deleted."
