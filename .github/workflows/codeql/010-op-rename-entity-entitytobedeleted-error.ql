/**
 * @id javascript/010-op-rename-entity-entitytobedeleted-error
 * @kind problem
 * @name 010-op-rename-entity-entitytobedeleted-error
 * @description Error: Attempting to access a renamed entity
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
select expr, "EntityToBeDeleted: This entity has been renamed to \"NewRenamedEntity\"."
