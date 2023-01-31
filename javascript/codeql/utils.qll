import javascript

/**
 * Check if a property access is like: <.db(...) | obj>.entityName
 */
predicate checkPropertyAccess(PropAccess property, string entityName)
{
  property.getPropertyName() = entityName
  and
  (checkExprIsDBMethod(property.getBase()) or checkExprIsDBObject(property.getBase()))
}

/**
 * Check if an expression is like: <.db(...) | .getDB(...)>
 */
predicate checkExprIsDBMethod(MethodCallExpr receiver)
{
  (receiver.getMethodName() = "db" or receiver.getMethodName() = "getDB")
  and
  receiver.getNumArgument() < 3
  // And receiver.getReceiver() is a MongoDB object and so on and so on...
  // And its first argument is a string...
}

/**
 * Check if an expression is an object obtained by means of a .db(...) method
 */
predicate checkExprIsDBObject(VarRef ref)
{
  checkExprIsDBMethod(ref.getVariable().getAnAssignedExpr())
  or
  checkExprIsDBObject(ref.getVariable().getAnAssignedExpr())
}

/**
 * Check if an expression is like: <.collection(...) | .getCollection(...)>
 */
predicate checkExprIsCollectionMethod(MethodCallExpr method, string entityName)
{
  (method.getMethodName() = "collection" or method.getMethodName() = "getCollection")
  and
  checkExprEvaluatesToString(method.getArgument(0), entityName)
  and
  (checkExprIsDBMethod(method.getReceiver()) or checkExprIsDBObject(method.getReceiver()))
}

/**
 * Check if an expression is an object obtained by means of a .collection(...) method
 */
predicate checkExprIsCollectionObject(VarRef ref, string entityName)
{
  checkExprIsCollectionMethod(ref.getVariable().getAnAssignedExpr(), entityName)
  or
  checkExprIsCollectionObject(ref.getVariable().getAnAssignedExpr(), entityName)
}

/**
 * Check if an expression evaluates to a string.
 */
predicate checkExprEvaluatesToString(Expr expr, string entityName)
{
  expr.getStringValue() = entityName
  or
  checkVarRefEvaluatesToString(expr, entityName)
}

/**
 * Check if a variable evaluates, recursively, to a string.
 */
predicate checkVarRefEvaluatesToString(VarRef ref, string entityName)
{
  checkExprEvaluatesToString(ref.getVariable().getAnAssignedExpr(), entityName)
  or
  checkVarRefEvaluatesToString(ref.getVariable().getAnAssignedExpr(), entityName)
}

/**
 * Check if an object has a property with a specific name. If not, checks recursively if that name appears on any value that is an object, a var or an array.
 */
predicate checkFeatureIsInObject(ObjectExpr obj, string featureName)
{
  exists(Property prop | obj.getAProperty() = prop and prop.getName() = featureName)
  or
  exists(Property prop | obj.getAProperty() = prop and
  (
    checkFeatureIsInObject(prop.getInit(), featureName)
    or
    checkFeatureIsInVarRef(prop.getInit(), featureName)
    or
    checkFeatureIsInArray(prop.getInit(), featureName)
  ))
}

/**
 * Check if a var contains an object, a var or an array with a property with a specific name.
 */
predicate checkFeatureIsInVarRef(VarRef var, string featureName)
{
  checkFeatureIsInObject(var.getVariable().getAnAssignedExpr(), featureName)
  or
  checkFeatureIsInVarRef(var.getVariable().getAnAssignedExpr(), featureName)
  or
  checkFeatureIsInArray(var.getVariable().getAnAssignedExpr(), featureName)
}

/**
 * Check if an array contains an object or a var a property with a specific name.
 */
predicate checkFeatureIsInArray(ArrayExpr array, string featureName)
{
  exists(Expr expr | array.getAnElement() = expr and
  (
    checkFeatureIsInObject(expr, featureName)
    or
    checkFeatureIsInVarRef(expr, featureName)
  ))
}

/**
 * Check if a method looks for all collections.
 */
predicate checkIsMDBCollectionsMethod(string methodName)
{
  methodName in ["getAllCollections", "listCollections", "getCollectionNames"]
}

/**
 * Check if a method is applied to a MongoDB database.
 */
predicate checkIsMDBDataMethod(string methodName)
{
  methodName in
  [
    "aggregate", "bulkWrite", "count", "countDocuments", "createIndex",
    "distinct", "deleteOne", "deleteMany", "insertOne", "insertMany",
    "find", "findOne", "findOneAndDelete", "findOneAndUpdate", "project",
    "replaceOne", "sort", "updateOne", "updateMany"
  ]
}

/**
 * Check if a method is a model() call with a mongoose schema.
 */
predicate checkIsAnyMongooseExport(MethodCallExpr method)
{
  method.getMethodName() = "model"
  and
  (checkExprIsNewMongooseSchema(method.getArgument(1)) or checkVarRefIsNewMongooseSchema(method.getArgument(1)))
}

/**
 * Check if a method is a model() call with a mongoose schema and a specific entity name.
 */
predicate checkIsMongooseExport(MethodCallExpr method, string entityName)
{
  checkIsAnyMongooseExport(method)
  and
  checkExprEvaluatesToString(method.getArgument(0), entityName)
}

/**
 * Check if a NEW expression is a Mongoose.Schema() call.
 */
predicate checkExprIsNewMongooseSchema(NewExpr newExpr)
{
  newExpr.getCalleeName() = "Schema"
}

/**
 * Check if a NEW expression is contained within a variable.
 */
predicate checkVarRefIsNewMongooseSchema(VarRef ref)
{
  checkExprIsNewMongooseSchema(ref.getVariable().getAnAssignedExpr())
  or
  checkVarRefIsNewMongooseSchema(ref.getVariable().getAnAssignedExpr())
}

/**
 * Check if a NEW Mongoose schema holds a feature with a certain name.
 */
predicate checkFeatureIsInMongooseSchema(NewExpr newExpr, string featureName)
{
  checkFeatureIsInMongooseSchemaDeclaration(newExpr.getArgument(0), featureName)
}

/**
 * Check if a NEW Mongoose schema stored in a variable holds a feature with a certain name.
 */
predicate checkFeatureIsInMongooseSchemaVarRef(VarRef ref, string featureName)
{
  checkFeatureIsInMongooseSchema(ref.getVariable().getAnAssignedExpr(), featureName)
  or
  checkFeatureIsInMongooseSchemaVarRef(ref.getVariable().getAnAssignedExpr(), featureName)
}

/**
 * Check if a feature exists on a Mongoose object newly created.
 */
predicate checkFeatureIsInMongooseSchemaDeclaration(ObjectExpr obj, string featureName)
{
  exists(Property prop | obj.getAProperty() = prop and prop.getName() = featureName)
}
