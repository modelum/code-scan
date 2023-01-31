/**
 * @id javascript/006-op-add-entity-addedentity-warning
 * @kind problem
 * @name 006-op-add-entity-addedentity-warning
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
select method, "WARNING: Access to all Collections now grants a new entity: AddedEntity"
