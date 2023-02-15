/**
 * @id softwaredev-1/009-op-add-entity-archived-ticket-warning
 * @kind problem
 * @name Add Entity: Archived_Ticket
 * @description Warning: New entity when retrieving all collections
 * @problem.severity warning
 */
import javascript
import utils

from MethodCallExpr method
where
  checkIsMDBCollectionsMethod(method.getMethodName())
  and
  (
    checkExprIsDBMethod(method.getReceiver())
    or
    checkExprIsDBObject(method.getReceiver())
  )
select method, "WARNING: Access to all Collections now grants a new entity: Archived_Ticket"
