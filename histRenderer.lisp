(asdf:operate 'asdf:load-op :restas)
(asdf:operate 'asdf:load-op :cl-who)

(import :histograms)

(restas:define-module :restas.histRenderer
    (:use :cl))

(in-package :restas.histRenderer)
(restas:debug-mode-on)

(setf (who:html-mode) :html5)
(setf *invalidEntry* "Enter a valid set of numbers, separated by Commas.

/25,50,100,75 or /1.2,2.4,0.6 for instance.")

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
       (:title "QuickHist")
       (:link :rel "stylesheet" :href "index.css"))
      (:body
       (:p :id "response"
	   ,@response)))))

(defmacro staticHandler (routeName route fileName)
  (restas:define-route routeName (route)
    (pathname (concatenate 'string "~/workbase/cl-ascii-histograms/res/" fileName))))

(staticHandler `main "" "index.html")
(staticHandler `css "index.css" "index.css")

(restas:define-route histInput (":(input)")
  (progn
    (handler-case
	(progn
	  (eval
	   (defparameter *histogramOutput*
	     (histograms::concatList
	      (histograms::mergeListItems
	       (getLabels input)
	       (getBars input) " | ") #\return))))
      (error (e) (defparameter *histogramOutput* *invalidEntry*))))
  (responseTemplate (:pre (who:str *histogramOutput*))))

(restas:define-route not-found ("*any")
  (responseTemplate (:pre (who:str "Ouch, bad URL there."))))

(restas:start :restas.histRenderer :port 8083)
