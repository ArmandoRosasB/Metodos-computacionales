#lang racket

;; Actividad 2.2
;; Autores: Ramona Najera Fuentes
;;          Jose Armando Rosas Balderas


;; insert num lon -> lon

(define insert
    (lambda (n lst)
    (cond
    [(empty? lst) (cons n '())]
    [(< (car lst) n) (append (cons (car lst) '()) (insert n (cdr lst)))]
    [else (append (cons n '()) lst)])))

(insert 14 '())
;;⇒ (14)
(insert 4 '(5 6 7 8))
;;⇒ '(4 5 6 7 8)
(insert 5 '(1 3 6 7 9 16))
;;⇒ (1 3 5 6 7 9 16)
(insert 10 '(1 5 6))
;;⇒ (1 5 6 10)

;; insertion-sort lon -> lon
(define insertion-sort
    (lambda (lst)
    (cond
    [(empty? lst) '()]
    [else (insert (car lst) (insertion-sort (cdr lst)))])))

(insertion-sort '())
;; ⇒ ()
(insertion-sort '(4 3 6 8 3 0 9 1 7))
;; ⇒ (0 1 3 3 4 6 7 8 9)
(insertion-sort '(1 2 3 4 5 6))
;; ⇒ (1 2 3 4 5 6)
(insertion-sort '(5 5 5 1 5 5 5))
;; ⇒ (1 5 5 5 5 5 5)


;; count-elem-tail lst -> num
(define count-elem-tail
    (lambda (lst acc) ;; acc empieza siendo 0
    (cond
    [(empty? lst) acc]
    [else (count-elem-tail (cdr lst) (+ 1 acc))])))

;; rotate-left num lst -> lst

(define rotate-left
    (lambda (n lst)
    (cond
    [(empty? lst) '()]
    [(= n 0) lst]
    [(< n 0 ) (rotate-left (- (+ (remainder n (count-elem-tail lst 0)) (count-elem-tail lst 0)) 1) (append (cdr lst) (cons (car lst) '()))) ]
    [else (rotate-left (- (remainder n (count-elem-tail lst 0)) 1) (append (cdr lst) (cons (car lst) '())))])))


(rotate-left 5 '())
;; ⇒ ()
(rotate-left 0 '(a b c d e f g))
;; ⇒ (a b c d e f g)
(rotate-left 1 '(a b c d e f g))
;; ⇒ (b c d e f g a)
(rotate-left -1 '(a b c d e f g))
;; ⇒ (g a b c d e f)
(rotate-left 3 '(a b c d e f g))
;; ⇒ (d e f g a b c)
(rotate-left -3 '(a b c d e f g))
;; ⇒ (e f g a b c d)
(rotate-left 8 '(a b c d e f g))
;; ⇒ (b c d e f g a)
(rotate-left -8 '(a b c d e f g))
;; ⇒ (g a b c d e f)
(rotate-left 45 '(a b c d e f g))
;; ⇒ (d e f g a b c)
(rotate-left -45 '(a b c d e f g))
;; ⇒ (e f g a b c d)


;; prime-factors num -> lon

(define prime-factors
    (lambda (num)
    [cond ]))