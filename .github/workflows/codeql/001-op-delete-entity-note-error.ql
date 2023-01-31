/**
 * @id javascript/001-op-delete-entity-note-error
 * @kind problem
 * @name 001-op-delete-entity-note-error
 * @description Error: Attempting to access a deleted entity
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
select expr, "Note: This entity has been deleted."
