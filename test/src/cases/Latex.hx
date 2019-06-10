package cases;

import necmark.Necmark;

import tink.unit.Assert.assert;
import tink.unit.AssertionBuffer;

using tink.CoreApi;

@:asserts
class Latex
{
    static var SAMPLE = ""
        + "My humble mentoring experience tells me something about learning "
        + "programming. For complete beginners, it may be easier to learn "
        + "some kind of Lisp, and then transition to Python for more “real "
        + "world” code.\nOf course, various Lisps are used in production in "
        + "various companies in various projects, but Python is just more "
        + "popular.\n\nOne mentoree really understood object-oriented "
        + "programming (OOP) only after learning it with Racket, which is "
        + "usually characterized as “dialect of Scheme” (functional "
        + "language).\nMaybe it has something to do with syntax not getting "
        + "on beginner’s way :)\n\nПроверка---\"test\" -- test."
    ;
    public function new() { }

    @:setup public function setup() return Noise;
    @:before public function before() return Noise;
    @:after public function after() return Noise;
    @:teardown public function teardown() return Noise;

    @:describe('Test Empty')
    public function test_empty( )
    {
        var expected = "\n";
        var n : Necmark = new Necmark("");

        asserts.assert(n.render(ncrLatex(Necmark.OPT_DEFAULT | Necmark.RENDER_OPT_UNSAFE)) == expected);

        n.close();
        return asserts.done();
    }

    @:describe('Test Newline')
    public function test_newline( )
    {
        var expected = "\n";
        var n : Necmark = new Necmark("\n");

        asserts.assert(n.render(ncrLatex(Necmark.OPT_DEFAULT | Necmark.RENDER_OPT_UNSAFE)) == expected);

        n.close();
        return asserts.done();
    }

    @:describe('Test Hello World')
    public function test_hello_world( )
    {
        var expected = "Hello, Noob!\n";
        
        var n : Necmark = new Necmark("Hello, Noob!\n");
        
        asserts.assert(n.render(ncrLatex(Necmark.OPT_DEFAULT | Necmark.RENDER_OPT_UNSAFE)) == expected);

        n.close();
        return asserts.done();
    }

    @:describe('Test List')
    public function test_list( )
    {
        var expected = ""
            + "\\begin{itemize}\n"
            + "\\item a\n\n"
            + "\\item b\n\n"
            + "\\end{itemize}\n"
        ;
        
        var n : Necmark = new Necmark(" * a\n * b\n");
        
        asserts.assert(n.render(ncrLatex(Necmark.OPT_DEFAULT | Necmark.RENDER_OPT_UNSAFE)) == expected);

        n.close();
        return asserts.done();
    }


    @:describe('Test No breaks and Width')
    public function test_no_breaks_and_width( )
    {
        var expected = ""
            + "My humble mentoring experience tells me something about "
            + "learning programming. For complete beginners, it may be easier "
            + "to learn some kind of Lisp, and then transition to Python for "
            + "more ``real world'' code. Of course, various Lisps are "
            + "used in production in various companies in various projects, "
            + "but Python is just more popular.\n\n"
            + "One mentoree really understood object-oriented programming "
            + "(OOP) only after learning it with Racket, which is usually "
            + "characterized as ``dialect of Scheme'' (functional language"
            + "). Maybe it has something to do with syntax not "
            + "getting on beginner's way :)\n\nПроверка-{}-{}-\\textquotedbl{}"
            + "test\\textquotedbl{} -{}- test.\n"
        ;
        var n : Necmark = new Necmark(SAMPLE);

        asserts.assert(n.render(ncrLatex(Necmark.RENDER_OPT_NOBREAKS | Necmark.RENDER_OPT_UNSAFE)) == expected);
        asserts.assert(n.render(ncrLatex(Necmark.RENDER_OPT_NOBREAKS | Necmark.RENDER_OPT_UNSAFE, 0)) == expected);
        asserts.assert(n.render(ncrLatex(Necmark.RENDER_OPT_NOBREAKS | Necmark.RENDER_OPT_UNSAFE, 7)) == expected);

        n.close();
        return asserts.done();
    }

    @:describe('Test Hard breaks and Zero width')
    public function test_hard_breaks_and_zero_width( )
    {
        var expected = ""
            + "My humble mentoring experience tells me something about "
            + "learning programming. For complete beginners, it may be easier "
            + "to learn some kind of Lisp, and then transition to Python for "
            + "more ``real world'' code.\\\\\n"
            + "Of course, various Lisps are used in production in various "
            + "companies in various projects, but Python is just more "
            + "popular.\n\n"
            + "One mentoree really understood object-oriented programming "
            + "(OOP) only after learning it with Racket, which is usually "
            + "characterized as ``dialect of Scheme'' (functional language"
            + ").\\\\\n"
            + "Maybe it has something to do with syntax not getting on "
            + "beginner's way :)\n\nПроверка-{}-{}-\\textquotedbl{}test"
            + "\\textquotedbl{} -{}- test.\n"
        ;
        var n : Necmark = new Necmark(SAMPLE);

        asserts.assert(n.render(ncrLatex(Necmark.RENDER_OPT_HARDBREAKS | Necmark.RENDER_OPT_UNSAFE)) == expected);
        asserts.assert(n.render(ncrLatex(Necmark.RENDER_OPT_HARDBREAKS | Necmark.RENDER_OPT_UNSAFE, 0)) == expected);

        n.close();
        return asserts.done();
    }

