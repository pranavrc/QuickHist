(require 'asdf)

(asdf:operate 'asdf:load-op '#:quickhist)
(restas:start '#:restas.histRenderer)
