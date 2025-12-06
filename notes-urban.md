# Reading notes

## Funkcja kosztu

> The cost model for GEQO is similar to the one used by the standard planner, with the
> difference that startup cost is ignored, and plans are only compared based on their total cost.

Użycie np. Reciprocal Rank Fusion/Weighed Reciprocal Rank do połączenia kosztów, z nowymi pg parametrami do wag.

Alternatywnie inny sposób na połączenia kosztów z użyciem wagam.

## Losowa populacja 0

> The initial population of randomly chosen Chromosomes

Wydaje mi się, że używana jest heurestyka, bo było o tym w mailach.

## Unikanie iloczynu kartezjańskiego

> An important feature of the GEQO algorithm
> is that it only creates joins if there is a restriction clause that can be applied to the join, in
> other words it is avoiding forming Cartesian joins.

(do zapamiętania)

## Bush

> The ability to join Clumps makes GEQO capable of producing bushy plans.

## Struktury

> the content of inner nodes can
> be always recovered by rebuilding the whole tree bottom to top. The only consideration is
> avoiding too many rebuilds, which are the most costly part of the algorithm.

SAIO używa własnej reprezentacji. Co jeśli udałoby się zdefiniować podobieństwo na istniejących strukturach postgresa, żeby nie robić tego budowania?
Problem taki, że nawet GEQO używa clampów, a ja ich nie mogę użyć, bo chcę trzymać explicite kształt drzewa jako część genomu.

# Zakładki

## Duże kwerendy, pamięć

> As we explained in section 2.3
> keeping all built RelOptInfos in memory is simply not possible when planning a large query.
