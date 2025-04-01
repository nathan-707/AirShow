package org.example;

import org.example.mathematics.implementations.rings.zmod.ZModNElement;
import org.example.mathematics.implementations.rings.zmod.ZModN;
import org.example.mathematics.structures.constructive.Matrix;
import org.example.mathematics.structures.constructive.Polynomial;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

public class Main {

    /**
     * Generates a block matrix whose entries are matrices of polynomials.
     *
     * @param modulus          The modulus for ZModN ring.
     * @param blockMatrixSize  The size of the outer block matrix (NxN).
     * @param smallMatrixSize  The size of the inner small matrices (MxM).
     * @param minDegree        The minimum polynomial degree.
     * @param maxDegree        The maximum polynomial degree.
     * @param rand             The random number generator.
     * @return A block matrix of matrices of polynomials over ZModN.
     */
    public static Matrix<Matrix<Polynomial<ZModNElement>>> generateBlockMatrix(
            int modulus, int blockMatrixSize, int smallMatrixSize, int minDegree, int maxDegree, Random rand) {

        ZModN ring = new ZModN(modulus);


        List<List<Matrix<Polynomial<ZModNElement>>>> blockMatrixEntries = new ArrayList<>();

        for (int i = 0; i < blockMatrixSize; i++) {
            List<Matrix<Polynomial<ZModNElement>>> row = new ArrayList<>();
            for (int j = 0; j < blockMatrixSize; j++) {
                List<List<Polynomial<ZModNElement>>> smallMatrixEntries = new ArrayList<>();

                for (int k = 0; k < smallMatrixSize; k++) {
                    List<Polynomial<ZModNElement>> smallRow = new ArrayList<>();
                    for (int m = 0; m < smallMatrixSize; m++) {
                        // Generate a polynomial with a random degree between minDegree and maxDegree
                        int degree = minDegree + rand.nextInt(maxDegree - minDegree + 1);
                        List<ZModNElement> coefficients = new ArrayList<>();

                        for (int d = 0; d <= degree; d++) {
                            coefficients.add(ring.getElement(rand.nextInt(modulus))); // Random coefficient mod N
                        }

                        smallRow.add(new Polynomial<>(coefficients));
                    }
                    smallMatrixEntries.add(smallRow);
                }

                // Construct the small matrix (MxM)
                Matrix<Polynomial<ZModNElement>> smallMatrix = new Matrix<>(smallMatrixEntries);
                row.add(smallMatrix);
            }
            blockMatrixEntries.add(row);
        }

        // Construct the block matrix (NxN)
        return new Matrix<>(blockMatrixEntries);
    }


    public static void main(String[] args) {
        int modulus = 7; // Z/7Z ring
        int blockMatrixSize = 2; // 2x2 block matrix
        int smallMatrixSize = 3; // 3x3 inner matrices
        int minDegree = 1; // Minimum polynomial degree
        int maxDegree = 3; // Maximum polynomial degree
        long seed = 42; // Fixed seed for reproducibility
        Random rand = new Random(seed);

        // Generate multiple matrices
        Matrix<Matrix<Polynomial<ZModNElement>>> blockMatrix1 = generateBlockMatrix(
                modulus,
                blockMatrixSize,
                smallMatrixSize,
                minDegree,
                maxDegree,
                rand
        );

        Matrix<Matrix<Polynomial<ZModNElement>>> blockMatrix2 = generateBlockMatrix(
                modulus,
                blockMatrixSize,
                smallMatrixSize,
                minDegree,
                maxDegree,
                rand
        );

        Matrix<Matrix<Polynomial<ZModNElement>>> blockMatrix3 = blockMatrix2.multiply(blockMatrix1);

        // Print the generated matrices
        System.out.println("Block Matrix 1:");
        System.out.println(blockMatrix1);

        System.out.println("\nBlock Matrix 2:");
        System.out.println(blockMatrix2);

        System.out.println("\nBlock Matrix 3:");
        System.out.println(blockMatrix3);

        ZModN ring = new ZModN(7);
        Polynomial<ZModNElement> p1 = new Polynomial<>(
            List.of(
                ring.getElement(1),
                ring.getElement(2),
                ring.getElement(3)
            )
        );
        Polynomial<ZModNElement> p2 = new Polynomial<>(
            List.of(
                ring.getElement(4),
                ring.getElement(5),
                ring.getElement(6)
            )
        );
        Polynomial<ZModNElement> p3 = p1.multiply(p2);
        Polynomial<ZModNElement> p4 = p1.add(p2);
        System.out.println(p1);
        System.out.println(p2);
        System.out.println(p3);
        System.out.println(p4);

        Matrix<ZModNElement> m1 = new Matrix<>(
            List.of(
                List.of(ring.getElement(1), ring.getElement(2)),
                List.of(ring.getElement(3), ring.getElement(4))
            )
        );
        Matrix<ZModNElement> m2 = new Matrix<>(
            List.of(
                List.of(ring.getElement(5), ring.getElement(6)),
                List.of(ring.getElement(1), ring.getElement(2))
            )
        );
        Matrix<ZModNElement> m3 = m1.multiply(m2);
        Matrix<ZModNElement> m4 = m1.add(m2);
        System.out.println(m1);
        System.out.println(m2);
        System.out.println(m3);
        System.out.println(m4);
    }
}
