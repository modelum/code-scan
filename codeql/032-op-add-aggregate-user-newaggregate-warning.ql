/**
 * @id javascript/032-op-add-aggregate-user-newaggregate-warning
 * @kind problem
 * @name 032-op-add-aggregate-user-newaggregate-warning
 * @description Warning: An aggregate was added to an entity
 * @problem.severity warning
 */
import javascript
import utils

from MethodCallExpr method
where
  checkIsMongooseExport(method, "User")
  and
  (
    not checkFeatureIsInMongooseSchema(method.getArgument(1), "newAggregate")
    and
    not checkFeatureIsInMongooseSchemaVarRef(method.getArgument(1), "newAggregate")
  )
select method, "User.newAggregate: This aggregate has been added."
