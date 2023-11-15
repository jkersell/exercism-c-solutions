(ns matching-brackets)

(def matches {\[ \]
              \{ \}
              \( \)})

(defn valid? [text]
  (let [openings (vector)]
    (empty?
      (reduce
        (fn [acc c]
          (case c
            (\[ \{ \() (conj acc c)
            (\] \} \)) (if (= (get matches (peek acc)) c) (pop acc) (reduced (conj acc c)))
            acc))
        openings
        (seq text)))))
