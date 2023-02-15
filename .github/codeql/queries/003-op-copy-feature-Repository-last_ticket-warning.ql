/**
 * @id softwaredev-1/003-op-copy-feature-repository-last-ticket-warning
 * @kind problem
 * @name Copy Feature: last_activity_date
 * @description Warning: A feature was copied to an entity
 * @problem.severity warning
 */
import javascript
import utils

from MethodCallExpr method
where
  checkIsMongooseExport(method, "Repository")
  and
  (
    not checkFeatureIsInMongooseSchema(method.getArgument(1), "last_ticket")
    and
    not checkFeatureIsInMongooseSchemaVarRef(method.getArgument(1), "last_ticket")
  )
select method, "Repository.last_ticket: This feature has been copied here."
