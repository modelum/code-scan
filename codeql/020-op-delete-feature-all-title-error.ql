/**
 * @id javascript/020-op-delete-feature-all-title-error
 * @kind problem
 * @name 020-op-delete-feature-all-title-error
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
      checkFeatureIsInObject(method.getAnArgument(), "title")
      or
      checkFeatureIsInVarRef(method.getAnArgument(), "title")
      or
      checkFeatureIsInArray(method.getAnArgument(), "title")
      or
      checkExprEvaluatesToString(method.getAnArgument(), "title")
    )
  )
  or
  (
    checkIsMongooseExport(method, "")
    and
    (
      checkFeatureIsInMongooseSchema(method.getArgument(1), "title")
      or
      checkFeatureIsInMongooseSchemaVarRef(method.getArgument(1), "title")
    )
  )
select method, "all.title: This feature has been deleted."
