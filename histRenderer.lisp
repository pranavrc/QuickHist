(asdf:operate 'asdf:load-op :restas)
(import :histograms)

(restas:define-module :restas.histRenderer
    (:use :cl))

(in-package :restas.histRenderer)

(restas:define-route histInput (":(input)")
  (progn
    (handler-case (progn (eval
      (defparameter *histogramOutput*
	(histograms::concatList
	 (histograms::generateBars
	  (histograms::barCount
	   (histograms::ratioList
	    (histograms::convertToListOfInts
	     (histograms::stringSplit input #\,)))))))))
      (error (e) (defparameter *histogramOutput* "Enter a valid set of numbers,
separated by Commas. (/25,50,100,75 or /1.2,2.4,0.6 for instance.)"))))
    *histogramOutput*)

(restas:define-route not-found ("*any")
  hunchentoot:+http-not-found+)

(restas:start :restas.histRenderer :port 8083)
