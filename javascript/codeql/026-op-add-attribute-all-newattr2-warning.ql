/**
 * @id javascript/026-op-add-attribute-all-newattr2-warning
 * @kind problem
 * @name 026-op-add-attribute-all-newattr2-warning
 * @description Warning: An attribute was added to an entity
 * @problem.severity warning
 */
import javascript
import utils

from MethodCallExpr method
where
  checkIsAnyMongooseExport(method)
  and
  (
    not checkFeatureIsInMongooseSchema(method.getArgument(1), "newAttr2")
    and
    not checkFeatureIsInMongooseSchemaVarRef(method.getArgument(1), "newAttr2")
  )
select method, "all.newAttr2: This attribute has been added."
