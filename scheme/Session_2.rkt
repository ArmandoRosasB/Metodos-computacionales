;; Sesion 2

#lang racket

;; 5 pesos -> 120 asistentes
;; -.1 -> +15


(define attendees
    (lambda (ticket-price)
        (+ 120
        (*(/ 15 0.10) (- 5.00 ticket-price)))))

;; (attendees 4.9) => 134.99


;; revenue number => number
(define revenue
    (lambda (ticket-price)
    (* (attendees ticket-price) ticket-price)))

;; (revenue 4.9) => 661.49

;; cost number -> number
(define cost
    (lambda (ticket-price)
    (+ 180
        (* 0.04 (attendees ticket-price)))))

;; (cost 4.9) => 185.4

;; best-ticket-price number number -> number
(define best-ticket-price
    (lambda (ticket-price best)
        (cond 
            [(<= ticket-price 0.0) 'notfound]
        [(> (- (revenue ticket-price)
            (cost ticket-price)) best)
            (best-ticket-price (- ticket-price 0.10)
                                (- (revenue ticket-price)
                                    (cost ticket-price)))]
                [else ticket-price])))


;; Lista

(define lst '(1, 2, 3, 4, 5, 6, 7, 8, 9, 10))

;; first -> primer elemento
;; (cadr lst) Segundo elemento
;; (caddr lst) Tercer elemento


;; lon == list of numbers

;; size-head: lon -> number
(define size-head
    (lambda (lst)
        (cond
            [(empty? lst) 0]
            [else (+ 1 (size-head(cdr lst)))])))

;; size-tail lon -> number
(define size-tail
    (lambda(lst acc)
        (cond
        [(empty? lst) acc]
        [else (size-tail (rest lst) (+ acc 1))])))


;;Suma de los número de una lista head
(define sum-list-head
  (lambda (lst)
    (cond
      [(empty? lst)0]
      [else(+ (car lst) (sum-list-head (cdr lst)))])))

;;Suma de los numeros de una lista tail
(define sum-list-tail
  (lambda(lst acc)
    (cond
      [(empty? lst) acc]
      [else (sum-list-tail (cdr lst) ( + acc(car lst)))])))

;; Promedio-head

(define average
    (lambda (lst)
    (/ (sum-list-tail lst 0)
        (size-tail lst 0))))

;; Maximum-tail
(define Maximum-tail
    (lambda (lst best)
        (cond
            [(empty? lst) best]
            [(> (car lst) best) (Maximum-tail (cdr lst)
                                                (car lst))]
            [else (Maximum-tail (cdr lst) best)])))



;; Sublistas

;; cons -> Agrega un elemento a la primera posicion de la lista

;;list-of-number: number number -> lon
(define list-of-numbers
    (lambda (start end)
        (cond
        [(> start end) (list-of-numbers end start)]
        [(eq? start end) (cons start '())]
        [else (cons start (list-of-numbers (+ start 1) end))])))

;; pairs lon -> lon

(define evens
    (lambda (lst)
    (cond 
    [(empty? lst) '()]
    [(= (remainder (car lst) 2) 0)
        (cons (car lst) (evens (cdr lst)))]
    [else (evens (cdr lst))])))


;; more-than: number lon -> lon

(define more-than
    (lambda (n lst)
    (cond
    [(empty? lst) '()]
    [(> (car lst) n) (cons (car lst)
                            (more-than n (cdr lst)))]
    [else (more-than n (cdr lst))])))

(define less-than
    (lambda (n lst)
    (cond
    [(empty? lst) '()]
    [(< (car lst) n) (cons (car lst)
                            (less-than n (cdr lst)))]
    [else (less-than n (cdr lst))])))

;; QuickSort
(define QuickSort
    (lambda (lst)
    (cond
        [(empty? lst) '()]
        [else
            (append (QuickSort (less-than (car lst) (cdr lst)))
            (cons (car lst)
            (QuickSort
            (more-than (car lst) (cdr lst)))))])))

;;La criba de Latostenes
(define not-multiples
  (lambda (n lst)
    (cond
      [(empty? lst) '()]
      [(=(remainder(car lst)n)0)
       (not-multiples n(cdr lst))]
      [else (cons(car lst)
                 (not-multiples n (cdr lst)))])))

;;Sieve-aux:n list of numbers -> list of numbers
(define sieve-aux
  (lambda(lst)
    (cond
      [(empty? lst) '()]
      [else (cons (car lst)
                  (sieve-aux(not-multiples(car lst)
                                          (cdr lst))))])))
;; sieve-of-eratosthenes
(define sieve-of-era
  (lambda (n)
    (sieve-aux(list-of-numbers 2 n))))