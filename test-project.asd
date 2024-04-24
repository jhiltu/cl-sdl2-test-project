;;;; test-project.asd

(asdf:defsystem #:test-project
  :description "Describe test-project here"
  :author "Your Name <your.name@example.com>"
  :license  "Specify license here"
  :version "0.0.1"
  :serial t
  :depends-on ("sdl2")
  :components ((:file "package")
               (:file "test-project")))
