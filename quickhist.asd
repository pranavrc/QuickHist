(in-package :asdf)

(asdf:defsystem #:quickhist
    :depends-on (#:cl-who #:hunchentoot)
    :description "quickhist: ASCII Histograms API in Common Lisp."
    :version "1.0"
    :author "Pranav Ravichandran <me@onloop.net>"
    :license "WTFPL <http://en.wikipedia.org/wiki/WTFPL>"
    :components ((:file "histUtil")
		 (:file "histRenderer" :depends-on ("histUtil"))))
