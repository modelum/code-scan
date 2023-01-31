/**
 * @id javascript/026-op-move-feature-movies-to-foods-error
 * @kind problem
 * @name 026-op-move-feature-movies-to-foods-error
 * @description Error: Attempting to access a moved feature
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
select method, "movies.title: This feature has been moved to \"foods.title\"."
