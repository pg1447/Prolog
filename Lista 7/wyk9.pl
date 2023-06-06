merge(IN1, IN2, OUT) :-
    freeze(IN1,
    ((IN1 = [H1 | T1]
    ->
        freeze(IN2,
        ((IN2 = [H2 | T2]
        ->
            (H1 > H2
            ->
                OUT = [H2|T3],
                merge(IN1,T2,T3)
            ;
                OUT = [H1|T4],
                merge(T1,IN2,T4)
            )
        ; OUT = IN1)
        )
    )

; OUT = IN2)

)
).

split(IN1, OUT1, OUT2) :-
    split(IN1, OUT1, OUT2, true).

split(IN1, OUT1, OUT2, TF) :-
    freeze(IN1,
    ((IN1 = [H1 | T1]
    -> (TF
    ->	OUT1 = [H1|OUT11],
        split(T1, OUT11, OUT2, false)
    ;	OUT2 = [H1|OUT21],
        split(T1, OUT1, OUT21, true)
    )
;   OUT1 = [],
    OUT2 = []
))).

merge_sort(IN, OUT) :-
    freeze(IN,
    ((IN = [_|T1]
    -> freeze(T1, (
        (T1 = [_|_]
        ->
            split(IN, OUT1, OUT2),
            merge_sort(OUT1, OUT11),
            merge_sort(OUT2, OUT22),
            merge(OUT11, OUT22, OUT)
        ;
            OUT = IN
        )
    ))
; OUT = IN)
)).
