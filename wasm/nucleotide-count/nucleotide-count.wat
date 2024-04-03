(module
  (memory (export "mem") 1)

  ;;
  ;; Count the number of each nucleotide in a DNA string.
  ;;
  ;; @param {i32} offset - The offset of the DNA string in memory.
  ;; @param {i32} length - The length of the DNA string.
  ;;
  ;; @returns {(i32,i32,i32,i32)} - The number of adenine, cytosine, guanine, 
  ;;                                and thymine nucleotides in the DNA string
  ;;                                or (-1, -1, -1, -1) if the DNA string is
  ;;                                invalid.
  ;;
  (func (export "countNucleotides") (param $offset i32) (param $length i32) (result i32 i32 i32 i32)
    (local $idx i32)
    (local $a_sum i32)
    (local $c_sum i32)
    (local $g_sum i32)
    (local $t_sum i32)
    (local $char i32)

    (if (i32.eq (local.get $length) (i32.const 0))
      (return
        (i32.const 0)
        (i32.const 0)
        (i32.const 0)
        (i32.const 0)
      )
    )

    (local.set $idx (i32.const 0))

    (loop $for_char
      ;; load the next character
      (local.set $char (i32.load8_u 
                         (i32.add (local.get $offset)
                                  (local.get $idx)
                         )))

      (block $check_char
        (if (i32.eq (i32.const 65) (local.get $char)) (then
            (local.set $a_sum (call $incr (local.get $a_sum)))
            (br $check_char)
          )
        )
        (if (i32.eq (i32.const 67) (local.get $char)) (then
            (local.set $c_sum (call $incr (local.get $c_sum)))
            (br $check_char)
          )
        )
        (if (i32.eq (i32.const 71) (local.get $char)) (then
            (local.set $g_sum (call $incr (local.get $g_sum)))
            (br $check_char)
          )
        )
        (if (i32.eq (i32.const 84) (local.get $char)) (then
            (local.set $t_sum (call $incr (local.get $t_sum)))
            (br $check_char)
          )
        )
        (return
          (i32.const -1)
          (i32.const -1)
          (i32.const -1)
          (i32.const -1)
        )
      )

      ;; increment the index into the string
      (local.set $idx (call $incr (local.get $idx)))

      ;; loop until the index into the string reaches length
      (i32.lt_s (local.get $idx) (local.get $length))
      br_if $for_char
    )

    (return
      (local.get $a_sum)
      (local.get $c_sum)
      (local.get $g_sum)
      (local.get $t_sum)
    )
  )

  (func $incr (param $value i32) (result i32)
      (i32.add (i32.const 1) (local.get $value))
  )
)
