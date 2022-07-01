#lang racket

(require db
         net/url
         net/url-structs)

(define db (sqlite3-connect #:database (getenv "SQLITE_DB_PATH")))

(struct raw-bookmark
  (id url title? created_at updated_at deleted_at))

(struct bookmark
  (id url title?))

(define (bookmark-host b)
  (url-host (string->url (bookmark-url b))))

(define (bookmark-title b)
  (let ([title? (bookmark-title? b)])
    (if (sql-null? title?) "?" (title?))))

(define (parse-bookmark row)
  (apply bookmark (vector->list row)))

(define (parse-insert-id sr)
  (cdr (car (simple-result-info sr))))

(define (select-bookmarks)
  (define sql "
    SELECT id, url, title
    FROM bookmarks
    ORDER BY created_at DESC
    ")
  (map parse-bookmark (query-rows db sql)))

(define (insert-bookmark url)
  (define sql "
    INSERT INTO bookmarks (url, created_at, updated_at)
    VALUES (?, STRFTIME('%s', 'now'), STRFTIME('%s', 'now'))
    ")
  (parse-insert-id (query db sql url)))

(define (update-bookmark-title id title)
  (define sql "
    UPDATE bookmarks
    SET updated_at = STRFTIME('%s', 'now'), title = ?
    WHERE id = ?
    ")
  (query-exec db sql title id))

(provide (struct-out bookmark)
         bookmark-host
         bookmark-title
         select-bookmarks
         insert-bookmark
         update-bookmark-title)
