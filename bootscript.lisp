(require 'asdf)

(asdf:operate 'asdf:load-op '#:quickhist)
;;(restas:start '#:restas.histRenderer :port 8080)
(load "/home/vanharp/workbase/QuickHist/histRenderer.lisp")
