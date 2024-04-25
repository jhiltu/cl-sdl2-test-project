(in-package #:test-project)

(def-keys
    ((:scancode-w (incf *x* (* dx dt)))
     (:scancode-d (incf *x* (* dx dt)))))

;; (defmacro def-keys (keys) ...) ?

;; old stuff below
(defclass interesting-keys ()
  ((key-left :initform nil)
   (key-right :initform nil)
   (key-up :initform nil)
   (key-down :initform nil)))

(defparameter *keysdown* (make-instance 'interesting-keys))

(defparameter *x* 100.0)
(defparameter *y* 100.0)
(defparameter vx 150.0)
(defparameter vy 150.0)

(defun handle-key (keysym updown)
  (let ((keyname (case (sdl2:scancode keysym)
		   (:scancode-w 'key-up)
		   (:scancode-a 'key-left)
		   (:scancode-s 'key-down)
		   (:scancode-d 'key-right)
		   (t nil))))
    (when keyname
      (setf (slot-value *keysdown* keyname) (eq :down updown)))))

(defun update-world (dt)
  (when (slot-value *keysdown* 'key-right) (incf *x* (* vx dt)))
  (when (slot-value *keysdown* 'key-left) (incf *x* (* vx dt -1)))
  (when (slot-value *keysdown* 'key-up) (incf *y* (* vy dt -1)))
  (when (slot-value *keysdown* 'key-down) (incf *y* (* vy dt))))
