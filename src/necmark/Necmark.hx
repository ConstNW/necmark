/**
 * ...
 * @author Const
 */
package necmark;

import haxe.ds.StringMap;
import neko.Lib;
import neko.NativeString;

enum NecmarkRender {
	ncrHtml( options : Int );
	ncrXml ( options : Int );
	
	ncrMan( options : Int, ?width : Int );
	ncrLatex( options : Int, ?width : Int );
	ncrCommmonMark( options : Int, ?width : Int );
}

class Necmark
{
	// Default options.
	public static var OPT_DEFAULT = 0; 

	// Include a `data-sourcepos` attribute on all block elements.
	public static var RENDER_OPT_SOURCEPOS = (1 << 1); 

	// Render `softbreak` elements as hard line breaks.
	public static var RENDER_OPT_HARDBREAKS = (1 << 2);

	/** Defined here for API compatibility, but it no longer has any effect.
	 * "Safe" mode is now the default: set `RENDER_OPT_UNSAFE` to disable it.
	 */
	public static var RENDER_OPT_SAFE = (1 << 3);

	// Render `softbreak` elements as spaces.
	public static var RENDER_OPT_NOBREAKS = (1 << 4);

	/** Render raw HTML and unsafe links
	 * (`javascript:`, `vbscript:`, `file:`, and `data:`,
	 * except for `image/png`, `image/gif`, `image/jpeg`, or `image/webp` mime types).
	 * By default, raw HTML is replaced by a placeholder HTML comment.
	 * Unsafe links are replaced by empty strings.
	 */
	public static var RENDER_OPT_UNSAFE = (1 << 17);

	
	// Legacy option (no effect).
	public static var PARSE_OPT_NORMALIZE = (1 << 8);

	// Validate UTF-8 in the input before parsing, replacing illegal sequences with the replacement character U+FFFD.
	public static var PARSE_OPT_VALIDATE_UTF8 = (1 << 9);

	// Convert straight quotes to curly, --- to em dashes, -- to en dashes.
	public static var PARSE_OPT_SMART = (1 << 10);

	var doc : Dynamic;
	var src : String;
	var opts : Int;
	
	public function new( str : String, ?options : Int )
	{
		src = str;
		opts = options != null ? options : OPT_DEFAULT;

		doc = necmark_parse(NativeString.ofString(src), opts);
	}
	
	public function close( ) : Void
	{
		necmark_close(doc);
	}



	public function render( r : NecmarkRender ) : String
	{
		var s = switch( r )
		{
			case ncrHtml(options): necmark_render_html(doc, options);
			case ncrXml (options): necmark_render_xml (doc, options);

			case ncrMan(options, width): necmark_render_man(doc, options, width == null ? 0 : width);

			case ncrLatex(options, width): necmark_render_latex(doc, options, width == null ? 0 : width);
			case ncrCommmonMark(options, width): necmark_render_commonmark(doc, options, width == null ? 0 : width);
		};
		return NativeString.toString(s);
	}


	/** num : Int
	 * The library version as integer for runtime checks. Also available as
	 * macro CMARK_VERSION for compile time checks.
	 *
	 * * Bits 16-23 contain the major version.
	 * * Bits 8-15 contain the minor version.
	 * * Bits 0-7 contain the patchlevel.
	 *
	 * In hexadecimal format, the number 0x010203 represents version 1.2.3.
	 * 
	 * 
	 ** Code : String
	 * The library version string for runtime checks. Also available as
	 * macro CMARK_VERSION_STRING for compile time checks.
	 */
	public static function version( ) : { num : Int, code : String }
	{
		return {
			num: necmark_version(),
			code: NativeString.toString(necmark_version_string())
		};
	}
	
	private static var necmark_version = Lib.load("necmark", "necmark_version", 0);
	private static var necmark_version_string = Lib.load("necmark", "necmark_version_string", 0);

	private static var necmark_parse = Lib.load("necmark", "necmark_parse", 2);
	private static var necmark_close = Lib.load("necmark", "necmark_close", 1);

	private static var necmark_render_html = Lib.load("necmark", "necmark_render_html", 2);
	private static var necmark_render_xml = Lib.load("necmark", "necmark_render_xml", 2);

	private static var necmark_render_man = Lib.load("necmark", "necmark_render_man", 3);
	private static var necmark_render_latex = Lib.load("necmark", "necmark_render_latex", 3);
	private static var necmark_render_commonmark = Lib.load("necmark", "necmark_render_commonmark", 3);
}
