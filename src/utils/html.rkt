#lang racket

(require html-parsing
         xml/path)

(define (parse-head-title s)
  (let* ([xe (html->xexp s)]
         [title (se-path* '(head title) xe)]
         [maybe-title (if (string? title) title null)])
    maybe-title))

(provide parse-head-title)
