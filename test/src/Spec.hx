package ;

import sys.FileSystem;
import sys.io.File;

import haxe.unit.TestRunner;

import necmark.Necmark;

using StringTools;

class Spec
{
	static function main() new Spec().run();

	
	var r : TestRunner;

    public function new( )
    {
        init();
    }
	public function run( ) : Void
	{
		r.run();
	}

    function init( ) : Void
    {
		r = new TestRunner();

        var spec = null;
        for( f in ['spec.txt', 'bin/spec.txt', 'test/bin/spec.txt']) if( FileSystem.exists(f) )
        {
            spec = File.getContent(f);
            break;
        }

        if( spec != null )
			process(spec);
    }

    function process( spec : String ) : Void
    {
		var lines = spec.split('\n');

		var eHead : EReg = ~/^(#+) +(.*)/;

		var lineNum = 0;
		var state = 0;

		var example = 0;
		var startLine = 0;
		var endLine = 0;

		var header = '';
		var markdown = [];
		var html = [];

		var pattern1 = '`'.rpad('`', 32) + ' example';
		var pattern2 = '`'.rpad('`', 32);
		var pattern3 = '.';

		for ( l in lines )
		{
			lineNum++;

			if ( l == pattern1 )
			{
				state = 1;
			}
			else if ( l == pattern2 )
			{
				state = 0;
				example++;
				endLine = lineNum;
				
				r.add(new StringTest(
					markdown.join('').replace('→', "\t"),
					html.join('').replace('→',"\t"),
					header, example, startLine, endLine
				));

				startLine = 0;
				markdown = [];
				html = [];
			}
			else if ( l == pattern3 )
			{
				state = 2;
			}
			else if ( state == 1 )
			{
				if ( startLine == 0 )
					startLine = lineNum - 1;
				
				markdown.push(l + '\n');
			}
			else if ( state == 2 )
			{
				html.push(l + '\n');
			}
			else if ( state == 0 && eHead.match(l) )
			{
				header = eHead.matched(2);
			}
        }
    }
}

class StringTest extends haxe.unit.TestCase
{
	var src : String;
	var res : String;
	
	var header : String;
	var num : Int;

	var start : Int;
	var end : Int;
	
	
	public function new( src : String, res : String, header : String, num : Int, start : Int, end : Int )
	{
		super();
		
		this.src = src;
		this.res = res;
		
		this.header = header;
		this.num = num;
		this.start = start;
		this.end = end;
	}
	
	public function testCoversion( ) : Void
	{
		var n : Necmark = new Necmark(src);

		assertEquals(
			res,
			n.render(ncrHtml(Necmark.OPT_DEFAULT | Necmark.RENDER_OPT_UNSAFE))
		);
	}
	
	override public function setup( ) : Void
	{
		super.setup();
		
		currentTest.classname = 'Example $num (lines $start-$end) $header';
		
		print(currentTest.classname + " ");
	}
}