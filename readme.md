# <div align="center"> Micro <3 Prettier </div>

> A [`micro`](https://github.com/zyedidia/micro) plugin that formats files using
> [`prettier`](https://github.com/prettier/prettier).

## Installation and Usage

```
micro --plugin install prettier
```

The next time you edit and save a file using micro, it will get automatically
formatted using Prettier.

## Configuration

If prettier detects a configuration file, the options set for the plugin will
not apply. If there is no configuration present, then the options set for the
plugin (or the default values) will be used.

You can set an option by running the following command (Press `Ctrl+E`, then run
the following):

```
set prettier.<name> <value>
```

> See
> [the official Prettier documentation](https://prettier.io/docs/en/options.html)
> for a list of options and their possible values.

You can also format the document without saving it by running the following
command (Press `Ctrl+E`, then run the following):

```
format
```

You can switch off the format-on-save feature by running the following command
(Press `Ctrl+E`, then run the following):

```
set prettier.formatOnSave off
```

## Issues and Contributing

Found a bug? Don't like something? Want to see something added/changed? Open
[an issue](https://github.com/gamemaker1/micro-plugin-prettier/issues/new)!

## License

This plugin is licensed under the ISC license. See the
[license file](license.md) for the complete license text.
