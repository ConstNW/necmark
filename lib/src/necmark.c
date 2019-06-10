#include <neko.h>
#include <cmark.h>

#define STRINGIFY(x) #x
#define val_match_or_fail(v, t) if(!val_is_##t(v)) { failure("Excepted "#t" in `"__FILE__"' at line "STRINGIFY(__LINE__)"."); }
#define val_match_kind(v, t) if(!val_is_kind(v, t)) { failure("Excepted "#t" in `"__FILE__"' at line "STRINGIFY(__LINE__)"."); }

DEFINE_KIND(k_necmark);

#define val_necmark(v)	((cmark_node*)val_data(v))

static void necmark_free( value doc )
{
	cmark_node *document = val_necmark(doc);

	cmark_node_free(document);
}

static value necmark_version( )
{
	return alloc_int(cmark_version());
}
DEFINE_PRIM(necmark_version, 0);

static value necmark_version_string( )
{
	return alloc_string(cmark_version_string());
}
DEFINE_PRIM(necmark_version_string, 0);

static value necmark_parse( value str, value opts )
{
	val_match_or_fail(str, string);
	val_match_or_fail(opts, int);

	char *str_in = val_string(str);
	size_t str_len = val_strlen(str);
	size_t options = val_int(opts);

	cmark_node *document = cmark_parse_document(str_in, str_len, options);
	value doc = alloc_abstract(k_necmark, document);
	val_gc(doc, necmark_free);

	return doc;
}
DEFINE_PRIM(necmark_parse, 2);

static value necmark_close( value doc )
{
	val_match_kind(doc, k_necmark);

	necmark_free(doc);
	val_gc(doc, NULL);
	val_kind(doc) = NULL;
	
	return val_null;
}
DEFINE_PRIM(necmark_close, 1);

static value necmark_render_html( value doc, value opts )
{
	val_match_kind(doc, k_necmark);
	val_match_or_fail(opts, int);

	char *result;
	cmark_node *document = val_necmark(doc);
	size_t options = val_int(opts);

	result = cmark_render_html(document, options);

	return alloc_string(result);
}
DEFINE_PRIM(necmark_render_html, 2);

static value necmark_render_xml( value doc, value opts )
{
	val_match_kind(doc, k_necmark);
	val_match_or_fail(opts, int);

	char *result;
	cmark_node *document = val_necmark(doc);
	size_t options = val_int(opts);

	result = cmark_render_xml(document, options);

	return alloc_string(result);
}
DEFINE_PRIM(necmark_render_xml, 2);

static value necmark_render_man( value doc, value opts, value w )
{
	val_match_kind(doc, k_necmark);
	val_match_or_fail(opts, int);
	val_match_or_fail(w, int);

	char *result;
	cmark_node *document = val_necmark(doc);
	size_t options = val_int(opts);
	size_t width = val_int(w);

	result = cmark_render_man(document, options, width);

	return alloc_string(result);
}
DEFINE_PRIM(necmark_render_man, 3);

static value necmark_render_latex( value doc, value opts, value w )
{
	val_match_kind(doc, k_necmark);
	val_match_or_fail(opts, int);
	val_match_or_fail(w, int);

	char *result;
	cmark_node *document = val_necmark(doc);
	size_t options = val_int(opts);
	size_t width = val_int(w);

	result = cmark_render_latex(document, options, width);

	return alloc_string(result);
}
DEFINE_PRIM(necmark_render_latex, 3);

static value necmark_render_commonmark( value doc, value opts, value w )
{
	val_match_kind(doc, k_necmark);
	val_match_or_fail(opts, int);
	val_match_or_fail(w, int);

	char *result;
	cmark_node *document = val_necmark(doc);
	size_t options = val_int(opts);
	size_t width = val_int(w);

	result = cmark_render_commonmark(document, options, width);

	return alloc_string(result);
}
DEFINE_PRIM(necmark_render_commonmark, 3);