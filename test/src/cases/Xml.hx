package cases;

import necmark.Necmark;

import tink.unit.Assert.assert;
import tink.unit.AssertionBuffer;

using tink.CoreApi;

@:asserts
class Xml
{
    static var SAMPLE = ""
        + "Проверяем *CommonMark*.\n\nВставляем `код`.\nИ другие "
        + "[штуки](javascript:pwned).\n\n<p>Test of <em>XML</em>.</p>\n\n"
        + "Проверка---\"test\" -- test."
    ;
    public function new() { }

    @:setup public function setup() return Noise;
    @:before public function before() return Noise;
    @:after public function after() return Noise;
    @:teardown public function teardown() return Noise;

    @:describe('Test empty')
    public function test_empty( )
    {
        var expected = ''
            + '<?xml version="1.0" encoding="UTF-8"?>\n'
            + '<!DOCTYPE document SYSTEM "CommonMark.dtd">\n'
            + '<document xmlns="http://commonmark.org/xml/1.0" />\n'
        ;

        var n : Necmark = new Necmark("");

        asserts.assert(n.render(ncrXml(Necmark.OPT_DEFAULT | Necmark.RENDER_OPT_UNSAFE)) == expected);

        n.close();
        return asserts.done();
    }

    @:describe('Test ascii')
    public function test_ascii( )
    {
        var expected = ''
            + '<?xml version="1.0" encoding="UTF-8"?>\n'
            + '<!DOCTYPE document SYSTEM "CommonMark.dtd">\n'
            + '<document xmlns="http://commonmark.org/xml/1.0">\n'
            + '  <paragraph>\n'
            + '    <text xml:space="preserve">Hello, XML!</text>\n'
            + '  </paragraph>\n'
            + '</document>\n'
        ;
        
        var n : Necmark = new Necmark("Hello, XML!");
        
        asserts.assert(n.render(ncrXml(Necmark.OPT_DEFAULT | Necmark.RENDER_OPT_UNSAFE)) == expected);

        n.close();
        return asserts.done();
    }

    @:describe('Test sample')
    public function test_sample( )
    {
        var expected =
'<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE document SYSTEM "CommonMark.dtd">
<document xmlns="http://commonmark.org/xml/1.0">
  <paragraph>
    <text xml:space="preserve">Проверяем </text>
    <emph>
      <text xml:space="preserve">CommonMark</text>
    </emph>
    <text xml:space="preserve">.</text>
  </paragraph>
  <paragraph>
    <text xml:space="preserve">Вставляем </text>
    <code xml:space="preserve">код</code>
    <text xml:space="preserve">.</text>
    <softbreak />
    <text xml:space="preserve">И другие </text>
    <link destination="javascript:pwned" title="">
      <text xml:space="preserve">штуки</text>
    </link>
    <text xml:space="preserve">.</text>
  </paragraph>
  <html_block xml:space="preserve">&lt;p&gt;Test of &lt;em&gt;XML&lt;/em&gt;.&lt;/p&gt;
</html_block>
  <paragraph>
    <text xml:space="preserve">Проверка---&quot;test&quot; -- test.</text>
  </paragraph>
</document>
';
        var n : Necmark = new Necmark(SAMPLE);
        
        asserts.assert(n.render(ncrXml(Necmark.OPT_DEFAULT | Necmark.RENDER_OPT_UNSAFE)) == expected);

        n.close();
        return asserts.done();
    }

    @:describe('Test sourcepos')
    public function test_sourcepos( )
    {
        var expected =
'<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE document SYSTEM "CommonMark.dtd">
<document sourcepos="1:1-8:34" xmlns="http://commonmark.org/xml/1.0">
  <paragraph sourcepos="1:1-1:32">
    <text sourcepos="1:1-1:19" xml:space="preserve">Проверяем </text>
    <emph sourcepos="1:20-1:31">
      <text sourcepos="1:21-1:30" xml:space="preserve">CommonMark</text>
    </emph>
    <text sourcepos="1:32-1:32" xml:space="preserve">.</text>
  </paragraph>
  <paragraph sourcepos="3:1-4:47">
    <text sourcepos="3:1-3:19" xml:space="preserve">Вставляем </text>
    <code sourcepos="3:21-3:26" xml:space="preserve">код</code>
    <text sourcepos="3:28-3:28" xml:space="preserve">.</text>
    <softbreak />
    <text sourcepos="4:1-4:16" xml:space="preserve">И другие </text>
    <link sourcepos="4:17-4:46" destination="javascript:pwned" title="">
      <text sourcepos="4:18-4:27" xml:space="preserve">штуки</text>
    </link>
    <text sourcepos="4:47-4:47" xml:space="preserve">.</text>
  </paragraph>
  <html_block sourcepos="6:1-6:28" xml:space="preserve">&lt;p&gt;Test of &lt;em&gt;XML&lt;/em&gt;.&lt;/p&gt;
</html_block>
  <paragraph sourcepos="8:1-8:34">
    <text sourcepos="8:1-8:34" xml:space="preserve">Проверка---&quot;test&quot; -- test.</text>
  </paragraph>
</document>
';
        var n : Necmark = new Necmark(SAMPLE);
        
        asserts.assert(n.render(ncrXml(Necmark.OPT_DEFAULT | Necmark.RENDER_OPT_UNSAFE | Necmark.RENDER_OPT_SOURCEPOS)) == expected);

        n.close();
        return asserts.done();
    }

    @:describe('Test smart')
    public function test_smart( )
    {
        var expected =
'<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE document SYSTEM "CommonMark.dtd">
<document xmlns="http://commonmark.org/xml/1.0">
  <paragraph>
    <text xml:space="preserve">Проверяем </text>
    <emph>
      <text xml:space="preserve">CommonMark</text>
    </emph>
    <text xml:space="preserve">.</text>
  </paragraph>
  <paragraph>
    <text xml:space="preserve">Вставляем </text>
    <code xml:space="preserve">код</code>
    <text xml:space="preserve">.</text>
    <softbreak />
    <text xml:space="preserve">И другие </text>
    <link destination="javascript:pwned" title="">
      <text xml:space="preserve">штуки</text>
    </link>
    <text xml:space="preserve">.</text>
  </paragraph>
  <html_block xml:space="preserve">&lt;p&gt;Test of &lt;em&gt;XML&lt;/em&gt;.&lt;/p&gt;
</html_block>
  <paragraph>
    <text xml:space="preserve">Проверка—“test” – test.</text>
  </paragraph>
</document>
';
        var n : Necmark = new Necmark(SAMPLE, Necmark.PARSE_OPT_SMART);
        
        asserts.assert(n.render(ncrXml(Necmark.OPT_DEFAULT | Necmark.RENDER_OPT_UNSAFE)) == expected);

        n.close();
        return asserts.done();
    }
}