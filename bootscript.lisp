(require 'asdf)

(ql:quickload :restas)

(asdf:operate 'asdf:load-op '#:quickhist)
(restas:start '#:restas.histRenderer :hostname "quickhist.onloop.net" :port 8080)
