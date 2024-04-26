(module
  (memory (export "mem") 1)

  (data (i32.const 250) "\c0\c6\cc\d0\d7\de\e4\e9\f0\f5")
  (data (i32.const 192) "black,brown,red,orange,yellow,green,blue,violet,grey,white")
  ;;
  ;; Return buffer of comma separated colors
  ;; "black,brown,red,orange,yellow,green,blue,violet,grey,white"
  ;;
  ;; @returns {(i32, i32)} - The offset and length of the buffer of comma separated colors
  ;;
  (func (export "colors") (result i32 i32)
    (return (i32.const 192) (i32.const 58))
  )

  ;;
  ;; Given a valid resistor color, returns the associated value
  ;;
  ;; @param {i32} offset - offset into the color buffer
  ;; @param {i32} len - length of the color string
  ;;
  ;; @returns {i32} - the associated value
  ;;
  (func (export "colorCode") (param $offset i32) (param $len i32) (result i32)
    (local $color_offset i32)
    (local $idx i32)
    (local.set $idx (i32.const 0))

    (loop $array_iter
      (if (i32.ne
        (i32.const 0)
        (call $strcmp
          (local.get $offset)
          (i32.load8_u (i32.add (i32.const 250) (local.get $idx)))
          (local.get $len)
        )
      ) (then
        (local.set $idx (i32.add (i32.const 1) (local.get $idx)))
        (br $array_iter)
      ))
    )
    (return (local.get $idx))
  )

  ;;
  ;; Compare two strings by comparing characters until a difference is found or until
  ;; the length is reached.
  ;;
  ;; @param {i32} lhs - the offset of one of the strings to be compared
  ;; @param {i32} rhs - the offset of one of the strings to be compared
  ;; @param {i32} length - the length of string to be compared
  ;;
  ;; @returns {i32} - the result is negative if the first value to differ is less in
  ;;                  lhs, 0 if both strings are equal, and positive if the first value
  ;;                  to differ is greater in lhs
  ;;
  (func $strcmp (export "strcmp") (param $lhs i32) (param $rhs i32) (param $len i32) (result i32)
    (local $cmp i32)
    (local $idx i32)
    (local.set $idx (i32.const 0))

    (if (i32.eq (i32.const 0) (local.get $len)) (then
      (return (i32.const 0))
    ))

    (loop $char_cmp
      ;; If we've compared characters up to the specified length then the strings are
      ;; equal
      (if (i32.eq (local.get $idx) (i32.sub (local.get $len) (i32.const 1))) (then
        (return (i32.const 0))
      ))

      ;; Compare this pair of characters by subtracting them
      (local.set $cmp
        (i32.sub (i32.load8_u (local.get $lhs)) (i32.load8_u (local.get $rhs)))
      )

      ;; If the characters are equal then move to the next pair and increment the index
      (if (i32.eq (i32.const 0) (local.get $cmp)) (then
        (local.set $lhs (i32.add (i32.const 1) (local.get $lhs)))
        (local.set $rhs (i32.add (i32.const 1) (local.get $rhs)))
        (local.set $idx (i32.add (i32.const 1) (local.get $idx)))
        (br $char_cmp)
      ))
    )
    (return (local.get $cmp))
  )
)
