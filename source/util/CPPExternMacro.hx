package util;

import haxe.macro.TypeTools;
import haxe.macro.Context;
import haxe.macro.Expr;

typedef TypeConfigFieldArgument = {
    name:String,
    type:String
}

typedef TypeConfigField = {
    name:String,
    arguments:Array<TypeConfigFieldArgument>
}

typedef TypeConfig = {
    name:String,
    file:String,
    fields:Array<TypeConfigField>
}

class CPPExternMacro
{
    public static var PATH:String = '';

    public static function generate(types:Array<TypeConfig>)
    {
        for (type in types)
        {
            if (type == null)
                continue;

            final path:String = PATH + type.file + '.cpp';

            final fields:Array<Field> = [
                for (field in type.fields)
                {
                    {
                        name: field.name,
                        access: [APublic, AStatic],
                        meta: [{
                            name: ':native',
                            params: [ macro 'example' ],
                            pos: Context.currentPos()
                        }],
                        kind: FFun({
                            args: [
                                for (arg in field.arguments)
                                {
                                    {
                                        name: arg.name,
                                        type: TypeTools.toComplexType(Context.getType(arg.type))
                                    }
                                }
                            ],
                            ret: macro : Void
                        }),
                        pos: Context.currentPos()
                    }
                }
            ];

            Context.defineType({
                pack: [],
                name: type.name,
                kind: TDClass(null, null, false),
                meta: [
                    {
                        name: ':include',
                        params: [
                            macro $v{path},
                        ],
                        pos: Context.currentPos()
                    }
                ],
                isExtern: true,
                fields: fields,
                pos: Context.currentPos()
            });
        }
    }
}