/**
 * @id softwaredev-1/004-op-add-attribute-repository-subscribers-warning
 * @kind problem
 * @name Add Attribute: subscribers
 * @description Warning: An attribute was added to an entity
 * @problem.severity warning
 */
import javascript
import utils

from MethodCallExpr method
where
  checkIsMongooseExport(method, "Repository")
  and
  (
    not checkFeatureIsInMongooseSchema(method.getArgument(1), "subscribers")
    and
    not checkFeatureIsInMongooseSchemaVarRef(method.getArgument(1), "subscribers")
  )
select method, "Repository.subscribers: This attribute has been added."
