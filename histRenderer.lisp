(asdf:operate 'asdf:load-op :restas)
(asdf:operate 'asdf:load-op :cl-who)

(import :histograms)

(restas:define-module :restas.histRenderer
    (:use :cl))

(in-package :restas.histRenderer)
(restas:debug-mode-on)

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

(defmacro responseTemplate (&body response)
  `(who:with-html-output-to-string (*standard-output* nil :prologue t :indent t)
     (:html
      (:head
       (:meta :charset "utf-8")
       (:title "QuickHist"))
      (:body
       (:p :id "response"
	   (:pre
	    ,@response))))))

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
  (responseTemplate (:response (who:str *histogramOutput*))))

(restas:start :restas.histRenderer :port 8083)
