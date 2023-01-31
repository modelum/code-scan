/**
 * @id javascript/021-op-rename-feature-movies-newtitle-error
 * @kind problem
 * @name 021-op-rename-feature-movies-newtitle-error
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
      checkPropertyAccess(method.getReceiver(), "movies")
      or
      checkExprIsCollectionMethod(method.getReceiver(), "movies")
      or
      checkExprIsCollectionObject(method.getReceiver(), "movies")
    )
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
    checkIsMongooseExport(method, "movies")
    and
    (
      checkFeatureIsInMongooseSchema(method.getArgument(1), "title")
      or
      checkFeatureIsInMongooseSchemaVarRef(method.getArgument(1), "title")
    )
  )
select method, "movies.title: This feature has been renamed to \"newTitle\"."
