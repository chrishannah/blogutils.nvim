# blogutils.nvim
Some utility functions for writing blog posts in Neovim, mostly powered by my
CLI tool, [Text Case CLI][tcc].

This plugin adds some text formatting functionality, and also frontmatter
generation.

## Text formatting

There are two functions to format text:

- `blogutils.formatTitle(input)` - Format input as AP Title Case.
- `blogutils.formatSlug(input)` - Format input as a slug.

## Frontmatter

The core of the plugin is frontmatter genration. It takes the first row of the
current buffer as input, generates the title and slug, gets the current date,
and adds a short frontmatter to the top of the buffer.

For example, this text:

```markdown
hello world
```

would result in the following frontmatter:

```yaml
---
date: 2024-01-01T00:00:00
slug: hello-world
title: Hello World
categories: []
---
```

To use the frontmatter generation, you just need to set a keymap for
`blogutils.generateFrontMatter()`.

[tcc]: https://github.com/chrishannah/textcase-cli
