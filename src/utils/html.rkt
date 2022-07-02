#lang racket

(require html-parsing
         xml
         xml/path)

(define (parse-head-title s)
  (string-join (map (lambda (x) (if (string? x) (xexpr->string x) ""))
                    (se-path*/list '(head title) (html->xexp s)))))

(provide parse-head-title)
