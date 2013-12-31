function! s:CursorByteOffsetFromStartOfFile()
    return line2byte(line("."))+col(".")
endfunction

function! RtagsReferences()
    let location_list = []
    for ref in split(system('rc --line-numbers --references '.bufname('%').','.s:CursorByteOffsetFromStartOfFile()), '\n')
        let ref_array = split(ref, ':')
        let location_list += [{'filename':ref_array[0], 'lnum':ref_array[1], 'text':ref_array[3]}]
    endfor

    call setloclist(0, location_list)
    lwindow
endfunction
