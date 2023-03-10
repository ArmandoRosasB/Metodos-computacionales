#lang racket

;; Actividad 2.1
;; Autores: Ramona Najera Fuentes
;;          Jose Armando Rosas Balderas


;; fahrenheit-to-celsius number -> number
(define fahrenheit-to-celsius
    (lambda (f)
        (/ (* 5 (- f 32)) 9)))

;; Casos prueba

(fahrenheit-to-celsius 212.0)
;;⇒ 100.0
(fahrenheit-to-celsius 32.0)
;;⇒ 0.0
(fahrenheit-to-celsius -40.0)
;;⇒ -40.0


;; sign number -> number
(define sign
    (lambda (n)
        (cond
        [(eq? n 0) 0]
        [(> n 0) 1]
        [else -1])))


;; Casos prueba

(sign -5)
;;⇒ -1
(sign 10)
;;⇒ 1
(sign 0)
;;⇒ 0


;; roots number number number => number

(define roots
    (lambda (a b c)
        (/ (+ (* -1 b) (sqrt (- (expt b 2) (* (* a c ) 4)))) (* 2 a))))


;; Casos prueba

(roots 2 4 2)
;;⇒ -1
(roots 1 0 0)
;;⇒ 0
(roots 4 5 1)
;;⇒ -1/4


;; bmi number number -> string

(define bmi
    (lambda (weight height)
        (cond
        [(< (/ weight (expt height 2)) 20) (printf "underweight")]
        [(< (/ weight (expt height 2)) 25) (printf "normal")]
        [(< (/ weight (expt height 2)) 30) (printf "obese1")]
        [(< (/ weight (expt height 2)) 40) (printf "obese2")]
        [else (printf "obese3")])))
    
;; Casos Prueba

(bmi 45 1.7)
;;⇒ underweight
(bmi 55 1.5)
;;⇒ normal
(bmi 76 1.7)
;;⇒ obese1
(bmi 81 1.6)
;;⇒ obese2
(bmi 120 1.6)
;;⇒ obese3



;; factorial-head num -> num

(define factorial-head
    (lambda (n)
    (cond 
    [(< n 2) 1]
    [else (* n (factorial-head(- n 1)))])))



;; factorial-tail num num -> num
(define factorial-tail
    (lambda (n acc) ;; acc comienza en 1
    (cond
    [(< n 2) acc]
    [else (factorial-tail (- n 1) (* acc n))])))

(factorial-head 0)
;;⇒ 1
(factorial-head 5)
;;⇒ 120
(factorial-head 40)
;;⇒ 815915283247897734345611269596115894272000000000

(factorial-tail 0 1)
;;⇒ 1
(factorial-tail 5 1)
;;⇒ 120
(factorial-tail 40 1)
;;⇒ 815915283247897734345611269596115894272000000000


;; duplicate-head lst -> lst

