#lang racket

(require web-server/http
         web-server/http/bindings
         web-server/templates)

(require "../models/bookmark.rkt"
         "../utils/datetime.rkt")

(define (handle-get-bookmarks req)
  (let ([head-title "Bookmarks"]
        [bookmarks (select-bookmarks)])
    (response/output
     (lambda (op) (display (include-template "../templates/page_bookmarks.html") op)))))

(define (handle-get-bookmarks-submit req)
  (let ([head-title "Submit | Bookmarks"])
    (response/output
     (lambda (op) (display (include-template "../templates/page_bookmarks_submit.html") op)))))

(define (handle-post-bookmarks-submit req)
  (insert-bookmark (extract-binding/single 'url (request-bindings req)))
  (redirect-to "/bookmarks"))

(define (handle-get-bookmarks-id-edit req id)
  (let ([head-title "Edit | Bookmarks"]
        [bookmark (select-bookmark id)])
    (response/output
     (lambda (op) (display (include-template "../templates/page_bookmarks_id_edit.html") op)))))

(define (handle-get-bookmarks-id-delete req id)
  (let ([head-title "Delete | Bookmarks"]
        [bookmark (select-bookmark id)])
    (response/output
     (lambda (op) (display (include-template "../templates/page_bookmarks_id_delete.html") op)))))

(define (handle-post-bookmarks-id-delete req id)
  (delete-bookmark id)
  (redirect-to "/bookmarks"))

(define (handle-get-bookmarks-id-delete! req id)
  (let ([head-title "Edit | Bookmarks"]
        [bookmark (select-bookmark id)])
    (response/output
     (lambda (op) (display (include-template "../templates/page_bookmarks_id_delete.html") op)))))

(define (handle-post-bookmarks-id-delete! req id)
  (delete-bookmark! id)
  (redirect-to "/bookmarks"))

(define (handle-post-api-bookmarks req)
  (insert-bookmark (extract-binding/single 'url (request-bindings req)))
  (response/jsexpr #hasheq()))

(provide handle-get-bookmarks
         handle-get-bookmarks-submit
         handle-post-bookmarks-submit
         handle-get-bookmarks-id-edit
         handle-get-bookmarks-id-delete
         handle-post-bookmarks-id-delete
         handle-get-bookmarks-id-delete!
         handle-post-bookmarks-id-delete!
         handle-post-api-bookmarks)
