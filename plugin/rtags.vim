function! Rtags_references_to_symbol_under_cursor()
    call s:Rtags_query('--references '.bufname('%').','.s:Cursor_byte_offset_from_start_of_file())
endfunction

command! -nargs=1 RtagsFind call <SID>Rtags_query('--find-symbols '.<f-args>)


function! s:Rtags_query(arguments)
    let location_list = []
    let rc_output = system('rc --line-numbers '.a:arguments)
    if ! v:shell_error
        for ref in split(rc_output, '\n')
            let ANY='.\{-}'
            let matches = matchlist(ref, '\('.ANY.'\):\('.ANY.'\):'.ANY.':\t\(.*\)')
            if len(matches) == 0
                call s:Echo_error(ref)
                continue
            endif
            let [ref, pathname, line_number, line_text; unused_elements] = matches
            let location_list += [{'filename':pathname, 'lnum':line_number, 'text':line_text}]
        endfor
    else
        call s:Echo_error("Failed with error code ".v:shell_error.". ".rc_output)
    endif

    call setloclist(0, location_list)
    lwindow
endfunction

function! s:Cursor_byte_offset_from_start_of_file()
    return (line2byte(line("."))-1) + (col(".")-1)
endfunction

function! s:Echo_error(msg)
    echohl WarningMsg
    echomsg a:msg
    echohl None
endfunction
