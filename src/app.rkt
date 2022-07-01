#lang racket

(require web-server/servlet
         web-server/servlet-env)

(require "handlers/bookmark.rkt")

(define start
  (dispatch-case
   [("api" "bookmarks") #:method "post" handle-post-api-bookmarks]
   [("bookmarks") #:method "get" handle-get-bookmarks]))

(define extra-files-paths
  (list (build-path "src/htdocs")))

(serve/servlet start
               #:extra-files-paths extra-files-paths
               #:launch-browser? #f
               #:listen-ip #f
               #:port (or (getenv "PORT") 8000)
               #:servlet-regexp #rx""
               #:stateless? #t)
