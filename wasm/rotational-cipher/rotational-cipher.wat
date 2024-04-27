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
    (local $asciiOffset i32)
    (local $char i32)
    (local $idx i32)
    (local $charOffset i32)

    (local.set $idx (i32.const 0))

    (loop $applyRotation
      (local.set $charOffset (i32.add (local.get $textOffset) (local.get $idx)))
      (local.set $char (i32.load8_u (local.get $charOffset)))

      (block $processAlpha
        (if (i32.and 
          (i32.ge_u (local.get $char) (i32.const 65))
          (i32.le_u (local.get $char) (i32.const 90))
        ) (then
          (local.set $asciiOffset (i32.const 65))
        ) (else (if (i32.and 
          (i32.ge_u (local.get $char) (i32.const 97))
          (i32.le_u (local.get $char) (i32.const 122))
        ) (then
          (local.set $asciiOffset (i32.const 97))
        ) (else
          (br $processAlpha)
        ))))
  
        ;; Translate the char into the range [0,25]
        (local.set $char (i32.sub (local.get $char) (local.get $asciiOffset)))

        ;; Apply the rotation
        (local.set $char
          (i32.add (local.get $shiftKey) (local.get $char))
        )

        ;; Bring the char back into the correct range if it's negative
        (if (i32.lt_s (local.get $char) (i32.const 0)) (then
          (local.set $char
            (i32.add
              (i32.rem_s (local.get $char) (i32.const 26))
              (i32.const 26)
            )
          )
        ))

        ;; Bring the char back into the correct range if it's positive
        (if (i32.gt_s (local.get $char) (i32.const 25)) (then
          (local.set $char
            (i32.rem_s (local.get $char) (i32.const 26))
        )
        ))

        ;; Translate the char back to the original ASCII range
        (local.set $char (i32.add (local.get $char) (local.get $asciiOffset)))

        (i32.store8 (local.get $charOffset) (local.get $char))
      ) ;; processAlpha

      (local.set $idx (i32.add (local.get $idx) (i32.const 1)))
      (br_if $applyRotation (i32.lt_u (local.get $idx) (local.get $textLength)))
    ) ;; applyRotation

    (return (local.get $textOffset) (local.get $textLength))
  )
)
