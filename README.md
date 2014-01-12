vim-rtags
=========
C++ code navigation in Vim editor.

rtags uses clang to find symbol references, definitions, etc.


Setup
-----
[Vundle](https://github.com/gmarik/vundle) can be used to install and update this plugin.

vim-rtags requires that Vim was compiled with `+byte_offset` enabled.

The rtags bin directory needs to be in your PATH.


Usage
-----
Note: `<localleader>` is backslash, unless overridden by `maplocalleader`.

<table>
<tr>
<td>&lt;localleader&gt;r</td>
<td>find references to the symbol under the cursor.
</tr>
<tr>
<td>:RtagsFind <em>symbol</em></td>
<td>find definition/declarations of <em>symbol</em>
</tr>
</table>

See `./ftplugin/c.vim` to define custom mappings.

The [Vim-unimpared](https://github.com/tpope/vim-unimpaired) plugin can help navigate the output of vim-rtags. It maps:
* `[l, ]l` to move up/down a line in the "location list" window
* `[L, ]L` to move to first/last entry, and
* `[<C-L>, ]<C-L>` to jump to previous/next file.


To do
-----
* Make it work when a source file has not been saved. Note: buffers other than the current one may have significant unsaved changes. (A special case exists where a buffer has never been saved.) The simplest solution might be just to save everything that has been modified/created before calling rtags.
* Automatically start rdm. (rc should start rdm if it can't connect to rdm.)
* Lots more!
