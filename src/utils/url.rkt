#lang racket

(require net/url)

(define (fetch s)
  (call/input-url (string->url s)
                  get-pure-port
                  port->string))

(define (validate-url s)
  (with-handlers ([exn:fail? (lambda (e) #f)])
    (define u (string->url s))
    (and (or (equal? (url-scheme u) "https")
             (equal? (url-scheme u) "http"))
         (url-host u))))

(provide fetch
         validate-url)
