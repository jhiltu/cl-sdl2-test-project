(in-package #:test-project)

(defparameter *keys* '())

(defun setup-keys (bindings)
  (log:info bindings)
  (setf *keys* bindings))
  
(defun make-key (fn)
  (list :fn fn :down nil))

(setup-keys (list
	     :scancode-escape (make-key (lambda (x) (sdl2:quit)))
	     :scancode-q (make-key (lambda (x) (sdl2:quit)))
	     :scancode-w (make-key (lambda (x) (print "w")))
	     :scancode-s (make-key (lambda (x) (print "s")))
	     :scancode-a (make-key (lambda (x) (print "a")))
	     :scancode-d (make-key (lambda (x) (print "d")))))

(defun handle-key (keysym updown)
  (let* ((scancode (sdl2:scancode keysym))
	 (keyname (getf *keys* scancode)))
    (when keyname
      (setf (getf (getf *keys* scancode) :down) (eq :down updown)))))

(defun check-keys (dt)
  (loop
    for (key value) on *keys* by #'cddr
    when (getf value :down)
      do (funcall (getf value :fn) dt)))

(defun update-world (dt)
  (check-keys dt))
