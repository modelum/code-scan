/**
 * @id javascript/000-op-delete-feature-developer-permissions-error
 * @kind problem
 * @name 000-op-delete-feature-developer-permissions-error
 * @description Error: Attempting to access a deleted feature in a specific entity
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
      checkFeatureIsInObject(method.getAnArgument(), "permissions")
      or
      checkFeatureIsInVarRef(method.getAnArgument(), "permissions")
      or
      checkFeatureIsInArray(method.getAnArgument(), "permissions")
      or
      checkExprEvaluatesToString(method.getAnArgument(), "permissions")
    )
  )
  or
  (
    checkIsMongooseExport(method, "Developer")
    and
    (
      checkFeatureIsInMongooseSchema(method.getArgument(1), "permissions")
      or
      checkFeatureIsInMongooseSchemaVarRef(method.getArgument(1), "permissions")
    )
  )
select method, "Developer.permissions: This feature has been deleted."
