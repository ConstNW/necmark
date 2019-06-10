package cases;

import necmark.Necmark;

import tink.unit.Assert.assert;

using tink.CoreApi;



class Version
{

    public function new() { }

    @:setup public function setup() return Noise;
    @:before public function before() return Noise;
    @:after public function after() return Noise;
    @:teardown public function teardown() return Noise;

    @:describe('Test String version')
    public function test_code( )
    {
        var v = Necmark.version();

        return assert(v.code == "0.29.0");
    }
    
    @:describe('Test Int version')
    public function test_num( )
    {
        var v = Necmark.version();

        return assert(v.num == 0x001d00);
    }

}