Title: Is Three the Only Prime Number Followed by a Perfect Square?
Created: 2023-02-24
Updated: 2023-02-24
Tag: Math
Tag: Proofs
=== markdown ===

One of my friend's recently posed this question for me to solve after I had
mentioned to him that I had been wanting to get back into mathematics: Can you
show that 3 is the only prime number followed by a perfect square? A prime
number being an integer with only two factors, one and itself. A perfect square
being an integer $s$ that is equal to another integer $z$ multiplied by itself.

To answer this question it must be shown that the following does not hold:

Let $p \in \mathbb{P}$, $p > 3$

Let $z \in \mathbb{Z}$, $z > 0$

$p + 1 = z ^ 2$

Proof:

1. Rewrite the equation

	$p + 1 = z^2$

	$p = z^2 - 1$

	$p = (z + 1)(z - 1)$

2. Show that $z - 1 > 1 \iff p > 3$

	a. When $z = 1$ then $z - 1 = 1 - 1 = 0$ and $p = 0$

	b. When $z = 2$ then $z - 1 = 2 - 1 = 1$ and $p = 3$

	c. Using induction we can say that when $n > 2$ and $n \in \mathbb{N}$ when $z = n + 1$ then $z - 1 = n + 1 - 1 = n$ and $p = n^2 + 1$

3. Show that $z + 1 > 1 \iff p > 3$

	This is trivial, as any integer greater than 0 added to one will be greater
	than one.

4. Show that $z + 1 \ne p$ and $z - 1 \ne p$

	Since both $z + 1 > 1$ and $z - 1 > 1$ then

	a. When $z + 1 = p$, $(z + 1)(z - 1) >= 2p$

	b. When $z - 1 = p$, $(z + 1)(z - 1) >= 2p$

5. Since it can be shown that neither $(z + 1)$ or $(z - 1)$ are $p$ or $1$,
   this violates the definition of a prime number. A prime number only has two
   factors: itself and the number 1.

This shows that $\forall p > 3$, $p + 1$ is not a perfect square.
