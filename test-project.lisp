;;;; test-project.lisp

(in-package #:test-project)

(require :sdl2)

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

(defparameter *current-time* 0)
(defparameter *prev-time* 0)

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

(defun render-all (renderer)
  (sdl2:set-render-draw-color renderer 0 0 0 255)
  (sdl2:render-clear renderer)
  (sdl2:set-render-draw-color renderer 100 200 50 255)
  (sdl2:render-fill-rect renderer (sdl2:make-rect (floor *x*) (floor *y*) 100 100)))

(defun mainloop (win renderer)
  (setf *prev-time* (sdl2:get-ticks))
  (sdl2:with-event-loop (:method :poll)
    (:keydown
     (:keysym keysym)
     (handle-key keysym :down))
    (:keyup
     (:keysym keysym)
     (handle-key keysym :up))
    (:idle
     ()
     (setf *current-time* (sdl2:get-ticks))
     (update-world (* (- *current-time* *prev-time*) 0.001))
     (setf *prev-time* (sdl2:get-ticks))
     (render-all renderer)
     (sdl2:render-present renderer)
     (sdl2:delay 33))
    (:quit () t)))

(defun gogo ()
  (sdl2:with-init (:everything)
    (sdl2:with-window (win :flags '(:shown))
      (sdl2:with-renderer (renderer win :flags '(:accelerated))
	(mainloop win renderer)))))
