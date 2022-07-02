#lang racket

(require racket/date)

(define (epoch->iso-8601 seconds)
  (date->string (seconds->date seconds #f)
                (date-display-format 'iso-8601)))

(define (epoch->string seconds)
  (define (format-time value single plural)
    (format "~a ~a ago" value (if (> value 1) plural single)))
  (let* ([s (- (current-seconds) seconds)]
         [m (quotient s 60)]
         [h (quotient m 60)]
         [d (quotient h 24)])
    (cond
      [(> d 0) (format-time d "day" "days")]
      [(> h 0) (format-time h "hour" "hours")]
      [(> m 0) (format-time m "minute" "minutes")]
      [(> s 0) (format-time s "second" "seconds")]
      [else "now"])))

(provide epoch->iso-8601
         epoch->string)
