-module(test).

-export([
        loop1/1,
        loop2/1,
        main/0
        ]).

-spec loop1(non_neg_integer()) -> ok.

loop1(N) ->
    loop1(N, 0).

-spec loop1(non_neg_integer(), non_neg_integer()) -> ok.

loop1(0, _) ->
    ok = io:format("~n");
loop1(N, V) ->
    ok = io:format("~B ", [V]),
    loop1(N - 1, V + 1).

-spec loop2(list(string())) -> ok.

loop2([]) ->
    ok = io:format("~n");
loop2(L) ->
    [H|T] = L,
    ok = io:format("~s ", [H]),
    loop2(T).

-spec main() -> ok.

main() ->
    loop1(10),
    loop2(["one", "two", "three"]).

