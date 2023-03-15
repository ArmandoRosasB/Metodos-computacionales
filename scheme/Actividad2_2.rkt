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
    (lambda (num n) ;; n comienza siendo 2
    (cond
    [(= num 1) '()]
    [(= (remainder num n) 0) (cons n (prime-factors (/ num n) n))]
    [else (prime-factors num (+ n 1))])))
    
(prime-factors 1 2)
;; ⇒ ()
(prime-factors 6 2)
;; ⇒ (2 3)
(prime-factors 96 2)
;; ⇒ (2 2 2 2 2 3)
(prime-factors 97 2)
;; ⇒ (97)
(prime-factors 666 2)
;; ⇒ (2 3 3 37)


;; gcd num num -> num
(define gcd-aux
    (lambda (lst1 lst2 acc) ;; acc comienza siendo 1
    (cond
    [(empty? lst1) acc]
    [(empty? lst2) acc]
    [(< (car lst1) (car lst2)) (gcd-aux (cdr lst1) lst2 acc)]
    [(< (car lst2) (car lst1)) (gcd-aux lst1 (cdr lst2) acc)]
    [else (gcd-aux (cdr lst1) (cdr lst2) (* acc (car lst1)))])))


;; gcd num num -> num
(define gcd
    (lambda (num1 num2)
    (gcd-aux (prime-factors num1 2) (prime-factors num2 2) 1)))

(gcd 13 7919)
;; ⇒ 1
(gcd 20 16)
;; ⇒ 4
(gcd 54 24)
;; ⇒ 6
(gcd 6307 1995)
;; ⇒ 7
(gcd 48 180)
;; ⇒ 12
(gcd 42 56)
;; ⇒ 14


;; deep-reverse lst -> lst


(deep-reverse '())
;; ⇒ ()
(deep-reverse '(a (b c d) 3))
;; ⇒ (3 (d c b) a)
(deep-reverse '((1 2) 3 (4 (5 6))))
;; ⇒ (((6 5) 4) 3 (2 1))
(deep-reverse '(a (b (c (d (e (f (g (h i j)))))))))
;; ⇒ ((((((((j i h) g) f) e) d) c) b) a)
