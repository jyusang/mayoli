#lang racket

(require db
         racket/match
         web-server/http
         web-server/servlet
         web-server/servlet-env)

(define db (sqlite3-connect #:database (getenv "SQLITE_DB_PATH")))

(struct bookmark (id url timestamp))

(define (get-bookmarks)
  (map (lambda (row) (apply bookmark (vector->list row)))
       (query-rows db "SELECT * FROM bookmarks")))

(define (add-bookmark url)
  (query-exec db "INSERT INTO bookmarks (url, timestamp) VALUES (?, STRFTIME('%s', 'now'))" url))

(define (render-bookmark a-bookmark)
  (define url (bookmark-url a-bookmark))
  `(a ((href ,url)) ,url))

(define (render-list items render-item)
  `(ul ,@(map (lambda (item) `(li ,(render-item item))) items)))

(define (render-page bookmarks)
  `(html
    (head (title "Bookmarks"))
    (body ,(render-list bookmarks render-bookmark))))

(define (handle-get req)
  (response/xexpr (render-page (get-bookmarks))))

(define (handle-post req)
  (add-bookmark (extract-binding/single 'url (request-bindings req)))
  (response/xexpr "OK"))

(define (start req)
  (match (request-method req)
    [#"GET" (handle-get req)]
    [#"POST" (handle-post req)]
    [else (void)]))

(serve/servlet start
               #:launch-browser? #f
               #:listen-ip #f
               #:port 8000
               #:servlet-path "/"
               #:stateless? #t)
