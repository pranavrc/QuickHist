(asdf:operate 'asdf:load-op :restas)
(asdf:operate 'asdf:load-op :cl-who)

(import :histograms)

(restas:define-module :restas.histRenderer
    (:use :cl))

(in-package :restas.histRenderer)

(setf (who:html-mode) :html5)

(defun getLabels (input)
  (histograms::bufferSeparator
   (histograms::listLabels
    (histograms::equalizeLists
     (histograms::getLabelCountPairs
      (histograms::stringSplit input #\,) #\=)))))

(defun getBars (input)
  (histograms::generateBars
   (histograms::barCount
    (histograms::percentList
     (histograms::convertToListOfInts
      (histograms::listCounts
       (histograms::equalizeLists
	(histograms::getLabelCountPairs
	 (histograms::stringSplit input #\,) #\=))))))))

(restas:define-route histInput (":(input)")
  (progn
    (handler-case
	(progn
	  (eval
	   (defparameter *histogramOutput*
	     (histograms::concatList
	      (histograms::mergeListItems
	       (getLabels input)
	       (getBars input) " | ") "<br />"))))
      (error (e) (defparameter *histogramOutput* "Enter a valid set of numbers,
separated by Commas. (/25,50,100,75 or /1.2,2.4,0.6 for instance.)"))))
  (who:with-html-output-to-string (*standard-output* nil :prologue t)
    (:html
     (:head
      (:meta :charset "utf-8")
      (:title "QuickHist"))
     (:body
      (:p *histogramOutput*)))))

(restas:define-route not-found ("*any")
  hunchentoot:+http-not-found+)

(restas:start :restas.histRenderer :port 8083)
