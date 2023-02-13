/**
 * @id javascript/002-op-rename-feature-all-rank-stars-error
 * @kind problem
 * @name 002-op-rename-feature-all-rank-stars-error
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
      checkFeatureIsInObject(method.getAnArgument(), "num_stars")
      or
      checkFeatureIsInVarRef(method.getAnArgument(), "num_stars")
      or
      checkFeatureIsInArray(method.getAnArgument(), "num_stars")
      or
      checkExprEvaluatesToString(method.getAnArgument(), "num_stars")
    )
  )
  or
  (
    checkIsMongooseExport(method, "")
    and
    (
      checkFeatureIsInMongooseSchema(method.getArgument(1), "num_stars")
      or
      checkFeatureIsInMongooseSchemaVarRef(method.getArgument(1), "num_stars")
    )
  )
select method, "all.num_stars: This feature has been renamed to \"rank_stars\"."
