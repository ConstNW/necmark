package cases;

import necmark.Necmark;

import tink.unit.Assert.assert;
import tink.unit.AssertionBuffer;

using tink.CoreApi;

@:asserts
class Html
{
    static var SAMPLE = ""
        + "Проверяем *CommonMark*.\n\nВставляем `код`.\nИ "
        + "[другие](https://example.org) [штуки](javascript:pwnd).\n\n"
        + "<p>Test of <em>HTML</em>.</p>\n\n"
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
        var expected = "";
        var n : Necmark = new Necmark("");

        asserts.assert(n.render(ncrHtml(Necmark.OPT_DEFAULT | Necmark.RENDER_OPT_UNSAFE)) == expected);

        n.close();
        return asserts.done();
    }

    @:describe('Test ascii')
    public function test_ascii( )
    {
        var expected = "<p>Hello, Noob!</p>\n";
        
        var n : Necmark = new Necmark("Hello, Noob!");
        
        asserts.assert(n.render(ncrHtml(Necmark.OPT_DEFAULT | Necmark.RENDER_OPT_UNSAFE)) == expected);

        n.close();
        return asserts.done();
    }

    @:describe('Test No Breaks')
    public function test_no_breaks( )
    {
        var expected = ""
            + "<p>Проверяем <em>CommonMark</em>.</p>\n"
            + "<p>Вставляем <code>код</code>. И "
            + "<a href=\"https://example.org\">другие</a> "
            + "<a href=\"javascript:pwnd\">штуки</a>.</p>\n"
            + "<p>Test of <em>HTML</em>.</p>\n"
            + "<p>Проверка---&quot;test&quot; -- test.</p>\n"
        ;
        var n : Necmark = new Necmark(SAMPLE);

        asserts.assert(n.render(ncrHtml(Necmark.RENDER_OPT_NOBREAKS | Necmark.RENDER_OPT_UNSAFE)) == expected);
        
        n.close();
        return asserts.done();
    }

    @:describe('Test Soft Breaks')
    public function test_soft_breaks( )
    {
        var expected = ""
            + "<p>Проверяем <em>CommonMark</em>.</p>\n"
            + "<p>Вставляем <code>код</code>.\nИ "
            + "<a href=\"https://example.org\">другие</a> "
            + "<a href=\"javascript:pwnd\">штуки</a>.</p>\n"
            + "<p>Test of <em>HTML</em>.</p>\n"
            + "<p>Проверка---&quot;test&quot; -- test.</p>\n"
        ;

        var n : Necmark = new Necmark(SAMPLE);

        asserts.assert(n.render(ncrHtml(Necmark.OPT_DEFAULT | Necmark.RENDER_OPT_UNSAFE)) == expected);
        
        n.close();
        return asserts.done();
    }

    @:describe('Test Hard Breaks')
    public function test_hard_breaks( )
    {
        var expected = ""
            + "<p>Проверяем <em>CommonMark</em>.</p>\n"
            + "<p>Вставляем <code>код</code>.<br />\nИ "
            + "<a href=\"https://example.org\">другие</a> "
            + "<a href=\"javascript:pwnd\">штуки</a>.</p>\n"
            + "<p>Test of <em>HTML</em>.</p>\n"
            + "<p>Проверка---&quot;test&quot; -- test.</p>\n"
        ;

        var n : Necmark = new Necmark(SAMPLE);

        asserts.assert(n.render(ncrHtml(Necmark.RENDER_OPT_HARDBREAKS | Necmark.RENDER_OPT_UNSAFE)) == expected);
        
        n.close();
        return asserts.done();
    }

    @:describe('Test No Breaks and Safe')
    public function test_no_breaks_and_safe( )
    {
        var expected = ""
            + "<p>Проверяем <em>CommonMark</em>.</p>\n"
            + "<p>Вставляем <code>код</code>. И "
            + "<a href=\"https://example.org\">другие</a> "
            + "<a href=\"\">штуки</a>.</p>\n"
            + "<!-- raw HTML omitted -->\n"
            + "<p>Проверка---&quot;test&quot; -- test.</p>\n"
        ;

        var n : Necmark = new Necmark(SAMPLE);

        asserts.assert(n.render(ncrHtml(Necmark.RENDER_OPT_NOBREAKS)) == expected);
        asserts.assert(n.render(ncrHtml(Necmark.RENDER_OPT_NOBREAKS | Necmark.RENDER_OPT_SAFE)) == expected);
        
        n.close();
        return asserts.done();
    }

    @:describe('Test Soft Breaks and Safe')
    public function test_soft_breaks_and_safe( )
    {
        var expected = ""
            + "<p>Проверяем <em>CommonMark</em>.</p>\n"
            + "<p>Вставляем <code>код</code>.\nИ "
            + "<a href=\"https://example.org\">другие</a> "
            + "<a href=\"\">штуки</a>.</p>\n"
            + "<!-- raw HTML omitted -->\n"
            + "<p>Проверка---&quot;test&quot; -- test.</p>\n"
        ;

        var n : Necmark = new Necmark(SAMPLE);

        asserts.assert(n.render(ncrHtml(Necmark.OPT_DEFAULT)) == expected);
        asserts.assert(n.render(ncrHtml(Necmark.OPT_DEFAULT | Necmark.RENDER_OPT_SAFE)) == expected);
        
        n.close();
        return asserts.done();
    }

    @:describe('Test Hard Breaks and Safe')
    public function test_hard_breaks_and_safe( )
    {
        var expected = ""
            + "<p>Проверяем <em>CommonMark</em>.</p>\n"
            + "<p>Вставляем <code>код</code>.<br />\nИ "
            + "<a href=\"https://example.org\">другие</a> "
            + "<a href=\"\">штуки</a>.</p>\n"
            + "<!-- raw HTML omitted -->\n"
            + "<p>Проверка---&quot;test&quot; -- test.</p>\n"
        ;

        var n : Necmark = new Necmark(SAMPLE);

        asserts.assert(n.render(ncrHtml(Necmark.RENDER_OPT_HARDBREAKS)) == expected);
        asserts.assert(n.render(ncrHtml(Necmark.RENDER_OPT_HARDBREAKS | Necmark.RENDER_OPT_SAFE)) == expected);
        
        n.close();
        return asserts.done();
    }

    @:describe('Test No Breaks and Sourcepos')
    public function test_no_breaks_and_sourcepos( )
    {
        var expected = ""
            + "<p data-sourcepos=\"1:1-1:32\">Проверяем <em>CommonMark"
            + "</em>.</p>\n<p data-sourcepos=\"3:1-4:69\">Вставляем "
            + "<code>код</code>. И <a href=\"https://example.org\">другие</a> "
            + "<a href=\"javascript:pwnd\">штуки</a>.</p>\n"
            + "<p>Test of <em>HTML</em>.</p>\n"
            + "<p data-sourcepos=\"8:1-8:34\">Проверка---&quot;test&quot; "
            + "-- test.</p>\n"
        ;

        var n : Necmark = new Necmark(SAMPLE);

        asserts.assert(n.render(ncrHtml(Necmark.RENDER_OPT_NOBREAKS | Necmark.RENDER_OPT_UNSAFE | Necmark.RENDER_OPT_SOURCEPOS)) == expected);
        
        n.close();
        return asserts.done();
    }

    @:describe('Test No Breaks and Smart')
    public function test_no_breaks_and_smart( )
    {
        var expected = ""
            + "<p>Проверяем <em>CommonMark</em>.</p>\n"
            + "<p>Вставляем <code>код</code>. И "
            + "<a href=\"https://example.org\">другие</a> "
            + "<a href=\"javascript:pwnd\">штуки</a>.</p>\n"
            + "<p>Test of <em>HTML</em>.</p>\n"
            + "<p>Проверка—“test” – test.</p>\n"
        ;

        var n : Necmark = new Necmark(SAMPLE, Necmark.PARSE_OPT_SMART);

        asserts.assert(n.render(ncrHtml(Necmark.RENDER_OPT_NOBREAKS | Necmark.RENDER_OPT_UNSAFE)) == expected);
        
        n.close();
        return asserts.done();
   }
}