(module
  (memory (export "mem") 1)

  ;;
  ;; Encrypt plaintext using the rotational cipher.
  ;;
  ;; @param {i32} textOffset - The offset of the plaintext input in linear memory.
  ;; @param {i32} textLength - The length of the plaintext input in linear memory.
  ;; @param {i32} shiftKey - The shift key to use for the rotational cipher.
  ;;
  ;; @returns {(i32,i32)} - The offset and length of the ciphertext output in linear memory.
  ;;
  (func (export "rotate") (param $textOffset i32) (param $textLength i32) (param $shiftKey i32) (result i32 i32)
    (if (i32.lt_s (local.get $shiftKey) (i32.const 0)) (then
      (local.set $shiftKey
        (i32.add
          (i32.rem_s (local.get $shiftKey) (i32.const 26))
          (i32.const 26)
        )
      )
    ))

    (if (i32.gt_s (local.get $shiftKey) (i32.const 25)) (then
      (local.set $shiftKey
        (i32.rem_s (local.get $shiftKey) (i32.const 26))
      )
    ))

    (i32.store8
      (local.get $textOffset)
      (i32.add (local.get $shiftKey) (i32.load8_u (local.get $textOffset)))
    )
    (return (local.get $textOffset) (local.get $textLength))
  )
)
