Aplicación de GAP
=================

La idea de esta sección es aplicar el paquete RepnDecomp para

1. Calcular los productos tensoriales de Simples de :math:`\mathbb{S}_{3}` los cuales son :math:`(\mathbb{S}_{\epsilon}, \mathbb{S}_{sgn}, \mathbb{S}_{st})` 

2. Descomponer los productos tensoriales de simples de :math:`\mathbb{S}_{3}` en suma de simples.


Cálculo de los productos tensoriales de Simples de :math:`\mathbb{S}_{3}`
--------------------------------------------------------------------------

.. _TensorProductRepLists:

La función TensorProductRepLists
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Según la documentación oficial del paquete **RepnDecomp**, la función ``TensorProductRepLists( list1, list2 )`` devuelve todos los productos tensoriales posibles dados por :math:`\rho \otimes \tau` donde :math:`\rho : G \to \mbox{GL}(V)` se toma de ``list1`` y :math:`\tau : H \to \mbox{GL}(W)` se toma de ``list2``. El resultado es **una lista** de representaciones de :math:`G \times H`.


La aplicación de esta función sería,

1. Asignamos una variable ``G:=SymmetricGroup(3);``, el grupos :math:`\mathbb{S}_{3}`,

2. Calculamos las representaciones irreducibles de ``G`` dadas por ``irreps:=IrreducibleRepresentations(G);``, donde sabemos que ``irreps`` es una lista.

3. Asignamos una nueva variable ``TPRL:=TensorProductRepLists(irreps,irreps);;``, y por lo que dice :ref:`TensorProductRepLists`, debría ser una lista de orden :math:`3\times 3 = 9`. Esto lo verificamos usando el comando ``Size(TPRL);``.

