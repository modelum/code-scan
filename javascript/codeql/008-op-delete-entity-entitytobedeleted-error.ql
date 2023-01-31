/**
 * @id javascript/008-op-delete-entity-entitytobedeleted-error
 * @kind problem
 * @name 008-op-delete-entity-entitytobedeleted-error
 * @description Error: Attempting to access a deleted entity
 * @problem.severity error
 */
import javascript
import utils

from Expr expr
where
  checkPropertyAccess(expr, "EntityToBeDeleted")
  or
  checkExprIsCollectionMethod(expr, "EntityToBeDeleted")
  or
  checkIsMongooseExport(expr, "EntityToBeDeleted")
select expr, "EntityToBeDeleted: This entity has been deleted."
