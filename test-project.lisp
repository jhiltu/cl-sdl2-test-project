;;;; test-project.lisp

(in-package #:test-project)

(require :sdl2)

(defclass interesting-keys ()
  ((key-left :initform nil)
   (key-right :initform nil)
   (key-up :initform nil)
   (key-down :initform nil)))

(defparameter *keysdown* (make-instance 'interesting-keys))
(defparameter *x* 100)
(defparameter *y* 100)

(defun handle-key (keysym updown)
  (let ((keyname (case (sdl2:scancode keysym)
		   (:scancode-w 'key-up)
		   (:scancode-a 'key-left)
		   (:scancode-s 'key-down)
		   (:scancode-d 'key-right)
		   (t nil))))
    (when keyname
      (setf (slot-value *keysdown* keyname) (eq :down updown)))))

(defun update-world ()
  (when (slot-value *keysdown* 'key-right) (setf *x* (+ *x* 1)))
  (when (slot-value *keysdown* 'key-left) (setf *x* (+ *x* -1)))
  (when (slot-value *keysdown* 'key-up) (setf *y* (+ *y* -1)))
  (when (slot-value *keysdown* 'key-down) (setf *y* (+ *y* 1))))

(defun mainloop (win renderer)
  (sdl2:with-event-loop (:method :poll)
    (:keydown
     (:keysym keysym)
     (handle-key keysym :down))
    (:keyup
     (:keysym keysym)
     (handle-key keysym :up))
    (:idle
     ()
     (update-world)
     (sdl2:set-render-draw-color renderer 0 0 0 255)
     (sdl2:render-clear renderer)
     (sdl2:set-render-draw-color renderer 100 200 50 255)
     (sdl2:render-fill-rect renderer (sdl2:make-rect *x* *y* 100 100))
     (sdl2:render-present renderer)
     (sdl2:delay 33))
    (:quit () t)))

(defun gogo ()
  (sdl2:with-init (:everything)
    (sdl2:with-window (win :flags '(:shown))
      (sdl2:with-renderer (renderer win :flags '(:accelerated))
	(mainloop win renderer)))))
