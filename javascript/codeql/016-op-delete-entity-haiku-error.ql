/**
 * @id javascript/016-op-delete-entity-haiku-error
 * @kind problem
 * @name 016-op-delete-entity-haiku-error
 * @description Error: Attempting to access a deleted entity
 * @problem.severity error
 */
import javascript
import utils

from Expr expr
where
  checkPropertyAccess(expr, "haiku")
  or
  checkExprIsCollectionMethod(expr, "haiku")
  or
  checkIsMongooseExport(expr, "haiku")
select expr, "haiku: This entity has been deleted."
