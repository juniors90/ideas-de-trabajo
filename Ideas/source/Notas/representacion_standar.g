LoadPackage("RepnDecomp", "0", false);
G := SymmetricGroup( 3 );;

# Contruimos la representación estándar.
tau := FuncToHom@RepnDecomp( G, g -> PermutationMat(g, 3) );;

# Calcula el Producto Tensorial y guarda en esta lista
TPRL33 := TensorProductRepLists( [ tau ], [ tau ] );;

# Grado de la representación dada por tau tensor tau
DegreeOfRepresentation( TPRL33[1] );

# Cuatro sumandos canónicos correspondientes a irreps triviales, dos al grado 2 y uno al grado 4 (en ese orden)
canonical_summands_GxG := CanonicalDecomposition( TPRL33[1] );

# Calcula la desomposición en irreducibles
IrreducibleDecomposition( TPRL33[1] );

# Usando los vectores base dados allí, contruimos la matriz básica más adecuada tal que
# bloque diagonaliza tau tensor tau:
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