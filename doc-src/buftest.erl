-module(buftest).

-export([
        loop/1
    ]).

calc(H, H2) ->
    ok = io:format("H = ~p, H2 = ~p~n", [H, H2]),
    H2.

loop({[H], RL}) ->
    NL = lists:reverse(RL),
    loop({[H|NL], []});
loop({L, RL}) ->
    [H|L2] = L,
    [H2|L3] = L2,
    NH2 = calc(H, H2),
    NL2 = [NH2|L3],
    NRL = [H|RL],
    {NL2, NRL}.
