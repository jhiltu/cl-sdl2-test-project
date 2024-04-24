#/bin/sh
sbcl --load test-project.asd --eval '(require :test-project)' --eval '(test-project:gogo)'
