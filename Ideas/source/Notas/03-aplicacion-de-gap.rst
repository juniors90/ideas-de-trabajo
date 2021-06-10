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

Descomposición de los productos tensoriales de simples de :math:`\mathbb{S}_{3}` en suma de simples.
-----------------------------------------------------------------------------------------------------

.. _IrreducibleDecomposition:

La Función IrreducibleDecomposition
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Además, sabemos que la documentación oficial del paquete **RepnDecomp**, dice que la función ``IrreducibleDecomposition( rho )`` devuelve una lista de espacios vectoriales :math:`W_{j}` tales que :math:`V = \displaystyle\oplus_{j} W_{j}` y cada :math:`W_{j}` es un espacio vectorial :math:`G-\text{invariante}` irreducible.

Osea que, calcula la descomposición de :math:`V` en subpresentaciones irreducibles.

El algoritmo para aplicar esta función es igual al algoritmo de :ref:`TensorProductRepLists` dado anteriormente pero con un paso más:

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


El productos tensorial de la representación standar de :math:`\mathbb{S}_{3}`  :math:`(\mathbb{S}_{st} \otimes \mathbb{S}_{st})`
----------------------------------------------------------------------------------------------------------------------------------

Hasta el momento no queda claro lo que expresa la base que podemos observar en el último registro que arroja el ciclo ``for``.

.. code-block:: gap
    :caption: La función IrreducibleDecomposition
    :emphasize-lines: 9-11

    gap> LoadPackage("RepnDecomp", "0", false);
    true
    gap> G := SymmetricGroup( 3 );;
    ...
    resto del código
    ...
    ----------------------------------------------------------------------------------
    DegreeOfRepresentation: 4
    Irreducible Decomposition:
    [ rec(
          basis := [ [ 1, 0, 0, 0 ], [ 0, 0, 1, 0 ], [ 0, 1, 0, 0 ], [ 0, 0, 0, 1 ] ] ) ]
    ----------------------------------------------------------------------------------
    gap>


Lo ideal sería que expresara el hecho de que:

.. math::

    \mathbb{S}_{st} \otimes \mathbb{S}_{st} = \mathbb{S}_{\epsilon}\oplus \mathbb{S}_{sgn}\oplus \mathbb{S}_{st} 

en nuestro código anterior sería la ``TPRL33[1]``.

**Para intentar solucionar esta situación, vamos a usar un algoritmo distinto.**

1. Asignar a una variable ``G``, el grupo ``G := SymmetricGroup( 3 );;``.

2. Contruimos la representación estándar: ``tau := FuncToHom@RepnDecomp( G, g -> PermutationMat(g, 3) );;``, tal y como indica la documentación oficial de **RepnDecomp**.

3. Asignamos una nueva variable ``TPRL33:=TensorProductRepLists( [ tau ], [ tau ] );;``, y por lo que dice :ref:`TensorProductRepLists`, debría ser una lista de orden :math:`1`, conteniendo solamente a :math:`\mathbb{S}_{st} \otimes \mathbb{S}_{st}`. Esto lo verificamos usando el comando ``Size(TPRL33);``.

4. Para el único elemento de la lista anterior, ``TPRL33[1]``, aplicamos la función ``IrreducibleDecomposition( TPRL33[1] )``. Esto nos debería dar lo que estamos buscando.


.. _ComposeHomFunction:

La función ComposeHomFunction
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

De la documentación de **RepnDecomp**, sabemos que l a función ``ComposeHomFunction( hom, func)`` devuelve un homomorfismo :math:`g` dado por :math:`g(x) = func(hom(x))`.

Esto es principalmente por conveniencia.

Con esta información, podemos seguir agregando pasos a nuestro algoritimo para un mejor estudio.

5. Usando los vectores base dados allí, contruimos la matriz básica ``nice_basis`` más adecuada tal que bloque diagonaliza :math:`\mathbb{S}_{st} \otimes \mathbb{S}_{st}`.

