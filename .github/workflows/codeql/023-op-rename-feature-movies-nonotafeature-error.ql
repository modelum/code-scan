/**
 * @id javascript/023-op-rename-feature-movies-nonotafeature-error
 * @kind problem
 * @name 023-op-rename-feature-movies-nonotafeature-error
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
      checkFeatureIsInObject(method.getAnArgument(), "notafeature")
      or
      checkFeatureIsInVarRef(method.getAnArgument(), "notafeature")
      or
      checkFeatureIsInArray(method.getAnArgument(), "notafeature")
      or
      checkExprEvaluatesToString(method.getAnArgument(), "notafeature")
    )
  )
  or
  (
    checkIsMongooseExport(method, "movies")
    and
    (
      checkFeatureIsInMongooseSchema(method.getArgument(1), "notafeature")
      or
      checkFeatureIsInMongooseSchemaVarRef(method.getArgument(1), "notafeature")
    )
  )
select method, "movies.notafeature: This feature has been renamed to \"nonotafeature\"."