.. code-block:: gap
    :caption: La función TensorProductRepLists

    gap> LoadPackage("RepnDecomp", "0", false);
    true
    gap> G:=SymmetricGroup(3);;
    gap> # obtenemos una lista irrep, de todas las representaciones irreducibles de S_3.
    gap> irreps:=IrreducibleRepresentations(G);;
    gap> irreps;
    [ Pcgs([ (2,3), (1,2,3) ]) -> [ [ [ 1 ] ], [ [ 1 ] ] ], Pcgs([ (2,3), (1,2,3) ]) -> [ [ [ -1 ] ], [ [ 1 ] ] ],
      Pcgs([ (2,3), (1,2,3) ]) -> [ [ [ 0, 1 ], [ 1, 0 ] ], [ [ E(3), 0 ], [ 0, E(3)^2 ] ] ] ]
    gap> # Utilizamos la funcion TensorProductRepLists(list1,list2) donde list1 = list2 = irreps
    gap> TPRL:=TensorProductRepLists(irreps,irreps);;
    # La lista TPRL tiene la tabla de los productos tensoriales que estamos buscando.
    gap> Size(TPRL);
    9
    gap> # ya sabemos el tamaño, ahora veamos su contenido
    gap> TPRL;
    [ [ (1,2,3), (1,2), (4,5,6), (4,5) ] -> [ [ [ 1 ] ], [ [ 1 ] ], [ [ 1 ] ], [ [ 1 ] ] ],
      [ (1,2,3), (1,2), (4,5,6), (4,5) ] -> [ [ [ 1 ] ], [ [ 1 ] ], [ [ 1 ] ], [ [ -1 ] ] ],
      [ (1,2,3), (1,2), (4,5,6), (4,5) ] -> [ [ [ 1, 0 ], [ 0, 1 ] ], [ [ 1, 0 ], [ 0, 1 ] ],
          [ [ E(3), 0 ], [ 0, E(3)^2 ] ], [ [ 0, E(3)^2 ], [ E(3), 0 ] ] ], [ (1,2,3), (1,2), (4,5,6), (4,5) ] ->
        [ [ [ 1 ] ], [ [ -1 ] ], [ [ 1 ] ], [ [ 1 ] ] ], [ (1,2,3), (1,2), (4,5,6), (4,5) ] ->
        [ [ [ 1 ] ], [ [ -1 ] ], [ [ 1 ] ], [ [ -1 ] ] ], [ (1,2,3), (1,2), (4,5,6), (4,5) ] ->
        [ [ [ 1, 0 ], [ 0, 1 ] ], [ [ -1, 0 ], [ 0, -1 ] ], [ [ E(3), 0 ], [ 0, E(3)^2 ] ],
          [ [ 0, E(3)^2 ], [ E(3), 0 ] ] ], [ (1,2,3), (1,2), (4,5,6), (4,5) ] -> [ [ [ E(3), 0 ], [ 0, E(3)^2 ] ],
          [ [ 0, E(3)^2 ], [ E(3), 0 ] ], [ [ 1, 0 ], [ 0, 1 ] ], [ [ 1, 0 ], [ 0, 1 ] ] ],
      [ (1,2,3), (1,2), (4,5,6), (4,5) ] -> [ [ [ E(3), 0 ], [ 0, E(3)^2 ] ], [ [ 0, E(3)^2 ], [ E(3), 0 ] ],
          [ [ 1, 0 ], [ 0, 1 ] ], [ [ -1, 0 ], [ 0, -1 ] ] ], [ (1,2,3), (1,2), (4,5,6), (4,5) ] ->
        [ [ [ E(3), 0, 0, 0 ], [ 0, E(3), 0, 0 ], [ 0, 0, E(3)^2, 0 ], [ 0, 0, 0, E(3)^2 ] ],
          [ [ 0, 0, E(3)^2, 0 ], [ 0, 0, 0, E(3)^2 ], [ E(3), 0, 0, 0 ], [ 0, E(3), 0, 0 ] ],
          [ [ E(3), 0, 0, 0 ], [ 0, E(3)^2, 0, 0 ], [ 0, 0, E(3), 0 ], [ 0, 0, 0, E(3)^2 ] ],
          [ [ 0, E(3)^2, 0, 0 ], [ E(3), 0, 0, 0 ], [ 0, 0, 0, E(3)^2 ], [ 0, 0, E(3), 0 ] ] ] ]
    gap> # Vamos a mostrar de forma manual en la que se calcula uno por uno cada de
    gap> # los productos tensoriales de la lista TPRL
    gap> TPRL11:=TensorProductRepLists([irreps[1]],[irreps[1]]);
    [ [ (1,2,3), (1,2), (4,5,6), (4,5) ] -> [ [ [ 1 ] ], [ [ 1 ] ], [ [ 1 ] ], [ [ 1 ] ] ] ]
    gap> TPRL12:=TensorProductRepLists([irreps[1]],[irreps[2]]);
    [ [ (1,2,3), (1,2), (4,5,6), (4,5) ] -> [ [ [ 1 ] ], [ [ 1 ] ], [ [ 1 ] ], [ [ -1 ] ] ] ]
    gap> TPRL13:=TensorProductRepLists([irreps[1]],[irreps[3]]);
    [ [ (1,2,3), (1,2), (4,5,6), (4,5) ] -> [ [ [ 1, 0 ], [ 0, 1 ] ], [ [ 1, 0 ], [ 0, 1 ] ],
          [ [ E(3), 0 ], [ 0, E(3)^2 ] ], [ [ 0, E(3)^2 ], [ E(3), 0 ] ] ] ]
    gap> TPRL21:=TensorProductRepLists([irreps[2]],[irreps[1]]);
    [ [ (1,2,3), (1,2), (4,5,6), (4,5) ] -> [ [ [ 1 ] ], [ [ -1 ] ], [ [ 1 ] ], [ [ 1 ] ] ] ]
    gap> TPRL22:=TensorProductRepLists([irreps[2]],[irreps[2]]);
    [ [ (1,2,3), (1,2), (4,5,6), (4,5) ] -> [ [ [ 1 ] ], [ [ -1 ] ], [ [ 1 ] ], [ [ -1 ] ] ] ]
    gap> TPRL23:=TensorProductRepLists([irreps[2]],[irreps[3]]);
    [ [ (1,2,3), (1,2), (4,5,6), (4,5) ] -> [ [ [ 1, 0 ], [ 0, 1 ] ], [ [ -1, 0 ], [ 0, -1 ] ],
          [ [ E(3), 0 ], [ 0, E(3)^2 ] ], [ [ 0, E(3)^2 ], [ E(3), 0 ] ] ] ]
    gap> TPRL31:=TensorProductRepLists([irreps[3]],[irreps[1]]);
    [ [ (1,2,3), (1,2), (4,5,6), (4,5) ] -> [ [ [ E(3), 0 ], [ 0, E(3)^2 ] ], [ [ 0, E(3)^2 ], [ E(3), 0 ] ],
          [ [ 1, 0 ], [ 0, 1 ] ], [ [ 1, 0 ], [ 0, 1 ] ] ] ]
    gap> TPRL32:=TensorProductRepLists([irreps[3]],[irreps[2]]);
    [ [ (1,2,3), (1,2), (4,5,6), (4,5) ] -> [ [ [ E(3), 0 ], [ 0, E(3)^2 ] ], [ [ 0, E(3)^2 ], [ E(3), 0 ] ],
          [ [ 1, 0 ], [ 0, 1 ] ], [ [ -1, 0 ], [ 0, -1 ] ] ] ]
    gap> TPRL33:=TensorProductRepLists([irreps[3]],[irreps[3]]);
    [ [ (1,2,3), (1,2), (4,5,6), (4,5) ] ->
        [ [ [ E(3), 0, 0, 0 ], [ 0, E(3), 0, 0 ], [ 0, 0, E(3)^2, 0 ], [ 0, 0, 0, E(3)^2 ] ],
          [ [ 0, 0, E(3)^2, 0 ], [ 0, 0, 0, E(3)^2 ], [ E(3), 0, 0, 0 ], [ 0, E(3), 0, 0 ] ],
          [ [ E(3), 0, 0, 0 ], [ 0, E(3)^2, 0, 0 ], [ 0, 0, E(3), 0 ], [ 0, 0, 0, E(3)^2 ] ],
          [ [ 0, E(3)^2, 0, 0 ], [ E(3), 0, 0, 0 ], [ 0, 0, 0, E(3)^2 ], [ 0, 0, E(3), 0 ] ] ] ]
    gap>


