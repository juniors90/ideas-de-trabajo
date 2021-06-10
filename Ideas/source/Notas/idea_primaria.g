LoadPackage("RepnDecomp", "0", false);
G := SymmetricGroup( 3 );;

# Contruimos manualmente la representación estándar.
tau := FuncToHom@RepnDecomp( G, g -> PermutationMat(g, 3) );;
DegreeOfRepresentation( tau );

# Dos sumandos canónicos correspondientes al grado 2 e irreps triviales (en ese orden)
canonical_summands_G := CanonicalDecomposition(tau);

# Los espacios se devuelven en este formato, manteniendo explícitamente la base, ya que este bloque base
# diagonaliza tau en los irreps, que son los bloques más pequeños posibles.
irred_decomp_G := IrreducibleDecomposition(tau);

# ----------------------------------------------------------------------------------------------- #
# Ahora trabajamos con el producto tensorial de la representación standar dado por tau tensor tau #
# ----------------------------------------------------------------------------------------------- #

# Calcula el Producto Tensorial y guarda en esta lista
TPRL33 := TensorProductRepLists( [ tau ], [ tau ] );;
DegreeOfRepresentation( TPRL33[1] );

# Cuatro sumandos canónicos correspondientes a irreps triviales, dos al grado 2 y uno al grado 4 (en ese orden)
canonical_summands_GxG := CanonicalDecomposition( TPRL33[1] );

# Calcula la representacion irreducible
IrreducibleDecomposition( TPRL33[1] );

# Usando los vectores base dados allí, contruimos la base que bloque diagonaliza tau tensor tau:
nice_basis := [ [ 1, 1, 1, 1, 1, 1, 1, 1, 1 ],
                [ 1, E(3), E(3)^2, 1, E(3), E(3)^2, 1, E(3), E(3)^2 ],
                [ 1, E(3)^2, E(3), 1, E(3)^2, E(3), 1, E(3)^2, E(3) ],
                [ 1, 1, 1, E(3), E(3), E(3), E(3)^2, E(3)^2, E(3)^2 ],
                [ 1, 1, 1, E(3)^2, E(3)^2, E(3)^2, E(3), E(3), E(3) ],
                [ 1, E(3), E(3)^2, E(3), E(3)^2, 1, E(3)^2, 1, E(3) ],
                [ 1, E(3), E(3)^2, E(3)^2, 1, E(3), E(3), E(3)^2, 1 ],
                [ 1, E(3)^2, E(3), E(3), 1, E(3)^2, E(3)^2, E(3), 1 ],
                [ 1, E(3)^2, E(3), E(3)^2, E(3), 1, E(3), 1, E(3)^2 ] ];

tau_tensor_tau_diag_G := ComposeHomFunction( TPRL33[1], X -> nice_basis^-1 * X * nice_basis);


# Todo esto se puede hacer en un sólo paso:
REPN_ComputeUsingSerre( TPRL33[1] );