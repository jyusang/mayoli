#lang racket

(require web-server/servlet
         web-server/servlet-env)

(require "handlers/bookmark.rkt")

(define start
  (dispatch-case
   [("api" "bookmarks") #:method "post" handle-post-api-bookmarks]
   [("bookmarks") #:method "get" handle-get-bookmarks]
   [("bookmarks" (integer-arg) "edit") #:method "get" handle-get-bookmarks-id-edit]
   [("bookmarks" (integer-arg) "delete") #:method "get" handle-get-bookmarks-id-delete]
   [("bookmarks" (integer-arg) "delete") #:method "post" handle-post-bookmarks-id-delete]
   [("bookmarks" (integer-arg) "delete!") #:method "get" handle-get-bookmarks-id-delete!]
   [("bookmarks" (integer-arg) "delete!") #:method "post" handle-post-bookmarks-id-delete!]
   [("bookmarks" (integer-arg) "refresh") #:method "get" handle-get-bookmarks-id-refresh]
   [("bookmarks" "submit") #:method "get" handle-get-bookmarks-submit]
   [("bookmarks" "submit") #:method "post" handle-post-bookmarks-submit]))

(define extra-files-paths
  (list (build-path "src/htdocs")))

(serve/servlet start
               #:extra-files-paths extra-files-paths
               #:launch-browser? #f
               #:listen-ip #f
               #:port (string->number (or (getenv "MAYOLI_PORT") "8000"))
               #:servlet-regexp #rx""
               #:stateless? #t)
