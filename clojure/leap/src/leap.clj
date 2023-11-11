(ns leap)

(defn leap-year? [year]
  (cond
    (= 0 (rem year 400)) true
    (= 0 (rem year 100)) false
    (= 0 (rem year 4)) true
    :else false)
)
