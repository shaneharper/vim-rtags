" Note: this script is sourced for C, C++ and Objective-C files

if exists("b:dont_set_rtags_key_mappings")
    finish
endif
let b:dont_set_rtags_key_mappings = 1


if !hasmapto('call Rtags_references_to_symbol_under_cursor()')
    nnoremap <buffer> <silent> <unique> <localleader>r :call Rtags_references_to_symbol_under_cursor()<CR>
endif


" XXX let b:undo_ftplugin =
