LoadPackage("RepnDecomp", "0", false);
G := SymmetricGroup( 3 );;
irreps := IrreducibleRepresentations( G );;
TPRL := TensorProductRepLists( irreps, irreps );;
# calculamos descomposición en irreducibles
for tensor_prod in TPRL do
    Print("DegreeOfRepresentation: ", DegreeOfRepresentation( tensor_prod ), "\n");
    Print("Irreducible Decomposition:\n");
    Print(IrreducibleDecomposition( tensor_prod ), "\n");
    Print("----------------------------------------------------------------------------------\n");
od;