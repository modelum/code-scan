/**
 * @id javascript/025-op-add-attribute-note-newattr-warning
 * @kind problem
 * @name 025-op-add-attribute-note-newattr-warning
 * @description Warning: An attribute was added to an entity
 * @problem.severity warning
 */
import javascript
import utils

from MethodCallExpr method
where
  checkIsMongooseExport(method, "Note")
  and
  (
    not checkFeatureIsInMongooseSchema(method.getArgument(1), "newAttr")
    and
    not checkFeatureIsInMongooseSchemaVarRef(method.getArgument(1), "newAttr")
  )
select method, "Note.newAttr: This attribute has been added."
