(ns matching-brackets)

(defn valid? [text]
  (let [openings (vector)]
    (empty?
      (reduce
        (fn [acc c]
          (case c
            (\[ \{) (conj acc c)
            \]      (if (= \[ (peek acc)) (pop acc) (reduced (conj acc c)))
            \}      (if (= \{ (peek acc)) (pop acc) (reduced (conj acc c)))))
        openings
        (seq text)))))
