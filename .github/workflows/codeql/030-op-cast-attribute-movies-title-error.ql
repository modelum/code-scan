/**
 * @id javascript/030-op-cast-attribute-movies-title-error
 * @kind problem
 * @name 030-op-cast-attribute-movies-title-error
 * @description Error: Attempting to access a feature whose type changed to Double in a specific entity
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
select method, "movies.title: This feature's type has changed to: Double"
