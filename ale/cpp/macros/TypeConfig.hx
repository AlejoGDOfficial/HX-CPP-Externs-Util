package ale.cpp.macros;

typedef TypeConfig = {
    path:String,
    ?file:String,
    ?functions:Array<TypeConfigFunction>,
    ?variables:Array<TypeConfigVariable>,
    ?include:String,
    ?native:String,
    ?xml:String
}