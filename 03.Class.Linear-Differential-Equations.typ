#import "mfraiman-TAU-TA.typ" as ta

#show: doc => ta.conf(
  info_file: "info",
  class_id: "03",
  activity: "Class",
  //
  doc
)

= Linear Differential Equations
 
First-order linear equations are equations of the form
$ y' + p(x) y = q(x). $
There are two main methods of solution: integrating factor and variation of parameters.

== Integrating Factor for Linear Equations

We are already familiar with this technique, however, in this case it is much easier to find the factor.
Indeed, suppose $mu = mu(x)$, then $(y mu)' = y'mu + y mu'$, so if we set $mu' slash mu = p$, the equation becomes equivalent to
$ (y dot mu)' = q dot mu ==> y(x) = 1 / (mu(x)) ( integral^x q(t) mu(t) dif t + C), thick #text[where] mu(t) = exp(integral^t p(s) dif s). $

#ta.ex(
  solution: [
    Multiplying by $mu(x)$, we get
    $mu y' + mu y / 2 = mu dot e^(x slash 3) / 2$.
    If we assume $mu / 2 = mu'$, which is satisfied in case $mu = e^(x slash 2)$, the #ta.acr[lhs] becomes
    $(mu y)'$.
    Thus, we have
    $ ( e^(x slash 2) y )' = e^(5x slash 6) / 2 ==> e^(x slash 2) y = 3 / 5 e^(5x slash 6) + c ==> y = 3 / 5 e^(x slash 3) + c e^( - x slash 2). $
    To find the particular solution, we proceed as follows
    $ y(0) = 3 / 5 + c ==> c = - 8 / 5. $
  ]
)[
  Solve the following equation $y' + y / 2 = e^(x slash 3) / 2$; $y(0) = -1$.
]

== Variation of Parameters

Let $y = f(x,c)$, where $c in RR$, be the solutions for the (separable) equation
$ y' + p(x)y = 0. $
Then all the solutions for the equation
$ y' + p(x) y = q(x) $
have the form $y = f(x, xi(x))$, where $xi$ is a function of $x$.

#ta.ex(
  solution: [
    First, let's solve $x y' = 2 y$.
    Separating the variables, we obtain
    $ (dif y) / y = 2 / x dif x ==> log abs(y) = 2 log abs(x) + c ==> y = C x^2. $
    Now we search for the solution of the form $y = xi(x) x^2$ for the initial equation:
    $ y' = 2x xi + xi' x^2 ==> 2 xi x^2 + xi' x^3 = 2 xi x^2 - 2 x^4 ==> xi' = -2x ==> xi = -x^2 + c. $
    Thus, the solutions are
    $ y(x) = (c - x^2) x^2. $
    Note that they all pass through the point $x = y = 0$, and $y'(0) = 0$, so it's possible to switch between the branches at this point.
  ]
)[
  Solve the equation $x y' = 2 y - 2x^4$.
]

== Linearisation by Switching the Variables

Sometimes an equation is not linear in $y(x)$, but becomes linear if $x$ is treated as a function of $y$.

#ta.ex(
  solution: [
    Rewriting the equation as
    $ y = (2x + y^3) (dif y) / (dif x) ==> y dif x = (2x + y^3) dif y = 0 ==> (dif x) / (dif y) - 2 / y x = y^2 $
    leads us to the linear equation $x' - 2 x slash y = y^2$, which can now be solved using one of the aforementioned methods.
  ]
)[
  Solve the equation $y = (2x + y^3) y'$.
]

== Bernoulli Equation

Bernoulli's equations have the form
$ y' = a(x)y + b(x)y^alpha, quad alpha in.not {0,1}. $
If $alpha in {0,1}$, it is linear.
Note that if $alpha > 0$, $y equiv 0$ is a solution.
To find the rest, divide both parts by $y^alpha$ and use the substitution $z = y^(1-alpha)$ (then $z' = (1-alpha)y^(-alpha) y'$):
$ y^(-alpha) y' = a(x) y^(1-alpha) + b(x) ==> z' / (1 - alpha) = a(x) z + b(x), $
which is linear.

#ta.ex(
  solution: [
    With the substitution $z = y^(-2)$ (then $z' = -2 y' y^(-3)$) we get
    $ x^2 y' y^(-3) + 2 x y^(-2) - 1 = 0 ==> ( x^2 z' ) / 2 + 2 x z - 1 = 0, $
    which is linear (after having been divided by $x^2$).
  ]
)[
  Solve the equation $x^2 y' + 2 x y - y^3 = 0$.
]

== Riccati Equation

Ricatti's equations are equations of the form
$ y' + q_0(x) + q_1(x) y + q_2(x) y^2 = 0. $
(It is a Bernoulli equation if $q_0 equiv 0$.)
In general this equation cannot be reduced to quadrature, #footnote[Quadrature --- integration.] however, if a particular
  solution $y_1(x)$ is known, then the general solution can be found by the means of the $y(x) = y_1(x) + u(x)$ substitution.
