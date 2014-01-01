function! s:Cursor_byte_offset_from_start_of_file()
    return line2byte(line("."))-1
           \  + col(".")-1
endfunction

function! s:Echo_error(msg)
    echohl WarningMsg
    echomsg a:msg
    echohl None
endfunction

function! s:Rtags_query(arguments)
    let location_list = []
    let rc_output = system('rc --line-numbers '.a:arguments)
    if ! v:shell_error
        for ref in split(rc_output, '\n')
            let ref_array = split(ref, ':')
            let location_list += [{'filename':ref_array[0], 'lnum':ref_array[1], 'text':ref_array[3]}]
        endfor
    else
        call s:Echo_error("Failed with error code ".v:shell_error.". ".rc_output)
    endif

    call setloclist(0, location_list)
    lwindow
endfunction

function! Rtags_references()
    call s:Rtags_query('--references '.bufname('%').','.s:Cursor_byte_offset_from_start_of_file())
endfunction

command! -nargs=1 RtagsFind call <SID>Rtags_query('--find-symbols '.<f-args>)
