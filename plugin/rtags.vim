function! s:Cursor_byte_offset_from_start_of_file()
    return line2byte(line("."))+col(".")
endfunction

function! s:Echo_error(msg)
    echohl WarningMsg
    echomsg a:msg
    echohl None
endfunction

function! Rtags_references()
    let location_list = []
    let rc_output = system('rc --line-numbers --references '.bufname('%').','.s:Cursor_byte_offset_from_start_of_file())
    if ! v:shell_error
        for ref in split(rc_output, '\n')
            let ref_array = split(ref, ':')
            let location_list += [{'filename':ref_array[0], 'lnum':ref_array[1], 'text':ref_array[3]}]
        endfor
    else
        call s:Echo_error("Failed to get references. Error code ".v:shell_error.". ".rc_output)
    endif

    call setloclist(0, location_list)
    lwindow
endfunction
