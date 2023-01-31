/**
 * @id javascript/003-op-rename-entity-note-error
 * @kind problem
 * @name 003-op-rename-entity-note-error
 * @description Error: Attempting to access a renamed entity
 * @problem.severity error
 */
import javascript
import utils

from Expr expr
where
  checkPropertyAccess(expr, "Note")
  or
  checkExprIsCollectionMethod(expr, "Note")
  or
  checkIsMongooseExport(expr, "Note")
select expr, "Note: This entity has been renamed to \"NewNote\"."
