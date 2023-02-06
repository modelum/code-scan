/**
 * @id javascript/004-op-delete-feature-user-name-error
 * @kind problem
 * @name 004-op-delete-feature-user-name-error
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
      checkPropertyAccess(method.getReceiver(), "User")
      or
      checkExprIsCollectionMethod(method.getReceiver(), "User")
      or
      checkExprIsCollectionObject(method.getReceiver(), "User")
    )
    and
    (
      checkFeatureIsInObject(method.getAnArgument(), "name")
      or
      checkFeatureIsInVarRef(method.getAnArgument(), "name")
      or
      checkFeatureIsInArray(method.getAnArgument(), "name")
      or
      checkExprEvaluatesToString(method.getAnArgument(), "name")
    )
  )
  or
  (
    checkIsMongooseExport(method, "User")
    and
    (
      checkFeatureIsInMongooseSchema(method.getArgument(1), "name")
      or
      checkFeatureIsInMongooseSchemaVarRef(method.getArgument(1), "name")
    )
  )
select method, "User.name: This feature has been deleted."
