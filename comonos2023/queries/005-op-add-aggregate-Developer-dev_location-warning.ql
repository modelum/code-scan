/**
 * @id softwaredev-1/005-op-add-aggregate-developer-dev-location-warning
 * @kind problem
 * @name Add Aggregate: dev_location
 * @description Warning: An aggregate was added to an entity
 * @problem.severity warning
 */
import javascript
import utils

from MethodCallExpr method
where
  checkIsMongooseExport(method, "Developer")
  and
  (
    not checkFeatureIsInMongooseSchema(method.getArgument(1), "dev_location")
    and
    not checkFeatureIsInMongooseSchemaVarRef(method.getArgument(1), "dev_location")
  )
select method, "Developer.dev_location: This aggregate has been added."