.. note::

    - La función ``E`` devuelve la raíz :math:`n`-ésima primitiva de la unidad :math:`e_{n} = exp(2\pi i / n)`. La ciclotómica generalmente se ingresa como sumas de raíces de unidad, con coeficientes racionales, y la ciclotómica irracional se muestra de esa manera. (Para ciclotómicas especiales, consultar 18.4. del manual de referencia de GAP).

Descompocición de los productos tensoriales de simples de :math:`\mathbb{S}_{3}` en suma de simples.
-----------------------------------------------------------------------------------------------------

.. _IrreducibleDecomposition:

La Función IrreducibleDecomposition
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Además, sabemos que la documentación oficial del paquete **RepnDecomp**, dice que la función ``IrreducibleDecomposition( rho )`` devuelve una lista de espacios vectoriales :math:`W_{j}` tales que :math:`V = \displaystyle\oplus_{j} W_{j}` y cada :math:`W_{j}` es un espacio vectorial :math:`G-\text{invariante}` irreducible.

Osea que, calcula la descomposición de :math:`V` en subpresentaciones irreducibles.

El algoritmo para aplicar esta función es muy igaul al algoritmo de :ref:`TensorProductRepLists` dado anteriormente pero con un paso más:

1. Asignamos una variable ``G:=SymmetricGroup(3);``, el grupos :math:`\mathbb{S}_{3}`,

2. Calculamos las representaciones irreducibles de ``G`` dadas por ``irreps:=IrreducibleRepresentations(G);``, donde sabemos que ``irreps`` es una lista.

3. Asignamos una nueva variable ``TPRL:=TensorProductRepLists(irreps,irreps);;``, y por lo que dice :ref:`TensorProductRepLists`, debría ser una lista de orden :math:`3\times 3 = 9`. Esto lo verificamos usando el comando ``Size(TPRL);``.

4. Para cada elemento (que viene dado por un producto tensorial :math:`\rho_{i}\otimes\tau_{j}`, :math:`i,j=1,2,3.`) de la lista ``TPRL`` aplicamos la función ``IrreducibleDecomposition(  )``.


.. code-block:: gap
    :caption: La función IrreducibleDecomposition
    :emphasize-lines: 7-13

    gap> LoadPackage("RepnDecomp", "0", false);
    true
    gap> G := SymmetricGroup( 3 );;
    gap> irreps := IrreducibleRepresentations( G );;
    gap> TPRL := TensorProductRepLists( irreps, irreps );;
    gap> # calculamos descomposición en irreducibles
    gap> for tensor_prod in TPRL do
    >     Print("----------------------------------------------------------------------------------\n");
    >     Print("DegreeOfRepresentation: ", DegreeOfRepresentation( tensor_prod ), "\n");
    >     Print("Irreducible Decomposition:\n");
    >     Print(IrreducibleDecomposition( tensor_prod ), "\n");
    >     Print("----------------------------------------------------------------------------------\n");
    > od;
    DegreeOfRepresentation: 1
    Irreducible Decomposition:
    [ rec(
          basis := [ [ 1 ] ] ) ]
    ----------------------------------------------------------------------------------
    DegreeOfRepresentation: 1
    Irreducible Decomposition:
    [ rec(
          basis := [ [ 1 ] ] ) ]
    ----------------------------------------------------------------------------------
    DegreeOfRepresentation: 2
    Irreducible Decomposition:
    [ rec(
          basis := [ [ 1, 0 ], [ 0, 1 ] ] ) ]
    ----------------------------------------------------------------------------------
    DegreeOfRepresentation: 1
    Irreducible Decomposition:
    [ rec(
          basis := [ [ 1 ] ] ) ]
    ----------------------------------------------------------------------------------
    DegreeOfRepresentation: 1
    Irreducible Decomposition:
    [ rec(
          basis := [ [ 1 ] ] ) ]
    ----------------------------------------------------------------------------------
    DegreeOfRepresentation: 2
    Irreducible Decomposition:
    [ rec(
          basis := [ [ 1, 0 ], [ 0, 1 ] ] ) ]
    ----------------------------------------------------------------------------------
    DegreeOfRepresentation: 2
    Irreducible Decomposition:
    [ rec(
          basis := [ [ 1, 0 ], [ 0, 1 ] ] ) ]
    ----------------------------------------------------------------------------------
    DegreeOfRepresentation: 2
    Irreducible Decomposition:
    [ rec(
          basis := [ [ 1, 0 ], [ 0, 1 ] ] ) ]
    ----------------------------------------------------------------------------------
    DegreeOfRepresentation: 4
    Irreducible Decomposition:
    [ rec(
          basis := [ [ 1, 0, 0, 0 ], [ 0, 0, 1, 0 ], [ 0, 1, 0, 0 ], [ 0, 0, 0, 1 ] ] ) ]
    ----------------------------------------------------------------------------------
    gap>



.. literalinclude:: ideas.g
	:language: gap
	:caption: ideas.g


.. important::

    - Descargar aquí :download:`ideas.g`