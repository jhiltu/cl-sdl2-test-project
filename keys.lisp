(in-package #:test-project)

(def-keys
    ((:scancode-w (incf *x* (* dx dt)))
     (:scancode-d (incf *x* (* dx dt)))))

;; (defmacro def-keys (keys) ...) ?
