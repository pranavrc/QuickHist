(require 'asdf)

(ql:quickload :restas)

(asdf:operate 'asdf:load-op '#:quickhist)
(restas:start '#:restas.histRenderer)
