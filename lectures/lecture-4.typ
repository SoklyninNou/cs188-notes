= CSPs Background
In search problems, we are making a number of assumptions about the world: a single agent, deterministic actions, fully observed states, discrete state spaces. etc. So we have to come up with the notion of *Identification Problems*, which is a problem of setting assignments to variables. This problem only focuses on the goal, not the path.

== Constraint Satisfaction Problems
*Constraint Satisfaction Problems* are subsets of search problems where a states are variables $XX_i$ with values from a domain $DD$. Our goal is to set constraints specifying allowable combinations of values for subsets of variables. Additionally, our constraint can be *Implicit*, which relates multiple variables to each other, or *Explicit*, which defines a set of possible values for that variable. The solution are assignments that satisfies all the constraints.

=== Binary Constraint Satisfaction Problems
A *Binary Constraint Satisfaction Problem* are a subset of CSPs where each constraint relates at most two variables. This can be turned into a graph with edges representing constraints. If constraints relates to more than two variable, we can add a dummy node to represent the constraint with edges connecting the variable it relates to.

== Solving Constraint Satisfaction Problems
A naive approach to solving CSPs is to formulate it as a search problem. But, the problem with this is that search problems cannot check constraints of the states nor is it efficient since we have to go down to the leaf. One fix for checking constraints is using backtracking search.

=== Backtracking Search
*Backtracking Search* is an extra computation on top of normal searches that checks constraints as you go. This requires extra computation on each node but removes the chance of going down an invalid path.
#align(center)[
  #image("../images/backtracking-pseudo.png", width: 60%)
]
Backtracking requires us to consider parameters of assignments. Some parameters are:
- *Ordering:* what variable should be assigned next and in what order should the values be tried
- *Filtering:* how to detect if a solution is invalid early.
- *Structure:* can we take advantage of a problem's structure.

==== Filtering
The general idea of filtering is to keep track of domains for unassigned variables and cross off bad options. we do this by *Forward Checking*, crossing off values that violate a constraint when added to the existing assignment. Forward checking propagates information from assigned to unassigned variables, but doesn't provide early detection for all failures.

==== Arc Consistency
*Arc Consistency* handles the detection of invalid solutions. A arc $X arrow Y$ is consistent iff:
$
forall x in X, exists y in Y: Y=y and X=x "is valid"
$
The algorithm of this is we select each possible value of $X$ and see if there is an assignment to $Y$. If not, remove that value from $X$. This means we check the head and remove the tail. Even after enforcing arc consistency, there could be one solution, multiple solutions, or no solutions. *Important:* If X loses a value, neighbors of X need to be rechecked!

==== Ordering
*Minimum remaining values:* Choose the variable with the fewest legal left values in its domain.\
*Least Constraining Value:* Choose the values that remove the least amount of other values
