# vim-inspect

Small vim-only plugin that adds a nvim-style `:Inspect` command for highlight groups under the cursor.

nvim users should use the built-in command; this plugin intentionally does not load under nvim.

It prints the highlight (syntax) groups under the cursor.

## Installation

Use your favorite plugin manager.

## Commands

### `:Inspect`

Print the resolved highlight group stack under the cursor.

### `:Inspect!`

Print a more verbose view (syntax stack, resolved stack, and the final effective group) to `:messages`.
