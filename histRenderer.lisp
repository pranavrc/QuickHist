(asdf:operate 'asdf:load-op :restas)

(restas:define-module :restas.histRenderer
    (:use :cl))

(in-package :restas.histRenderer)

(restas:define-route histInput (":(input)")
  input)

(restas:start :restas.histRenderer :port 8080)
