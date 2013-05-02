(defpackage :histograms
  (:use :cl))

(in-package :histograms)

(defun listMin (target)
  ;; Returns the minimum element in a list.
  (apply #'min (mapcar #'abs target)))

(defun listMax (target)
  ;; Returns the maximum element in a list.
  (apply #'max (mapcar #'abs target)))

(defun ratioList (target)
  ;; Takes a list of numbers and returns the ratios between
  ;; each and the smallest in the list.
  (mapcar #'(lambda (each) (float (/ (abs each) (listMin target)))) target))

(defun percentList (target)
  ;; Takes a list of numbers and returns the percentage
  ;; of each number with respect to the largest in the list.
  (mapcar #'(lambda (each) (float (* (/ (abs each) (listMax target)) 50))) target))

(defun convertToListOfInts (target)
  ;; Takes a list of strings and converts to a list of integers.
  (mapcar #'abs (mapcar #'read-from-string target)))

(defun barCount (target)
  ;; Takes a ratio list and counts the number of bars required
  ;; for the histogram.
  (mapcar #'(lambda (each) (round (/ each 0.5))) target))

(defun generateBars (target)
  ;; Takes a list of bar counts and generates bars (-).
  (mapcar #'(lambda (each) (make-string each :initial-element #\-))
	  target))

(defun concatList (target delim)
  ;; Takes a list of items and concatenates them with
  ;; the delimiter in between.
  (let ((lines target))
    (with-output-to-string (s)
      (dolist (line lines)
	(write-line line s)
	(princ delim s)))))

(defun mergeListItems (labelList barList delim)
  ;; Takes a list of bars and a list of label, and
  ;; returns a list of concatenated label-bar pairs.
  (mapcar #'(lambda (x y) (concatenate 'string x delim y))
	  labelList barList))

(defun stringSplit (string delim)
  ;; Splits a string into substrings around the delimiter.
  (loop for x = 0 then (1+ y)
     as y = (position delim string :start x)
       collect (subseq string x y)
     while y))

(defun getLabelCountPairs (target delim)
  ;; Get lists of label+count pairs from a split list.
  (mapcar #'(lambda (each) (stringSplit each delim)) target))

(defun listCounts (target)
  ;; Extract counts from a list into a separate list.
  (mapcar #'second target))

(defun listLabels (target)
  ;; Extract labels from a list into a separate list.
  (mapcar #'(lambda (x y) (concatenate 'string x "(" y ")"))
	  (mapcar #'first target)
	  (listCounts target)))

(defun maxLength (target)
  ;; Returns length of longest string in a list.
  (apply #'max (mapcar #'length target)))

(defun bufferSeparator (target)
  ;; Makes all list items to be of the same length as the max length,
  ;; by buffering them with whitespace.
  (mapcar #'(lambda (each)
	      (concatenate 'string each 
			   (make-string (- (maxLength target) (length each))
					:initial-element #\Space)))
	  target))

(defun equalizeLists (target)
  ;; Takes a list of label-count pairs and ensure that all the sublists
  ;; are paired up.
  (mapcar #'(lambda (each)
	      (if (second each)
		  each
		  (cons "" each))) target))
