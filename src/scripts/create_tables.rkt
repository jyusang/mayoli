#lang racket

(require db)

(define db (sqlite3-connect #:database (getenv "SQLITE_DB_PATH")
                            #:mode 'create))

(define (create-table table-name sql)
  (if (table-exists? db table-name)
      (begin (void)
             (printf "[SKIP] Create table ~s\n" table-name))
      (begin (query-exec db sql)
             (printf "[DONE] Create table ~s\n" table-name))))

(create-table "bookmarks" "
  CREATE TABLE bookmarks (
    id INTEGER PRIMARY KEY,
    url TEXT NOT NULL,
    title TEXT,
    created_at INT,
    updated_at INT,
    deleted_at INT
  )
  ")
