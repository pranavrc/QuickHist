(asdf:operate 'asdf:load-op :restas)
(import :histograms)

(restas:define-module :restas.histRenderer
    (:use :cl))

(in-package :restas.histRenderer)

(restas:define-route histInput (":(input)")
  (progn
    (defparameter *histogramOutput*
      (histograms::concatList
       (histograms::generateBars
	(histograms::barCount
	 (histograms::ratioList
	  (histograms::convertToListOfInts
	   (histograms::stringSplit input #\-))))))))
    *histogramOutput*)

(restas:define-route not-found ("*any")
  hunchentoot:+http-not-found+)

(restas:start :restas.histRenderer :port 8083)
