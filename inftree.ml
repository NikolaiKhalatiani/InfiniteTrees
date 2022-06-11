type 'a tree = Empty | Node of 'a * 'a tree * 'a tree

type 'a ltree = LNode of 'a * (unit -> 'a ltree) * (unit -> 'a ltree)

let rec layer_tree r = LNode(r, (fun()->layer_tree (r+1)), (fun()->layer_tree (r+1)))

let rec interval_tree l h = LNode((l,h), (fun ()->interval_tree l ((l +. h) /. 2.0) ),(fun ()->interval_tree ((l+.h) /. 2.0 ) l))

let rec rational_tree n d = LNode((n,d),(fun ()->rational_tree n (d+1)),(fun ()->rational_tree (n+1) d))

let rec top n (LNode(v,fun_l,fun_r)) = if n > 0 then Node(v,top (n-1) (fun_l ()),top (n-1) (fun_r ())) else Empty

let rec map f (LNode(v,fun_l,fun_r)) = LNode(f v,(fun ()->map f (fun_l ())),(fun ()->map f (fun_r ())))

let find p (LNode(v, fun_l, fun_r))  = if p v then LNode(v, fun_l, fun_r) else
let exception Failure of string in let rec helper p queue = match queue with 
|LNode(v, fun_l, fun_r)::rest ->if p v then LNode(v, fun_l, fun_r) else helper p  (rest@[fun_l (); fun_r ()])
|[]->raise(Failure "No Infinite tree provided")  in helper p [fun_l (); fun_r ()]
