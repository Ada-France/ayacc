## Template integration

Before Ayacc 1.4, Ayacc used templates that were hard-coded in the `Parse_Template_File`
package and several comments such as `UMASS CODES` or `END OF UMASS CODES` where
used to condtionally emit or skip some template code.  This implementation was
difficult to maintain and introducing new condition was a challenge.

Similar to Aflex, the Ayacc templates are now separated from the Ayacc source code to make
them easier to edit.  An Ayacc template is similar to an Aflex template and supports very
simple transformations to keep the implementation small and easy to manage.  The following basic
transformations are supported:

- `%if, %else, %end` conditions are used to decide to emit or drop some portion,
- ${YYLEX} patterns are replaced by the `YYLex` function name
- ${YYPARSE} specific patterns are replaced by the `YYParse` procedure name.
- ${YYPARSEPARAM} will expand to an empty string by default or the parameters for the `YYParse` procedure when a `%define parse.params` customization is used.
- ${YYSTACKSIZE} will expand to the value of the stack size configured with the `-r` option

The `%` must appear at beginning of the line and a `%` condition that is not
recognized will generate a `Program_Error` when the template is expanded.

## Conditional generation

The Ayacc template condition is a very basic mechanism that uses fixed
patterns to identify a condition.  A condition starts with `%if` followed by
a single space and the keyword followed by the end of line.
The following conditions are supported:

| Condition        | Description                                                |
|------------------|------------------------------------------------------------|
| %if private      | Generate Ada `private` package (Aflex -P option is passed) |
| %if error        | Scanner in improved error support mode (Aflex -E option is passed) |
| %if debug        | Scanner in debug mode (Aflex -d option) |
| %if yyerrok      | Support `yyerrok` generation (controlled by using the `%define parse.yyerrok {true|false}`) |
| %if yyclearin    | Support `yyclearin` generation (controlled by using the `%define parse.yyclearin {true|false}`) |

Note:
- the template expander raises the `Program_Error` exception when a `%` pattern is not recognized.
  The sed script `templates/check.sed` is executed when the templates are embedded in the Ada source
  to verify that all known conditions are correct.  If a new condition is added, it must also be
  defined in that sed script.

## Variable replacement

A very basic variable replacement is implemented for the template.
The following string patterns are replaced:

| Pattern   | Description                                         |
|-----------|-----------------------------------------------------|
| ${YYLEX}  | The name of the scanner function.  The default is `YYLex` and it can be overriden by using the `%yydecl` definition in the scanner file |
| ${YYPARSE}   | The name of the YYParse procedure.  The name can be changed by using the `%define parse.name <name>` option |
| ${YYPARSEPARAM} | The YYParse procedure parameter declaration.  The parameters can be configured by using the `%define parse.params "string"` option |
| ${YYSTACKSIZE} | The size of the parser stack configured by the `-r <size>` option or with `%define parse.bufsize NNN` |

## Build

The template files `templates/*.ads` and `templates/*.adb` are embedded in the Ayacc
binary within the `Parse_Template_File.Templates` package.  Each template file is represented
by an array of String and is accessed through an Ada declaration.

```
package Parse_Template_File.Templates is

   body_ayacc : aliased constant Content_Array;
...
end Parse_Template_File.Templates;
```

The `src/parse_template_file-templates.ads` file is generated from the template files.
The generation is using the [Advanced Resource Embedder](https://gitlab.com/stcarrez/resource-embedder)
tool.  The `are` binary must be available in the `PATH` and the generation is done by running:

```
make generate
```
