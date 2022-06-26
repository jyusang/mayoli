#lang racket

(require db)

(define (with-log msg x) (displayln msg) x)

(define (create-bookmark-table)
  (define db (sqlite3-connect #:database (getenv "SQLITE_DB_PATH")
                              #:mode 'create))
  (if (table-exists? db "bookmarks")
      (with-log
        "[SKIP] Create table 'bookmarks'"
        (void))
      (with-log
        "[DONE] Create table 'bookmarks'"
        (query-exec db (string-append
                        "CREATE TABLE bookmarks "
                        "( id INTEGER PRIMARY KEY"
                        ", url TEXT"
                        ", timestamp INT)")))))

(create-bookmark-table)
