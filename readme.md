# <div align="center"> Micro <3 Prettier </div>

> A [`Micro`](https://github.com/zyedidia/micro) editor plugin that formats
> files using [`Prettier`](https://github.com/prettier/prettier).

## Installation and Usage

Simply run the following in terminal to install the plugin:

```
micro --plugin install prettier
```

The next time you edit and save a file using Micro, it will get automatically
formatted using Prettier.

## Configuration

If Prettier detects a configuration file, the options set for the plugin will
not apply. If there is no configuration present, then the options set for the
plugin (or the default values take from
[here](https://prettier.io/docs/en/options.html)) will be used.

You can set an option by running the following command (Press `Ctrl+E`, then run
the following):

```
set prettier.<name> <value>
```

Where `name` is an option from the table, and `value` is one of the possible
values for that option. See the official Prettier documentation for an even mroe
detail explanation of each option and its possible values.

| Option                      | Description                                                                                                               | Default Value | Possible Values                       |
| --------------------------- | ------------------------------------------------------------------------------------------------------------------------- | ------------- | ------------------------------------- |
| `tabwidth`                  | Specify the number of spaces per indentation-level.                                                                       | `2`           | `<number>`                            |
| `usetabs`                   | Indent lines with tabs instead of spaces.                                                                                 | `false`       | `true`, `false`                       |
| `semi`                      | Print semicolons at the ends of statements.                                                                               | `true`        | `true`, `false`                       |
| `singlequote`               | Use single quotes instead of double quotes.                                                                               | `false`       | `true`, `false`                       |
| `quoteProps`                | Change when properties in objects are quoted.                                                                             | `as-needed`   | `as-needed`, `consistent`, `preserve` |
| `jsxsinglequote`            | Use single quotes instead of double quotes in JSX.                                                                        | `false`       | `true`, `false`                       |
| `trailingcomma`             | Print trailing commas wherever possible in multi-line comma-separated syntactic structures.                               | `es5`         | `none`, `es5`, `always`               |
| `bracketspacing`            | Print spaces between brackets in object literals.                                                                         | `true`        | `true`, `false`                       |
| `bracketsameline`           | Put the > of a multi-line HTML element at the end of the last line instead of being alone on the next line.               | `false`       | `true`, `false`                       |
| `arrowparens`               | Include parentheses around a sole arrow function parameter.                                                               | `always`      | `always` , `avoid`                    |
| `wrap`                      | Hard wrap lines at the column specified by the `cols` setting.                                                            | `preserve`    | `always`, `never`, `preserve`         |
| `cols`                      | Specify the line length that the printer will wrap on.                                                                    | `80`          | `<number>`                            |
| `eol`                       | The line feed character to use in all files.                                                                              | `lf`          | `lf`, `crlf`, `cr`, `auto`            |
| `formatembeddedcode`        | Whether or not to format quoted code embedded in the file.                                                                | `auto`        | `auto`, `off`                         |
| `indentvuecode`             | Whether or not to indent the code inside `<script>` and `<style>` tags in Vue files.                                      | `false`       | `true`, `false`                       |
| `htmlwhitespacesensitivity` | Specify the global whitespace sensitivity for HTML, Vue, Angular, and Handlebars.                                         | `css`         | `css`, `strict`, `ignore`             |
| `requirepragma`             | Whether to only format files that contain a special comment, called a pragma, at the top of the file.                     | `false`       | `true`, `false`                       |
| `insertpragma`              | Whether to insert a special @format marker at the top of files specifying that the file has been formatted with Prettier. | `false`       | `true`, `false`                       |

You can also format the document without saving it by running the following
command (Press `Ctrl+E`, then run the following):

```
format
```

You can switch off the format-on-save feature by running the following command
(Press `Ctrl+E`, then run the following):

```
set prettier.autoformat off
```

## Issues and Contributing

Found a bug? Don't like something? Want to see something added/changed? Open
[an issue](https://github.com/gamemaker1/micro-plugin-prettier/issues/new)!

## License

This plugin is licensed under the ISC license. See the
[license file](license.md) for the complete license text.