6. Aplicamos :ref:`ComposeHomFunction`.

.. _REPN_ComputeUsingSerre:

La función REPN_ComputeUsingSerre
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

El atributo ``REPN_ComputeUsingSerre( rho )`` devuelve un ``registro`` o ``record`` en el formato que se describe a continuación.

Para más información, ver la documentación de **RepnDecomp**.

El valor de retorno de esta función es un registro con campos:

    - ``basis``: La base que bloque diagonaliza :math:`\tau`. Más adelante veremos que coincide con ``nice_basis``, la construcción del *ítem 5*.

    - ``diagonal_rep``: :math:`\tau`, bloque diagonalizado con la base anterior.

    - ``decomposition``: Los subespacios :math:`G-\text{invariables irreductibles}`, recopilados según el isomorfismo. **Esta es la parte más interesante**, porque debería coincidir con lo que arroje ``IrreducibleDecomposition( tau );``.

    - ``centralizer_basis``: Una base ortonormal para el anillo centralizador de :math:`\tau`, escrito en forma de bloque.

Ahora bien, agregamos un último paso que calcule de manera simple e inmediata lo hecho hasta ahora:

7. Aplicamos :ref:`REPN_ComputeUsingSerre`, cuyo argumento será  ``TPRL33[1]`` (o sea, :math:`\mathbb{S}_{st} \otimes \mathbb{S}_{st}`).

