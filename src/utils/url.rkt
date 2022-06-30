#lang racket

(require net/url)

(define (validate-url s)
  (with-handlers ([exn:fail? (lambda (e) #f)])
    (define u (string->url s))
    (and (or (equal? (url-scheme u) "https")
             (equal? (url-scheme u) "http"))
         (url-host u))))

(provide validate-url)
