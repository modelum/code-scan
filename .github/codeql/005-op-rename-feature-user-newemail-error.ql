/**
 * @id javascript/005-op-rename-feature-user-newemail-error
 * @kind problem
 * @name 005-op-rename-feature-user-newemail-error
 * @description Error: Attempting to access a renamed feature in a specific entity
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
      checkPropertyAccess(method.getReceiver(), "User")
      or
      checkExprIsCollectionMethod(method.getReceiver(), "User")
      or
      checkExprIsCollectionObject(method.getReceiver(), "User")
    )
    and
    (
      checkFeatureIsInObject(method.getAnArgument(), "email")
      or
      checkFeatureIsInVarRef(method.getAnArgument(), "email")
      or
      checkFeatureIsInArray(method.getAnArgument(), "email")
      or
      checkExprEvaluatesToString(method.getAnArgument(), "email")
    )
  )
  or
  (
    checkIsMongooseExport(method, "User")
    and
    (
      checkFeatureIsInMongooseSchema(method.getArgument(1), "email")
      or
      checkFeatureIsInMongooseSchemaVarRef(method.getArgument(1), "email")
    )
  )
select method, "User.email: This feature has been renamed to \"newEmail\"."