Indeed, we obtain
$ y'_1 + u' + q_1 y_1 + q_1 u + q_2 y_1^2 + 2 q_2 u y_1 + q_2 u^2 = c ==> u' + ( q_1 + 2 q_2 y_1 ) u + q_2 u^2 = 0, $
which is a Bernoulli equation.
In general, whence to get particular solution, is a question equivalent to solving the original equation,
  but sometimes it can be guessed with the method of undetermined coefficients:
  considering the form of the $q_i$'s, we can attempt to find a solution $y_1$ of a similar form.

#ta.ex(
  solution: [
    Assuming that $y_1(x) = a x + b$ for some $a$ and $b$, we get
    $ a + a^2 x^2 + 2 a b x + b^2 = x^2 - 2 x, $
    and herefrom setting $a = -1$, $b = 1$ yields
    $ u' + u^2 + 2u dot (1-x) = 0, $
    which is a Bernoulli equation.
    _(Note that this was a successful guess for $y_1$.)_ 
  ]
)[
  Solve the following equation $y' + y^2 = x^2 - 2x$.
]

== Integrating Factor in General (from Last Time)

Suppose we want to transform an equation $M(x,y) dif x + N(x,y) dif y = 0$ into $dif F(x,y) = 0$ for some $F$.
If we manage to find such a function $mu$ that
$ (partial (mu M) ) / (partial y) = (partial (mu N) ) / (partial x), $
then the #ta.acr[lhs] of the equation $mu M dif x + mu N dif y = 0$ is an exact differential (i.e.~equals to some $dif F$).

#ta.enum_l[
  Suppose an equation has the form $dif phi(x,y) + M_1(x,y) dif x + N_1(x,y) dif y = 0$.
  If there exists an integrating factor $mu(z)$, where $z = phi(x,y)$, for the equation $M_1(x,y) dif x + N_1(x,y) dif y = 0$,
    then $mu$ is also an integrating factor for the initial equation.
  Indeed, multiplying the original equation by $mu$, we get
  $ mu (phi) dif phi + mu M_1 dif x + mu N_1 dif y = 0 ==> dif ( cal(M) compose phi) + dif F_1 = 0, $ <eqexactdif2>
  where $partial F_1 slash partial x = M_1$, $partial F_1 slash partial y = N_1$, $cal(M)' = mu$.
  In this case the solutions have the form $mu compose phi + F_1 = c$.
  Now we can find $F_1$ using the method from the last time.
  For example, consider the equation
  $ (x y + y^4 ) dif x + (x^2 - x y^2) dif y = 0. $
  First, assume that we are solving the equation outside of the points $x = 0$ or $y = 0$.
  Collecting together same-power terms, we get
  $ x(y dif x + x dif y) + y^3 (y dif x - x dif y) = 0 thick --> thick dif (x y) + y^3 / x (y dif x - x dif y) = 0. $ <eq10>
  Using the general method,
    we find that $mu = 1 slash z^2 = 1 slash (x^2 y^2)$ is an integrating factor for the equation $y^3 / x (y dif x - x dif y) = 0$,
    and to find $F_1$ from @eqexactdif2, we proceed as follows:
  $ ( partial F_1 ) / ( partial x ) = y^2 / x^3 ==> F_1 = - 1 / 2 y^2 / x^3 + c(y) ==>
    -y / x^2 = ( partial F_1 ) / ( partial y ) = - y / x^2 + c'(y) ==> c(y) = c in RR. $

  Thus, the original equation is equivalent ($x eq.not 0$, $y eq.not 0$) to
  $ dif ( - 1 / (x y)  ) + dif ( - y / x^2 + c ) = 0 ==> dif (- 1 / (x y) + - y / x^2 ) = 0 #text[ and thus ] (x + y^2) / (x^2 y) = C $
  are solutions.
  Note that the original equation also had the solutions $y equiv 0$ and $x equiv 0$.
][
  Sometimes, if we can find an exact differential of some function $phi(x,y)$ (or two functions $phi$ and~$psi$),
    we can perform a change of variables $(x,y) -> (x,z)$ or $(x,y) -> (y,z)$, where $z = phi(x,y)$; or
    $(x,y) -> (u,v)$, where $u = phi(x,y)$, $v = psi(x,y)$.
  For example, consider @eq10.
  Since $y dif x - x dif y = y^2 dif (x slash y)$, the equation can be written as
  $ dif (x y) + y^5 / x dif ( x / y ) = 0 ==> dif u + ( u^2 ) / ( v^3 ) dif v = 0, $
  where $u = x y$, $v = x slash y$.
  The variables in this equation are one step away from being separated.
]