    @:describe('Test Hard breaks and Non-Zero width')
    public function test_hard_breaks_and_non_zero_width( )
    {
        var expected = ""
            + "My\nhumble\nmentoring\nexperience\ntells\nme\nsomething\n"
            + "about\nlearning\nprogramming.\nFor\ncomplete\nbeginners,"
            + "\nit may\nbe\neasier\nto\nlearn\nsome\nkind of\nLisp,"
            + "\nand\nthen\ntransition\nto\nPython\nfor\nmore\n``real\n"
            + "world''\ncode.\\\\\n"
            + "Of\ncourse,\nvarious\nLisps\nare\nused in\n"
            + "production\nin\nvarious\ncompanies\nin\nvarious\n"
            + "projects,\nbut\nPython\nis just\nmore\npopular.\n\n"
            + "One\nmentoree\nreally\nunderstood\nobject-oriented\n"
            + "programming\n(OOP)\nonly\nafter\nlearning\nit with"
            + "\nRacket,\nwhich\nis\nusually\ncharacterized\nas\n"
            + "``dialect\nof\nScheme''\n(functional\nlanguage).\\\\\n"
            + "Maybe\nit has\nsomething\nto do\nwith\nsyntax\nnot"
            + "\ngetting\non\nbeginner's\nway :)\n\nПроверка-{}-{}-"
            + "\\textquotedbl{}test\\textquotedbl{}\n-{}-\ntest.\n"
        ;
        var n : Necmark = new Necmark(SAMPLE);

        asserts.assert(n.render(ncrLatex(Necmark.RENDER_OPT_HARDBREAKS | Necmark.RENDER_OPT_UNSAFE, 7)) == expected);

        n.close();
        return asserts.done();
    }

    @:describe('Test Soft breaks and Zero width')
    public function test_soft_breaks_and_zero_width( )
    {
        var expected = ""
            + "My humble mentoring experience tells me something about "
            + "learning programming. For complete beginners, it may be easier "
            + "to learn some kind of Lisp, and then transition to Python for "
            + "more ``real world'' code.\nOf course, various Lisps are "
            + "used in production in various companies in various projects, "
            + "but Python is just more popular.\n\n"
            + "One mentoree really understood object-oriented programming "
            + "(OOP) only after learning it with Racket, which is usually "
            + "characterized as ``dialect of Scheme'' (functional "
            + "language).\nMaybe it has something to do with syntax not "
            + "getting on beginner's way :)\n\nПроверка-{}-{}-\\textquotedbl{}"
            + "test\\textquotedbl{} -{}- test.\n"
        ;
        var n : Necmark = new Necmark(SAMPLE);

        asserts.assert(n.render(ncrLatex(Necmark.OPT_DEFAULT | Necmark.RENDER_OPT_UNSAFE)) == expected);
        asserts.assert(n.render(ncrLatex(Necmark.OPT_DEFAULT | Necmark.RENDER_OPT_UNSAFE, 0)) == expected);

        n.close();
        return asserts.done();
    }

    @:describe('Test Soft breaks and Non-Zero width')
    public function test_soft_breaks_and_non_zero_width( )
    {
        var expected = ""
            + "My\nhumble\nmentoring\nexperience\ntells\nme\nsomething\n"
            + "about\nlearning\nprogramming.\nFor\ncomplete\nbeginners,"
            + "\nit may\nbe\neasier\nto\nlearn\nsome\nkind of\nLisp,"
            + "\nand\nthen\ntransition\nto\nPython\nfor\nmore\n``real\n"
            + "world''\ncode.\nOf\ncourse,\nvarious\nLisps\nare\nused in\n"
            + "production\nin\nvarious\ncompanies\nin\nvarious\n"
            + "projects,\nbut\nPython\nis just\nmore\npopular.\n\n"
            + "One\nmentoree\nreally\nunderstood\nobject-oriented\n"
            + "programming\n(OOP)\nonly\nafter\nlearning\nit with"
            + "\nRacket,\nwhich\nis\nusually\ncharacterized\nas\n"
            + "``dialect\nof\nScheme\''\n(functional\nlanguage).\n"
            + "Maybe\nit has\nsomething\nto do\nwith\nsyntax\nnot"
            + "\ngetting\non\nbeginner's\nway :)\n\nПроверка-{}-{}-"
            + "\\textquotedbl{}test\\textquotedbl{}\n-{}-\ntest.\n"
        ;
        var n : Necmark = new Necmark(SAMPLE);

        asserts.assert(n.render(ncrLatex(Necmark.OPT_DEFAULT | Necmark.RENDER_OPT_UNSAFE, 7)) == expected);

        n.close();
        return asserts.done();
    }

    @:describe('Test No breaks and Smart')
    public function test_no_breaks_and_smart( )
    {
        var expected = ""
            + "My humble mentoring experience tells me something about "
            + "learning programming. For complete beginners, it may be easier "
            + "to learn some kind of Lisp, and then transition to Python for "
            + "more ``real world'' code. Of course, various Lisps are "
            + "used in production in various companies in various projects, "
            + "but Python is just more popular.\n\n"
            + "One mentoree really understood object-oriented programming "
            + "(OOP) only after learning it with Racket, which is usually "
            + "characterized as ``dialect of Scheme'' (functional language"
            + "). Maybe it has something to do with syntax not "
            + "getting on beginner's way :)\n\nПроверка---``test'' -- test.\n"
        ;
        var n : Necmark = new Necmark(SAMPLE, Necmark.PARSE_OPT_SMART);

        asserts.assert(n.render(ncrLatex(Necmark.RENDER_OPT_NOBREAKS | Necmark.RENDER_OPT_UNSAFE)) == expected);
        asserts.assert(n.render(ncrLatex(Necmark.RENDER_OPT_NOBREAKS | Necmark.RENDER_OPT_UNSAFE, 0)) == expected);
        asserts.assert(n.render(ncrLatex(Necmark.RENDER_OPT_NOBREAKS | Necmark.RENDER_OPT_UNSAFE, 7)) == expected);

        n.close();
        return asserts.done();
    }
}