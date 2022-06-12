# InfiniteTrees
<p>The next restriction we are going to relax is the limitation to finite trees. It is clear that we cannot store infinite trees in finite memory, thus, we have to define the trees in a lazy fashion, such that only the subtree that is actually required is constructed, while the rest is not. Let the type</p>  

```ocaml
type 'a tree = Empty | Node of 'a * 'a tree * 'a tree
```
<p>define polymorphic lazy (infinite) binary trees. Instead of storing a left and right child directly, we keep a function to construct them if ever needed. Note, that we do no longer need an <code>Empty</code> constructor, since our trees are always infinite.</p>  

```ocaml
type 'a ltree = LNode of 'a * (unit -> 'a ltree) * (unit -> 'a ltree)
```
<p>Implement the following functions for infinite tree construction:</p>
<ol>
<li><code>layer_tree : int -&gt; int ltree</code><br>  
  
  <code>layer_tree r</code> constructs an infinite tree where all nodes of the <strong><i>n</i></strong>th layer store the value <strong><i>n + r</i></strong>. We consider the root as layer <strong><i>0</i></strong>, so the root stores value <strong><i>r</i></strong>.
</li>
  <li>
  <code>interval_tree : float -> float -> (float * float) ltree</code><br>
    <code>interval_tree l0 r0</code> constructs a tree where the left and right child of every node with interval <strong><i>(l,h)</i></strong> store the intervals 
    <strong><i>( l , <sup>l+h</sup>&frasl;<sub>2</sub> )</i></strong> and <strong><i><br>
    ( <sup>l+h</sup>&frasl;<sub>2</sub> , l )</i></strong> , respectively. The root stores the interval <strong><i>(l<sub>0</sub> , r<sub>0</sub>)</i></strong> passed as the function's arguments.
  </li>
  <li><code>rational_tree : int -> int -> (int * int) ltree</code><br>
  <code>rational_tree n0 d0</code> constructs a tree with root <strong><i>(n<sub>0</sub>,d<sub>0</sub>)</i></strong> and for every node with pair <strong><i>(n,d)</i></strong>, the left child stors <strong><i>(n,d+1)</i></strong> and the right child stores <strong><i>(n+1,d)</i></strong>.
  </li>
</ol>  

### Examples:
```ocaml
# layer_tree 25;;
- : int ltree = LNode (25, <fun>, <fun>)

# layer_tree 5;;
- : int ltree = LNode (5, <fun>, <fun>)

# interval_tree 2.0 16.0;;
- : (float * float) ltree = LNode ((2., 16.), <fun>, <fun>)

# interval_tree 7.0 17.3;;
- : (float * float) ltree = LNode ((7., 17.3), <fun>, <fun>)

# rational_tree 0 8;;
- : (int * int) ltree = LNode ((0, 8), <fun>, <fun>)
# rational_tree 7 15;;
- : (int * int) ltree = LNode ((7, 15), <fun>, <fun>)
```


Implement the following functions to work with infinite trees:

<ol>
<li><code>top : int -> 'a ltree -> 'a tree</code><br>
  <code>top n t</code> returns the top <strong><i>n</i></strong> layers of the given infinite tree <strong><i>t</i></strong> as a finite binary tree.
  </li> 
  <li><code>map : ('a -> 'b) -> 'a ltree -> 'b ltree</code><br>
    <code>map f t</code> maps all elements of the tree <strong><i>t</i></strong> using the given function <strong><i>f</i></strong>.
    </li>  
  <li><code>find : ('a -> bool) -> 'a ltree -> 'a ltree</code><br>
    <code>find p t</code> returns the infinite subtree rooted at a node that satisfies the given predicate <strong><i>p</i></strong>.
    Think about how to traverse the tree in order to make sure that every node is visited eventually.
    </li>
</ol>  

### Examples:
```ocaml
# top 2 (find (fun y -> y mod 2 = 0)  (layer_tree 25));; 
- : int tree = Node (26, Node (27, Empty, Empty), Node (27, Empty, Empty))

# top 3 (map (fun x -> x * 3)  (layer_tree 1));;
- : int tree = Node (3,
Node (6, Node (9, Empty, Empty),Node (9, Empty, Empty)),
Node (6, Node (9, Empty, Empty), Node (9, Empty, Empty)))


# top 4 (find (fun y -> y > 9)  (layer_tree 1));;
- : int tree =Node (10,
 Node (11, Node (12, Node (13, Empty, Empty), Node (13, Empty, Empty)),
 Node (12, Node (13, Empty, Empty), Node (13, Empty, Empty))),
 Node (11, Node (12, Node (13, Empty, Empty), Node (13, Empty, Empty)),
 Node (12, Node (13, Empty, Empty), Node (13, Empty, Empty))))
 
 # top 4 (find (fun x -> x = (12.5,10.)) (interval_tree 10. 15.));;
- : (float * float) tree = Node ((12.5, 10.), Node ((12.5, 11.25),
 Node ((12.5, 11.875), Node ((12.5, 12.1875), Empty, Empty),
 Node ((12.1875, 12.5), Empty, Empty)),
 Node ((11.875, 12.5), Node ((11.875, 12.1875), Empty, Empty),
 Node ((12.1875, 11.875), Empty, Empty))),
 Node ((11.25, 12.5),
 Node ((11.25, 11.875), Node ((11.25, 11.5625), Empty, Empty),
 Node ((11.5625, 11.25), Empty, Empty)),
 Node ((11.875, 11.25), Node ((11.875, 11.5625), Empty, Empty),
 Node ((11.5625, 11.875), Empty, Empty))))
 ```
