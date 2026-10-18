# ModBang

`:%!` on steriods.

When filtering buffer contents with `:%!`, `modbang.vim` shows a real-time
preview of the output in a floating popup window.

I do this often, and built this because:

1. It is annoying to repeatedly edit commands until I get them right. This lets
   you build perfect commands in one go. Especially useful when you're chaining
   commands à la `%!jq | grep | sort | ...`, because you can preview each step
   as you type.
2. Sometimes I just want to preview stuff, and will immediately undo changes to
   the current buffer. This lets me just `<esc>` out of the command line when
   I've got what I need.

I had initially built something closer to
[vim-jqplay](https://github.com/bfrg/vim-jqplay), but settled on a leaner
approach.

Eventually this will use background jobs, but the naive `system()`
implementation works well enough for daily use.

Not tested with `NeoVim` yet.

## Installation

```bash
git clone https://github.com/Prajjwal/vim-modbang \
  ~/.vim/pack/plugins/start/modbang
```

Or, use your favorite package manager.

## Usage

Simply start typing a command prefixed with `:%!`. I might add support for
ranges, but I literally never use them personally.
