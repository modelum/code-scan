/**
 * @id javascript/024-op-copy-feature-foods-title-warning
 * @kind problem
 * @name 024-op-copy-feature-foods-title-warning
 * @description Warning: A feature was copied to an entity
 * @problem.severity warning
 */
import javascript
import utils

from MethodCallExpr method
where
  checkIsMongooseExport(method, "foods")
  and
  (
    not checkFeatureIsInMongooseSchema(method.getArgument(1), "title")
    and
    not checkFeatureIsInMongooseSchemaVarRef(method.getArgument(1), "title")
  )
select method, "foods.title: This feature has been copied here."
