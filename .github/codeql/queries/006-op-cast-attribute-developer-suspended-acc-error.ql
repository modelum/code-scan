/**
 * @id javascript/006-op-cast-attribute-developer-suspended-acc-error
 * @kind problem
 * @name 006-op-cast-attribute-developer-suspended-acc-error
 * @description Error: Attempting to access a feature whose type changed to Boolean in a specific entity
 * @problem.severity error
 */
import javascript
import utils

from MethodCallExpr method
where
  (
    checkIsMDBDataMethod(method.getMethodName())
    and
    (
      checkPropertyAccess(method.getReceiver(), "Developer")
      or
      checkExprIsCollectionMethod(method.getReceiver(), "Developer")
      or
      checkExprIsCollectionObject(method.getReceiver(), "Developer")
    )
    and
    (
      checkFeatureIsInObject(method.getAnArgument(), "suspended_acc")
      or
      checkFeatureIsInVarRef(method.getAnArgument(), "suspended_acc")
      or
      checkFeatureIsInArray(method.getAnArgument(), "suspended_acc")
      or
      checkExprEvaluatesToString(method.getAnArgument(), "suspended_acc")
    )
  )
  or
  (
    checkIsMongooseExport(method, "Developer")
    and
    (
      checkFeatureIsInMongooseSchema(method.getArgument(1), "suspended_acc")
      or
      checkFeatureIsInMongooseSchemaVarRef(method.getArgument(1), "suspended_acc")
    )
  )
select method, "Developer.suspended_acc: This feature's type has changed to: Boolean"
