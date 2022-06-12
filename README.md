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
  <code>rational_tree n0 d0</code> 
  </li>
</ol>