(define duplicate-head
    (lambda (lst)
        (cond 
        [(empty? lst) '()]
        [else (cons (car lst) (cons (car lst) (duplicate-head (cdr lst))))])))


(duplicate-head '())
;;⇒ ()
(duplicate-head '(1 2 3 4 5))
;;⇒ (1 1 2 2 3 3 4 4 5 5)
(duplicate-head '(a b c d e f g h))
;;⇒ (a a b b c c d d e e f f g g h h)


;; duplicate-tail lst lst -> lst

(define duplicate-tail
    (lambda (lst acc) ;; acc empeiza siendo una lista vacia
        (cond 
        [(empty? lst) acc]
        [else (duplicate-tail (cdr lst) (append acc (cons (car lst) (cons(car lst) '()))))])))


(duplicate-tail '() '())
;;⇒ ()
(duplicate-tail '(1 2 3 4 5) '())
;;⇒ (1 1 2 2 3 3 4 4 5 5)
(duplicate-tail '(a b c d e f g h) '())
;;⇒ (a a b b c c d d e e f f g g h h)


;; pow-head num num -> num

(define pow-head
    (lambda (a b)
    (cond
    [(= b 0) 1]
    [(= b 1) a]
    [else (* a (pow-head a (- b 1)))])))

(pow-head 5 0)
;;⇒ 1
(pow-head -5 3)
;;⇒ -125
(pow-head 15 12)
;;⇒ 129746337890625


;; pow-tail num num num -> num

(define pow-tail
    (lambda (a b acc)
    (cond
    [(= b 0) acc]
    [else (pow-tail a (- b 1) (* acc a))])))

(pow-tail 5 0 1)
;;⇒ 1
(pow-tail -5 3 1)
;;⇒ -125
(pow-tail 15 12 1)
;;⇒ 129746337890625


;; fib num -> num

(define fib
    (lambda (n)
    (cond
    [(< n 2) n]
    [else (+ (fib (- n 1)) (fib (- n 2)))])))

(fib 6)
;;⇒ 8
(map fib (range 10))
;;⇒(0 1 1 2 3 5 8 13 21 34)
(fib 42)
;;⇒ 267914296

;; enlist-head lst -> lst

(define enlist-head
    (lambda (lst)
        (cond
        [(empty? lst) '()]
        [else (cons (cons (car lst) '()) (enlist-head (cdr lst)))])))

(enlist-head '())
;;⇒ ()
(enlist-head '(a b c))
;;⇒ ((a) (b) (c))
(enlist-head '((1 2 3) 4 (5) 7 8))
;;⇒ (((1 2 3)) (4) ((5)) (7) (8))



;; enlist-tail lst lst -> lst

(define enlist-tail
    (lambda (lst acc) ;; acc empeiza siendo una lista vacia
        (cond
        [(empty? lst) acc]
        [else (enlist-tail (cdr lst) (append acc (cons (cons (car lst) '()) '())))])))

(enlist-tail '() '())
;;⇒ ()
(enlist-tail '(a b c) '())
;;⇒ ((a) (b) (c))
(enlist-tail '((1 2 3) 4 (5) 7 8) '())
;;⇒ (((1 2 3)) (4) ((5)) (7) (8))


;; positives-head lon -> lon

(define positives-head
    (lambda (lst)
    (cond 
    [(empty? lst) '()]
    [(< (car lst) 0) (positives-head (cdr lst))]
    [else (append (cons (car lst) '()) (positives-head (cdr lst)))])))


(positives-head '())
;;⇒ ()
(positives-head '(12 -4 3 -1 -10 -13 6 -5))
;;⇒ '(12 3 6)
(positives-head '(-4 -1 -10 -13 -5))
;;⇒ ()


;; positives-tail lon -> lon

(define positives-tail
    (lambda (lst acc) ;; acc empeiza siendo una lista vacia
    (cond 
    [(empty? lst) acc]
    [(< (car lst) 0) (positives-tail (cdr lst) acc)]
    [else (positives-tail (cdr lst) (append acc (cons (car lst) '())))])))


(positives-tail '() '())
;;⇒ ()
(positives-tail '(12 -4 3 -1 -10 -13 6 -5) '())
;;⇒ '(12 3 6)
(positives-tail '(-4 -1 -10 -13 -5) '())
;;⇒ ()


;; add-list-head lon -> num
(define add-list-head
    (lambda (lst)
    (cond
    [(empty? lst) 0]
    [else (+ (car lst) (add-list-head (cdr lst)))])))


(add-list-head '())
;;⇒ 0
(add-list-head '(2 4 1 3))
;;⇒ 10
(add-list-head '(1 2 3 4 5 6 7 8 9 10))
;;⇒ 55


;; add-list-tail lon -> num
(define add-list-tail
    (lambda (lst acc) ;; acc empeiza siendo 0
    (cond
    [(empty? lst) acc]
    [else (add-list-tail (cdr lst) (+ acc (car lst)))])))


(add-list-tail '() 0)
;;⇒ 0
(add-list-tail '(2 4 1 3) 0)
;;⇒ 10
(add-list-tail '(1 2 3 4 5 6 7 8 9 10) 0)
;;⇒ 55


;; invert-pairs-head lst -> lst
(define invert-pairs-head
    (lambda (lst)
    (cond
    [(empty? lst) '()]
    [else (cons (cons (cadr (car lst)) (cons (car (car lst)) '())) (invert-pairs-head (cdr lst)))])))

(invert-pairs-head '())
;;⇒ ()
(invert-pairs-head '((a 1)(a 2)(b 1)(b 2)))
;;⇒ ((1 a)(2 a)(1 b)(2 b))
(invert-pairs-head '((January 1)(February 2)(March 3)))
;;⇒ ((1 January)(2 February)(3 March))

;; invert-pairs-tail lst -> lst
(define invert-pairs-tail
    (lambda (lst acc) ;; acc empeiza siendo una lista vacia
    (cond
    [(empty? lst) acc]
    [else (invert-pairs-tail (cdr lst) (append acc (cons (cons (cadr (car lst)) (cons (car (car lst)) '())) '())))])))

(invert-pairs-tail '() '())
;;⇒ ()
(invert-pairs-tail '((a 1)(a 2)(b 1)(b 2))  '())
;;⇒ ((1 a)(2 a)(1 b)(2 b))
(invert-pairs-tail '((January 1)(February 2)(March 3))  '())
;;⇒ ((1 January)(2 February)(3 March))


;; list-of-symbols? lst -> bool
(define list-of-symbols?
    (lambda (lst)
    (cond
    [(empty? lst) true]
    [(number? (car lst)) false]
    [else (list-of-symbols? (cdr lst))])))

(list-of-symbols? '())
;;⇒ #t
(list-of-symbols? '(a b c d e))
;;⇒ #t
(list-of-symbols? '(a b c d 42 e))
;;⇒ #f


;; swapper a, b, lst => lst
(define swapper
    (lambda (a b lst)
    (cond
    [(empty? lst) '()]
    [(eq? (car lst) a) (cons b (swapper a b (cdr lst)))]
    [(eq? (car lst) b) (cons a (swapper a b (cdr lst)))]
    [else (cons (car lst) (swapper a b (cdr lst)))])))

(swapper 1 2 '())
;;⇒ ()
(swapper 1 2 '(4 4 5 2 4 8 2 5 6 4 5 1 9 5 9 9 1 2 2 4))
;;⇒ (4 4 5 1 4 8 1 5 6 4 5 2 9 5 9 9 2 1 1 4)
(swapper 1 2 '(4 3 4 9 9 3 3 3 9 9 7 9 3 7 8 7 8 4 5 6))
;;⇒ (4 3 4 9 9 3 3 3 9 9 7 9 3 7 8 7 8 4 5 6)
(swapper 'purr 'kitty '(soft kitty warm kitty little ball of fur happy kitty sleepy kitty purr purr purr))
;;⇒ (soft purr warm purr little ball of fur happy purr sleepy purr kitty kitty kitty)


;; dot-product-head lon lon => num
(define dot-product-head
    (lambda (ist jst)
    (cond
    [(empty? ist) 0]
    [else (+ (* (car ist) (car jst)) (dot-product-head (cdr ist) (cdr jst)))])))

(dot-product-head '() '())
;;⇒ 0
(dot-product-head '(1 2 3) '(4 5 6))
;;⇒ 32
(dot-product-head '(1.3 3.4 5.7 9.5 10.4) '(-4.5 3.0 1.5 0.9 0.0))
;;⇒ 21.45


;; dot-product-tail lon lon => num
(define dot-product-tail
    (lambda (ist jst acc)
    (cond
    [(empty? ist) acc]
    [else (dot-product-tail (cdr ist) (cdr jst) (+ acc (* (car ist) (car jst))))])))

(dot-product-tail '() '() 0)
;;⇒ 0
(dot-product-tail '(1 2 3) '(4 5 6) 0)
;;⇒ 32
(dot-product-tail '(1.3 3.4 5.7 9.5 10.4) '(-4.5 3.0 1.5 0.9 0.0) 0)
;;⇒ 21.45


;; sum-tail lst -> num
(define sum-tail
    (lambda (lst acc) ;; acc empieza siendo 0
    (cond
    [(empty? lst) acc]
    [else (sum-tail (cdr lst) (+ acc (car lst)))])))

;; count-elem-tail lst -> num
(define count-elem-tail
    (lambda (lst acc) ;; acc empieza siendo 0
    (cond
    [(empty? lst) acc]
    [else (count-elem-tail (cdr lst) (+ 1 acc))])))

;; average lon => num 
(define average
    (lambda (lst)
    (cond
    [(empty? lst) 0]
    [else (/ (sum lst) (count-elem lst))])))

(average '())
;;⇒ 0
(average '(4))
;;⇒ 4
(average '(5 6 1 6 0 1 2))
;;⇒ 3
(average '(1.7 4.5 0 2.0 3.4 5 2.5 2.2 1.2))
;;⇒ 2.5


;; aux-deviation-tail lon => num
(define aux-deviation-tail
    (lambda (lst avg acc) ;; acc comienza siendo una lista vacia
    (cond
    [(empty? lst) acc]
    [else (aux-deviation-tail (cdr lst) avg (append acc (cons (expt (- (car lst) avg) 2) '())))])))
    
;;(aux-deviation-tail '(1 2 3) 2 '())
;;=> '(1 0 1)

;; standard-deviation lon => num
;;(define standard-deviation
;;    (lambda (lst)
;;    (cond
;;    [(empty? lst) 0]
;;    [else (expt (/ (sum-tail (aux-deviation-tail lst ((average lst)) '()) 0) (count-elem-tail lst 0)) (/ 1 2))])))

;;(standard-deviation '())
;;⇒ 0
;;(standard-deviation '(4 8 15 16 23 42))
;;⇒ 12.3153
;;(standard-deviation '(110 105 90 100 95))
;;⇒ 7.07106
;;(standard-deviation '(9 2 5 4 12 7 8 11 9 3 7 4 12 5 4 10 9 6 9 4))
;;⇒ 2.983