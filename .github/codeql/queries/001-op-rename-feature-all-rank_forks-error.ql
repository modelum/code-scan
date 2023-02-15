/**
 * @id softwaredev-1/001-op-rename-feature-all-rank-forks-error
 * @kind problem
 * @name Rename Feature: rank_forks
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
      checkFeatureIsInObject(method.getAnArgument(), "num_forks")
      or
      checkFeatureIsInVarRef(method.getAnArgument(), "num_forks")
      or
      checkFeatureIsInArray(method.getAnArgument(), "num_forks")
      or
      checkExprEvaluatesToString(method.getAnArgument(), "num_forks")
    )
  )
  or
  (
    checkIsMongooseExport(method, "")
    and
    (
      checkFeatureIsInMongooseSchema(method.getArgument(1), "num_forks")
      or
      checkFeatureIsInMongooseSchemaVarRef(method.getArgument(1), "num_forks")
    )
  )
select method, "all.num_forks: This feature has been renamed to \"rank_forks\"."
