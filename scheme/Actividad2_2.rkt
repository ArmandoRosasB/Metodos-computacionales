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


;; reverse-aux lst -> lst
(define reverse-aux
    (lambda (lst)
    (cond
    [(empty? lst) '()]
    [else (append (reverse-aux (cdr lst)) (cons (car lst) '()))])))

;; deep-reverse lst -> lst
(define deep-reverse
    (lambda (lst flag)
    (cond
    [(empty? lst) '()]
    [(= 0 flag) (deep-reverse (reverse-aux lst) 1)]
    [(list? (car lst)) (append (cons (deep-reverse (car lst) 0) '()) (deep-reverse (cdr lst) 1))]
    [else (cons (car lst) (deep-reverse (cdr lst) 1))]))) 

(deep-reverse '() 0)
;; ⇒ ()
(deep-reverse '(a (b c d) 3) 0)
;; ⇒ (3 (d c b) a)
(deep-reverse '((1 2) 3 (4 (5 6))) 0)
;; ⇒ (((6 5) 4) 3 (2 1))
(deep-reverse '(a (b (c (d (e (f (g (h i j)))))))) 0)
;; ⇒ ((((((((j i h) g) f) e) d) c) b) a)


;; insert-everywhere obj lst -> lst
;; CHECK
(define insert-everywhere
    (lambda (obj lst aux) ;; aux empieza siendo '()
    (cond
    [(empty? lst) (cons (append aux (cons obj '())) '())] ;;(cons obj '())]
    [else (append (cons (append aux (append (cons obj '()) (cdr lst))) '()) (insert-everywhere obj (cdr lst) (append aux (cons (car lst) '()))))])))

(insert-everywhere 1 '() '())
;; ⇒ ((1))
(insert-everywhere 1 '(a) '())
;; ⇒ ((1 a) (a 1))
(insert-everywhere 1 '(a b c) '())
;; ⇒ ((1 a b c) (a 1 b c) (a b 1 c) (a b c 1))
(insert-everywhere 1 '(a b c d e) '())
;; ⇒ ((1 a b c d e)
;; (a 1 b c d e)
;; (a b 1 c d e)
;; (a b c 1 d e)
;; (a b c d 1 e)
;; (a b c d e 1))
(insert-everywhere 'x '(1 2 3 4 5 6 7 8 9 10))
;; ⇒ ((x 1 2 3 4 5 6 7 8 9 10)
;; (1 x 2 3 4 5 6 7 8 9 10)
;; (1 2 x 3 4 5 6 7 8 9 10)
;; (1 2 3 x 4 5 6 7 8 9 10)
;; (1 2 3 4 x 5 6 7 8 9 10)
;; (1 2 3 4 5 x 6 7 8 9 10)
;; (1 2 3 4 5 6 x 7 8 9 10)
;; (1 2 3 4 5 6 7 x 8 9 10)
;; (1 2 3 4 5 6 7 8 x 9 10)
;; (1 2 3 4 5 6 7 8 9 x 10)
;; (1 2 3 4 5 6 7 8 9 10 x))


;; pack lst -> lst


(pack '())
;; ⇒ ()
(pack '(a a a a b c c a a d e e e e))
;; ⇒ ((a a a a) (b) (c c) (a a) (d) (e e e e))
(pack '(1 2 3 4 5))
;; ⇒ ((1) (2) (3) (4) (5))
(pack '(9 9 9 9 9 9 9 9 9))
;; ⇒ ((9 9 9 9 9 9 9 9 9))


;; compress lst -> lst


(compress '())
;; ⇒ ()
(compress '(a b c d))
;; ⇒ '(a b c d)
(compress '(a a a a b c c a a d e e e e))
;; ⇒ (a b c a d e)
(compress '(a a a a a a a a a a))
;; ⇒ (a)


;; encode
(define encode
    (lambda (lst aux) ;; aux comienza siendo '()
    (cond
    [(empty? lst) aux] ;;(cons aux '())]
    [(empty? aux) (encode (cdr lst) (cons 1 (cons (car lst) '())))]
    [(eq? (car lst) (cadr aux)) (encode (cdr lst) (cons (+ 1 (car aux)) (cons (car lst) '())))]
    [else (append (cons aux '()) (encode (cdr lst) (cons 1 (cons (car lst) '()))))])))

(encode '() '())
;; ⇒ ()
(encode '(a a a a b c c a a d e e e e) '())
;; ⇒ ((4 a) (1 b) (2 c) (2 a) (1 d) (4 e))
(encode '(1 2 3 4 5) '())
;; ⇒ ((1 1) (1 2) (1 3) (1 4) (1 5))
(encode '(9 9 9 9 9 9 9 9 9) '())
;; ⇒ ((9 9))


;; encode-modified lst -> lst


(encode-modified '())
;; ⇒ ()
(encode-modified '(a a a a b c c a a d e e e e))
;; ⇒ ((4 a) b (2 c) (2 a) d (4 e))
(encode-modified '(1 2 3 4 5))
;; ⇒ (1 2 3 4 5)
(encode-modified '(9 9 9 9 9 9 9 9 9))
;; ⇒ ((9 9))


;; decode lst -> lst 
(define decode
    (lambda (lst)
    (cond
    [(empty? lst) '()])))

(decode '())
;; ⇒ ()
(decode '((4 a) b (2 c) (2 a) d (4 e)))
;; ⇒ (a a a a b c c a a d e e e e)
(decode '(1 2 3 4 5))
;; ⇒ (1 2 3 4 5)
(decode '((9 9)))
;; ⇒ (9 9 9 9 9 9 9 9 9)


;; args-swap f(a b) x y -> f(y x)
(define args-swap
    (lambda (fun x y)
    (fun y x)))

;;((lambda(x) (+ x 5)) 5)

((args-swap list) 1 2)
;; ⇒ (2 1)
((args-swap /) 8 2)
;; ⇒ 1/4
((args-swap cons) '(1 2 3) '(4 5 6))
;; ⇒ ((4 5 6) 1 2 3)
((args-swap map) '(-1 1 2 5 10) /)
;; ⇒ (-1 1 1/2 1/5 1/10)


;; there-exists-one? f(x) lst -> bool

(define there-exists-one?
    (lambda (fn lst)
    (cond
    [(empty? lst) #f]
    [else (or (fn (car lst)) (there-exists-one? fn (cdr lst)))])))

(there-exists-one? positive? '())
;; ⇒ #f
(there-exists-one? positive? '(-1 -10 4 -5 -2 -1))
;; ⇒ #t
(there-exists-one? negative? '(-1))
;; ⇒ #t
(there-exists-one? symbol? '(4 8 15 16 23 42))
;; ⇒ #f
(there-exists-one? symbol? '(4 8 15 sixteen 23 42))
;; ⇒ #t


;; linear-search lst obj eq-fun(a b) -> num

(define linear-search
    (lambda (lst target fn aux)
    (cond
    [(empty? lst) #f]
    [(fn (car lst) target) aux]
    [else (linear-search (cdr lst) target fn (+ 1 aux))])))

(linear-search '() 5 = 0)
;; ⇒ #f
(linear-search '(48 77 30 31 5 20 91 92 69 97 28 32 17 18 96) 5 = 0)
;; ⇒ 4
(linear-search '("red" "blue" "green" "black" "white") "black" string=? 0)
;; ⇒ 3
(linear-search '(a b c d e f g h) 'h equal? 0)
;; ⇒ 7


;; deriv f(x) num -> num 


;; TEST CASES


;; newton f(x) num -> num


(newton (lambda (x) (- x 10)) 1)
;; ⇒ 10.000000000023306
(newton (lambda (x) (+ (* 4 x) 2)) 1)
;; ⇒ -0.5000000000000551
(newton (lambda (x) (+ (* x x x) 1)) 50)
;; ⇒ -0.9999999980685114
(newton (lambda (x) (+ (cos x) (* 0.5 x))) 5)
;; ⇒ -1.029866529322135


;; integral num num num f(x) -> num


(integral 0 1 10 (lambda (x) (* x x x)))
;; ⇒ 1/4
(integral 1 2 10
(lambda (x)
    (integral 3 4 10
    (lambda (y)
        (* x y)))))
;; ⇒ 21/4
