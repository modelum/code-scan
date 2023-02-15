/**
 * @id softwaredev-1/008-op-rename-entity-ticket-error
 * @kind problem
 * @name Rename Entity: Ticket
 * @description Error: Attempting to access a renamed entity
 * @problem.severity error
 */
import javascript
import utils

from Expr expr
where
  checkPropertyAccess(expr, "Ticket")
  or
  checkExprIsCollectionMethod(expr, "Ticket")
  or
  checkIsMongooseExport(expr, "Ticket")
select expr, "Ticket: This entity has been renamed to \"Active_Ticket\"."
