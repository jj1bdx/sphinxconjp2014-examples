==============
Test Chapter 2
==============

This is a part of test document for Kenji Rikitake's LaTeX presentation for
SphinxCon JP 2014.

Rewriting Loop with a Pair of Lists
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Iteration loops are not necessarily a fundamental element of computer
languages.  Python_ is one of the popular languages which have the loop
structure embedded.  On the other hand, Erlang_ is *not*.

.. _Python: http://www.python.org/

.. _Erlang: http://www.erlang.org/

Loop in Python
**************

Python loop is simple. Here's an example, of counting up a number, and
choosing each member in a list, in Python 3:

.. code-block:: python

   #!/usr/bin/env python3
   
   if __name__ == '__main__':
       i = 0
       while i < 10:
           print(i, end=" ")
           i += 1
       print(end="\n")
   
       l = ["one","two","three"]
       for i in l:
           print (i, end=" ")
       print(end="\n")

The execution result of this code is:

.. code-block:: console

   0 1 2 3 4 5 6 7 8 9
   one two three

Loop in Erlang
^^^^^^^^^^^^^^

A simple recursive loop
***********************

In Erlang_, you need to make a recursive function to iterate:

.. code-block:: erlang

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

The execution result of this code is:

.. code-block:: console
   
   Erlang/OTP 17 [erts-6.2] [source] [64-bit] [smp:8:8] [async-threads:10] [kernel-poll:false] [dtrace]
   
   Eshell V6.2  (abort with ^G)
   1> c(test).
   {ok,test}
   2> l(test).
   {module,test}
   3> test:main().
   0 1 2 3 4 5 6 7 8 9
   one two three
   ok
   
A ring buffer in Erlang
***********************

Here, another example of loop using a ring buffer, which maintaine a
fixed number of elements in the buffer structure, shifting each element
one by one, with the new element added every time at the tail.

In Erlang_, splitting a list into the single head element and the tail
elements is a part of the fundamental operation and can be performed at
a very low cost. Removing the first head element from a list, and adding
another element on the head of the list is a low-cost operation.
On the other hand, `appending an element to the tail` is relatively a
higher cost operation in Erlang_.

In the following example, a ring buffer list is split into two lists
``L`` and ``RL`` as follows:

* A list ``L`` is used so that the head value of the list ``L`` is taken
  and removed.

* Another list ``RL`` is used so that the appended value is added to the
  `head` of the list ``RL``.

* When ``L`` becomes a null list, a reversed list of ``RL`` computed by
  ``lists:reverse/1`` is assigned to the new ``L``, and a null list is
  assigned to the new ``RL``.

Here is an example of the code:

.. code-block:: erlang

   %%% source code quoted from:
   %%% https://gist.github.com/jj1bdx/cae6012d5d7c3a5d0a4d
   
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
       % here in calc/1 you can add an arbitrary value
       NH2 = calc(H, H2),
       NL2 = [NH2|L3],
       NRL = [H|RL],
       {NL2, NRL}.

And here's an example of the execution, which simply rotates each
element in the list as a ring:
       
.. code-block:: console

   Erlang/OTP 17 [erts-6.2] [source] [64-bit] [smp:8:8] [async-threads:10] [kernel-poll:false] [dtrace]
   
   Eshell V6.2  (abort with ^G)
   1> l(buftest).
   {module,buftest}
   2> L1 = buftest:loop({[a,b,c],[]}).
   H = a, H2 = b
   {[b,c],[a]}
   3> L2 = buftest:loop(L1).
   H = b, H2 = c
   {[c],[b,a]}
   4> L3 = buftest:loop(L2).
   H = c, H2 = a
   {[a,b],[c]}
   5> L4 = buftest:loop(L3).
   H = a, H2 = b
   {[b],[a,c]}
   6> L5 = buftest:loop(L4).
   H = b, H2 = c
   {[c,a],[b]}
   7> L6 = buftest:loop(L5).
   H = c, H2 = a
   {[a],[c,b]}
   8> L7 = buftest:loop(L6).
   H = a, H2 = b
   {[b,c],[a]}
   9> L8 = buftest:loop(L7).
   H = b, H2 = c
   {[c],[b,a]}
   


