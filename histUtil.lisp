(defpackage :histograms
  (:use :cl))

(in-package :histograms)

(defun listMin (target)
  ;; Returns the minimum element in a list.
  (apply #'min target))

(defun ratioList (target)
  ;; Takes a list of numbers and returns the ratios between
  ;; each and the smallest in the list.
  (mapcar #'(lambda (each) (float (/ each (listMin target)))) target))

(defun convertToListOfInts (target)
  ;; Takes a list of strings and converts to a list of integers.
  (mapcar #'parse-integer target))

(defun barCount (target)
  ;; Takes a ratio list and counts the number of bars required
  ;; for the histogram.
  (mapcar #'(lambda (each) (round (/ each 0.5))) target))

(defun generateBars (target)
  ;; Takes a list of bar counts and generates bars (-).
  (mapcar #'(lambda (each) (make-string each :initial-element #\-))
	  target))

(defun concatList (target)
  ;; Takes a list of items and concatenates them with spaces in between.
  (let ((lines target))
    (with-output-to-string (s)
      (dolist (line lines)
	(write-line line s)
	(terpri s)))))

(defun stringSplit (string delim)
  ;; Splits a string into substrings around the delimiter.
  (loop for x = 0 then (1+ y)
     as y = (position delim string :start x)
       collect (subseq string x y)
     while y))
