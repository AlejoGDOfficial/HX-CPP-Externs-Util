package;

import util.CPPExternMacro;

import sys.io.File;

import haxe.Json;

typedef ExternsConfig = {
    path:String,
    classes:Array<TypeConfig>
}

class InitMacros
{
    public static function main()
    {
        final config:ExternsConfig = cast Json.parse(File.getContent('externsConfig.json'));

        CPPExternMacro.PATH = config.path;

        CPPExternMacro.generate(config.classes);
    }
}