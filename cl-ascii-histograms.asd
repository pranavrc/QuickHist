(in-package :asdf)

(asdf:defsystem "cl-ascii-histograms"
    :depends-on (#:cl-who #:hunchentoot)
    :description "cl-ascii-histograms: Generate ASCII Histograms from a series of numbers."
    :version "1.0"
    :author "Pranav Ravichandran <me@onloop.net>"
    :license "WTFPL <http://en.wikipedia.org/wiki/WTFPL>"
    :components ((:file "histRenderer")
		 (:file "histUtil" :depends-on ("histRenderer"))))
