;;;; test-project.asd

(asdf:defsystem #:test-project
  :description "Describe test-project here"
  :author "Your Name <your.name@example.com>"
  :license  "Specify license here"
  :version "0.0.1"
  :serial t
  :depends-on ("sdl2" "log4cl")
  :components ((:file "package")
	       (:file "keys" :depends-on ("package"))
	       (:file "test-project" :depends-on ("keys"))))
