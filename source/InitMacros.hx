package;

import util.CPPExternMacro;

class InitMacros
{
    public static function main()
    {
        CPPExternMacro.PATH = '../../lib/';

        CPPExternMacro.generate([
            {
                name: 'Extern',
                file: 'example',
                fields: [
                    {
                        name: 'example',
                        arguments: [
                            {
                                name: 'text',
                                type: 'String'
                            }
                        ]
                    }
                ]
            }
        ]);
    }
}