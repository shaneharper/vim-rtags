function! s:Cursor_byte_offset_from_start_of_file()
    return line2byte(line("."))+col(".")
endfunction

function! Rtags_references()
    let location_list = []
    for ref in split(system('rc --line-numbers --references '.bufname('%').','.s:Cursor_byte_offset_from_start_of_file()), '\n')
        let ref_array = split(ref, ':')
        let location_list += [{'filename':ref_array[0], 'lnum':ref_array[1], 'text':ref_array[3]}]
    endfor

    call setloclist(0, location_list)
    lwindow
endfunction