.. code-block:: gap
    :caption: La función IrreducibleDecomposition
	:linenos:


    gap> LoadPackage("RepnDecomp", "0", false);
    true
    gap> G := SymmetricGroup( 3 );;
    gap> # Contruimos manualmente la representación estándar.
    gap> tau := FuncToHom@RepnDecomp( G, g -> PermutationMat(g, 3) );;
    gap> # ----------------------------------------------------------------------------------------------- #
    gap> # Ahora trabajamos con el producto tensorial de la representación standar dado por tau tensor tau #
    gap> # ----------------------------------------------------------------------------------------------- #
    gap> # Calcula el Producto Tensorial y guarda en esta lista
    gap> TPRL33 := TensorProductRepLists( [ tau ], [ tau ] );;
    gap> DegreeOfRepresentation( TPRL33[1] );
    9
    gap> # Cuatro sumandos canónicos correspondientes a irreps triviales, dos al grado 2 y uno al grado 4 (en ese orden)
    gap> canonical_summands_GxG := CanonicalDecomposition( TPRL33[1] );
    [ <vector space over Cyclotomics, with 1 generators>, <vector space over Cyclotomics, with 2 generators>,
      <vector space over Cyclotomics, with 2 generators>, <vector space over Cyclotomics, with 4 generators> ]
    gap> # Calcula la representacion irreducible
    gap> IrreducibleDecomposition( TPRL33[1] );
    [ rec( basis := [ [ 1, 1, 1, 1, 1, 1, 1, 1, 1 ] ] ),
      rec( basis := [ [ 1, E(3), E(3)^2, 1, E(3), E(3)^2, 1, E(3), E(3)^2 ],
              [ 1, E(3)^2, E(3), 1, E(3)^2, E(3), 1, E(3)^2, E(3) ] ] ),
      rec( basis := [ [ 1, 1, 1, E(3), E(3), E(3), E(3)^2, E(3)^2, E(3)^2 ],
              [ 1, 1, 1, E(3)^2, E(3)^2, E(3)^2, E(3), E(3), E(3) ] ] ),
      rec( basis := [ [ 1, E(3), E(3)^2, E(3), E(3)^2, 1, E(3)^2, 1, E(3) ],
              [ 1, E(3), E(3)^2, E(3)^2, 1, E(3), E(3), E(3)^2, 1 ], [ 1, E(3)^2, E(3), E(3), 1, E(3)^2, E(3)^2, E(3), 1 ]
                , [ 1, E(3)^2, E(3), E(3)^2, E(3), 1, E(3), 1, E(3)^2 ] ] ) ]
    gap> # Usando los vectores base dados allí, contruimos la matriz básica más adecuada tal que
	gap> # bloque diagonaliza tau tensor tau:
    gap> nice_basis := [ [ 1, 1, 1, 1, 1, 1, 1, 1, 1 ],
    >                 [ 1, E(3), E(3)^2, 1, E(3), E(3)^2, 1, E(3), E(3)^2 ],
    >                 [ 1, E(3)^2, E(3), 1, E(3)^2, E(3), 1, E(3)^2, E(3) ],
    >                 [ 1, 1, 1, E(3), E(3), E(3), E(3)^2, E(3)^2, E(3)^2 ],
    >                 [ 1, 1, 1, E(3)^2, E(3)^2, E(3)^2, E(3), E(3), E(3) ],
    >                 [ 1, E(3), E(3)^2, E(3), E(3)^2, 1, E(3)^2, 1, E(3) ],
    >                 [ 1, E(3), E(3)^2, E(3)^2, 1, E(3), E(3), E(3)^2, 1 ],
    >                 [ 1, E(3)^2, E(3), E(3), 1, E(3)^2, E(3)^2, E(3), 1 ],
    >                 [ 1, E(3)^2, E(3), E(3)^2, E(3), 1, E(3), 1, E(3)^2 ] ];
    [ [ 1, 1, 1, 1, 1, 1, 1, 1, 1 ], [ 1, E(3), E(3)^2, 1, E(3), E(3)^2, 1, E(3), E(3)^2 ],
      [ 1, E(3)^2, E(3), 1, E(3)^2, E(3), 1, E(3)^2, E(3) ], [ 1, 1, 1, E(3), E(3), E(3), E(3)^2, E(3)^2, E(3)^2 ],
      [ 1, 1, 1, E(3)^2, E(3)^2, E(3)^2, E(3), E(3), E(3) ], [ 1, E(3), E(3)^2, E(3), E(3)^2, 1, E(3)^2, 1, E(3) ],
      [ 1, E(3), E(3)^2, E(3)^2, 1, E(3), E(3), E(3)^2, 1 ], [ 1, E(3)^2, E(3), E(3), 1, E(3)^2, E(3)^2, E(3), 1 ],
      [ 1, E(3)^2, E(3), E(3)^2, E(3), 1, E(3), 1, E(3)^2 ] ]
    gap> tau_tensor_tau_diag_G := ComposeHomFunction( TPRL33[1], X -> nice_basis^-1 * X * nice_basis);
    [ (1,2,3), (1,2), (4,5,6), (4,5) ] ->
    [
      [ [ 1, 0, 0, 0, 0, 0, 0, 0, 0 ], [ 0, 1/3*E(3)^2, -1/3*E(3), 2/3*E(3)+1/3*E(3)^2, 1/3, -1/3, 0, 1/3*E(3)^2,
              -1/3*E(3) ], [ 0, -1/3*E(3)^2, 1/3*E(3), 0, -1/3*E(3)^2, 1/3*E(3), 1/3*E(3)+2/3*E(3)^2, -1/3, 1/3 ],
          [ 0, -1/3*E(3)-2/3*E(3)^2, 0, 2/3*E(3)+1/3*E(3)^2, 0, 0, 0, 0, 2/3*E(3)+1/3*E(3)^2 ],
          [ 0, 1/3, -1/3*E(3), 0, 1/3*E(3), -1/3*E(3)^2, -2/3*E(3)-1/3*E(3)^2, 1/3*E(3), -1/3*E(3) ],
          [ 0, -1/3*E(3), 1/3*E(3), 0, -1/3, 1/3, 0, 2/3*E(3)^2, 1/3*E(3)^2 ],
          [ 0, 0, -2/3*E(3)-1/3*E(3)^2, 0, 1/3*E(3)+2/3*E(3)^2, 0, 1/3*E(3)+2/3*E(3)^2, 0, 0 ],
          [ 0, 1/3*E(3)^2, -1/3*E(3)^2, 0, 1/3*E(3), 2/3*E(3), 0, 1/3, -1/3 ],
          [ 0, -1/3*E(3)^2, 1/3, -1/3*E(3)-2/3*E(3)^2, -1/3*E(3)^2, 1/3*E(3)^2, 0, -1/3*E(3), 1/3*E(3)^2 ] ],
      [ [ 1, 0, 0, 0, 0, 0, 0, 0, 0 ], [ 0, 1/3, -1/3*E(3), 0, 1/3*E(3), -1/3*E(3)^2, -2/3*E(3)-1/3*E(3)^2, 1/3*E(3),
              -1/3*E(3) ], [ 0, -1/3*E(3)^2, 1/3, -1/3*E(3)-2/3*E(3)^2, -1/3*E(3)^2, 1/3*E(3)^2, 0, -1/3*E(3), 1/3*E(3)^2
             ], [ 0, 0, -2/3*E(3)-1/3*E(3)^2, 0, 1/3*E(3)+2/3*E(3)^2, 0, 1/3*E(3)+2/3*E(3)^2, 0, 0 ],
          [ 0, 1/3*E(3)^2, -1/3*E(3), 2/3*E(3)+1/3*E(3)^2, 1/3, -1/3, 0, 1/3*E(3)^2, -1/3*E(3) ],
          [ 0, -1/3*E(3), 1/3*E(3), 0, -1/3, 1/3, 0, 2/3*E(3)^2, 1/3*E(3)^2 ],
          [ 0, -1/3*E(3)-2/3*E(3)^2, 0, 2/3*E(3)+1/3*E(3)^2, 0, 0, 0, 0, 2/3*E(3)+1/3*E(3)^2 ],
          [ 0, 1/3*E(3)^2, -1/3*E(3)^2, 0, 1/3*E(3), 2/3*E(3), 0, 1/3, -1/3 ],
          [ 0, -1/3*E(3)^2, 1/3*E(3), 0, -1/3*E(3)^2, 1/3*E(3), 1/3*E(3)+2/3*E(3)^2, -1/3, 1/3 ] ],
      [ [ 1, 0, 0, 0, 0, 0, 0, 0, 0 ], [ 0, 1/3*E(3), -1/3*E(3), 1/3, -1/3, 0, -1/3, 1/3*E(3)-1/3*E(3)^2, 1/3*E(3) ],
          [ 0, -1/3*E(3)^2, 1/3*E(3)^2, -1/3, 1/3*E(3)^2, -1/3*E(3)+1/3*E(3)^2, 1/3, 0, -1/3 ],
          [ 0, 1/3*E(3)^2, -1/3*E(3), 1/3, -1/3*E(3)^2, 0, 2/3, 0, 1/3*E(3) ],
          [ 0, -1/3, 1/3*E(3), -1/3, 1/3*E(3), 0, 1/3, 1/3*E(3)-1/3*E(3)^2, -1/3*E(3) ],
          [ 0, 0, -1/3*E(3)+1/3*E(3)^2, 0, 0, 2/3*E(3)+1/3*E(3)^2, 0, 0, -1/3*E(3)+1/3*E(3)^2 ],
          [ 0, -1/3*E(3)^2, 1/3*E(3), 2/3, 1/3*E(3)^2, 0, 1/3, 0, -1/3*E(3) ],
          [ 0, 1/3*E(3)-1/3*E(3)^2, 0, 0, 1/3*E(3)-1/3*E(3)^2, 0, 0, 1/3*E(3)+2/3*E(3)^2, 0 ],
          [ 0, 1/3*E(3)^2, -1/3, 1/3, -1/3*E(3)^2, -1/3*E(3)+1/3*E(3)^2, -1/3, 0, 1/3*E(3)^2 ] ],
      [ [ 1, 0, 0, 0, 0, 0, 0, 0, 0 ], [ 0, 1/3, -1/3*E(3), 1/3, -1/3, 1/3*E(3)+2/3*E(3)^2, -1/3, 0, 1/3*E(3)^2 ],
          [ 0, -1/3*E(3)^2, 1/3, -1/3, 1/3*E(3), 0, 1/3, 2/3*E(3)+1/3*E(3)^2, -1/3 ],
          [ 0, 1/3, -1/3, 1/3, -1/3, 0, 2/3, 0, 1/3 ],
          [ 0, -1/3, 1/3*E(3)^2, -1/3, 1/3, 1/3*E(3)+2/3*E(3)^2, 1/3, 0, -1/3*E(3) ],
          [ 0, 2/3*E(3)+1/3*E(3)^2, 0, 0, 2/3*E(3)+1/3*E(3)^2, 0, 0, -1/3*E(3)-2/3*E(3)^2, 0 ],
          [ 0, -1/3, 1/3, 2/3, 1/3, 0, 1/3, 0, -1/3 ],
          [ 0, 0, 1/3*E(3)+2/3*E(3)^2, 0, 0, -2/3*E(3)-1/3*E(3)^2, 0, 0, 1/3*E(3)+2/3*E(3)^2 ],
          [ 0, 1/3*E(3), -1/3, 1/3, -1/3*E(3)^2, 0, -1/3, 2/3*E(3)+1/3*E(3)^2, 1/3 ] ] ]
    gap> # Todo esto se puede hacer en un sólo paso:
    gap> REPN_ComputeUsingSerre( TPRL33[1] );
    rec( basis := [ [ 1, 1, 1, 1, 1, 1, 1, 1, 1 ], [ 1, E(3), E(3)^2, 1, E(3), E(3)^2, 1, E(3), E(3)^2 ],
          [ 1, E(3)^2, E(3), 1, E(3)^2, E(3), 1, E(3)^2, E(3) ], [ 1, 1, 1, E(3), E(3), E(3), E(3)^2, E(3)^2, E(3)^2 ],
          [ 1, 1, 1, E(3)^2, E(3)^2, E(3)^2, E(3), E(3), E(3) ], [ 1, E(3), E(3)^2, E(3), E(3)^2, 1, E(3)^2, 1, E(3) ],
          [ 1, E(3), E(3)^2, E(3)^2, 1, E(3), E(3), E(3)^2, 1 ], [ 1, E(3)^2, E(3), E(3), 1, E(3)^2, E(3)^2, E(3), 1 ],
          [ 1, E(3)^2, E(3), E(3)^2, E(3), 1, E(3), 1, E(3)^2 ] ],
      centralizer_basis :=
        [
          [ [ [ 1 ] ], [ [ 0, 0 ], [ 0, 0 ] ], [ [ 0, 0 ], [ 0, 0 ] ],
              [ [ 0, 0, 0, 0 ], [ 0, 0, 0, 0 ], [ 0, 0, 0, 0 ], [ 0, 0, 0, 0 ] ] ],
              [ [ [ 0 ] ], [ [ 1, 0 ], [ 0, 1 ] ], [ [ 0, 0 ], [ 0, 0 ] ],
              [ [ 0, 0, 0, 0 ], [ 0, 0, 0, 0 ], [ 0, 0, 0, 0 ], [ 0, 0, 0, 0 ] ] ],
          [ [ [ 0 ] ], [ [ 0, 0 ], [ 0, 0 ] ], [ [ 1, 0 ], [ 0, 1 ] ],
              [ [ 0, 0, 0, 0 ], [ 0, 0, 0, 0 ], [ 0, 0, 0, 0 ], [ 0, 0, 0, 0 ] ] ],
          [ [ [ 0 ] ], [ [ 0, 0 ], [ 0, 0 ] ], [ [ 0, 0 ], [ 0, 0 ] ],
              [ [ 1, 0, 0, 0 ], [ 0, 1, 0, 0 ], [ 0, 0, 1, 0 ], [ 0, 0, 0, 1 ] ] ] ],
      decomposition := [ [ rec( basis := [ [ 1, 1, 1, 1, 1, 1, 1, 1, 1 ] ] ) ], [  ], [  ], [  ],
          [
              rec( basis := [ [ 1, E(3), E(3)^2, 1, E(3), E(3)^2, 1, E(3), E(3)^2 ],
                      [ 1, E(3)^2, E(3), 1, E(3)^2, E(3), 1, E(3)^2, E(3) ] ] ) ], [  ],
          [
              rec( basis := [ [ 1, 1, 1, E(3), E(3), E(3), E(3)^2, E(3)^2, E(3)^2 ],
                      [ 1, 1, 1, E(3)^2, E(3)^2, E(3)^2, E(3), E(3), E(3) ] ] ) ], [  ],
          [
              rec( basis := [ [ 1, E(3), E(3)^2, E(3), E(3)^2, 1, E(3)^2, 1, E(3) ],
                      [ 1, E(3), E(3)^2, E(3)^2, 1, E(3), E(3), E(3)^2, 1 ],
                      [ 1, E(3)^2, E(3), E(3), 1, E(3)^2, E(3)^2, E(3), 1 ],
                      [ 1, E(3)^2, E(3), E(3)^2, E(3), 1, E(3), 1, E(3)^2 ] ] ) ] ],
      diagonal_rep := [ (1,2,3), (1,2), (4,5,6), (4,5) ] ->
        [ [ [ 1, 0, 0, 0, 0, 0, 0, 0, 0 ], [ 0, 1, 0, 0, 0, 0, 0, 0, 0 ], [ 0, 0, 1, 0, 0, 0, 0, 0, 0 ],
              [ 0, 0, 0, E(3), 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, E(3)^2, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, E(3), 0, 0, 0 ],
              [ 0, 0, 0, 0, 0, 0, E(3)^2, 0, 0 ], [ 0, 0, 0, 0, 0, 0, 0, E(3), 0 ], [ 0, 0, 0, 0, 0, 0, 0, 0, E(3)^2 ] ],
          [ [ 1, 0, 0, 0, 0, 0, 0, 0, 0 ], [ 0, 1, 0, 0, 0, 0, 0, 0, 0 ], [ 0, 0, 1, 0, 0, 0, 0, 0, 0 ],
              [ 0, 0, 0, 0, E(3)^2, 0, 0, 0, 0 ], [ 0, 0, 0, E(3), 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0, E(3)^2, 0, 0 ],
              [ 0, 0, 0, 0, 0, E(3), 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0, 0, 0, E(3)^2 ], [ 0, 0, 0, 0, 0, 0, 0, E(3), 0 ] ],
          [ [ 1, 0, 0, 0, 0, 0, 0, 0, 0 ], [ 0, E(3), 0, 0, 0, 0, 0, 0, 0 ], [ 0, 0, E(3)^2, 0, 0, 0, 0, 0, 0 ],
              [ 0, 0, 0, 1, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 1, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, E(3), 0, 0, 0 ],
              [ 0, 0, 0, 0, 0, 0, E(3), 0, 0 ], [ 0, 0, 0, 0, 0, 0, 0, E(3)^2, 0 ], [ 0, 0, 0, 0, 0, 0, 0, 0, E(3)^2 ] ],
          [ [ 1, 0, 0, 0, 0, 0, 0, 0, 0 ], [ 0, 0, E(3)^2, 0, 0, 0, 0, 0, 0 ], [ 0, E(3), 0, 0, 0, 0, 0, 0, 0 ],
              [ 0, 0, 0, 1, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 1, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0, 0, E(3)^2, 0 ],
              [ 0, 0, 0, 0, 0, 0, 0, 0, E(3)^2 ], [ 0, 0, 0, 0, 0, E(3), 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0, E(3), 0, 0 ] ] ] )
    gap>


.. literalinclude:: representacion_standar.g
	:language: gap
	:caption: representacion_standar.g


.. important::

    - Descargar aquí :download:`representacion_standar.g`