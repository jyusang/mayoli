#lang racket

(require web-server/http
         web-server/http/bindings
         web-server/templates)

(require "../models/bookmark.rkt")

(define (handle-get-bookmarks req)
  (let ([head-title "Bookmarks"]
        [bookmarks (select-bookmarks)])
    (response/output
     (lambda (op) (display (include-template "../templates/page_bookmarks_index.html") op)))))

(define (handle-post-api-bookmarks req)
  (insert-bookmark (extract-binding/single 'url (request-bindings req)))
  (response/xexpr "{}"))

(provide handle-get-bookmarks
         handle-post-api-bookmarks)
