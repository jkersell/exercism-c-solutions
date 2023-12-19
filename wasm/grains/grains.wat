(module
  ;;
  ;; Calculate the number of grains of wheat on the nth square of the chessboard
  ;;
  ;; @param {i32} squareNum - The square of the chessboard to calculate the number of grains for
  ;;
  ;; @returns {i64} - The number of grains of wheat on the nth square of the 
  ;;                  chessboard or 0 if the squareNum is invalid. The result
  ;;                  is unsigned.
  ;;
  (func $square (export "square") (param $squareNum i32) (result i64)
    (local $result i64)

    local.get $squareNum
    i32.const 1
    i32.lt_s
    if
      i64.const 0
      return
    end

    local.get $squareNum
    i32.const 64
    i32.gt_u
    if
      i64.const 0
      return
    end

    local.get $squareNum
    i32.const 1
    i32.eq
    if
      i64.const 1
      return
    end

    (local.set $result (i64.const 1))
    loop $sq
      local.get $result
      i64.const 2
      i64.mul
      local.set $result

      local.get $squareNum
      i32.const 1
      i32.sub
      local.tee $squareNum

      i32.const 1
      i32.gt_u
      br_if $sq
    end

    local.get $result
    return
  )

  ;;
  ;; Calculate the sum of grains of wheat across all squares of the chessboard
  ;;
  ;; @returns {i64} - The number of grains of wheat on the entire chessboard.
  ;;                  The result is unsigned.
  ;;
  (func (export "total") (result i64)
    (local $squares i32)
    (local $total i64)
    (local $grainsOnSquare i64)

    (local.set $grainsOnSquare (i64.const 1))

    (local.set $squares (i32.const 64))
    loop $count
      local.get $total
      local.get $grainsOnSquare
      i64.add
      local.set $total

      local.get $grainsOnSquare
      i64.const 2
      i64.mul
      local.set $grainsOnSquare

      local.get $squares
      i32.const 1
      i32.sub
      local.tee $squares

      i32.const 0
      i32.gt_u
      br_if $count
    end

    local.get $total
    return
  )
)
