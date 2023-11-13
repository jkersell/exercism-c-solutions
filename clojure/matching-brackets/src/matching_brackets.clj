(ns matching-brackets)

(defn valid? [text]
  (let [openings (vector)]
    (empty?
      (reduce
        (fn [acc c]
          (case c
            \[ (conj acc c)
            \] (pop acc)))
        openings
        (seq text)))))
