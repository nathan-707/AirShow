package autogradertests;

import org.example.mathematics.implementations.rings.zmod.ZModN;
import org.example.mathematics.implementations.rings.zmod.ZModNElement;
import org.example.mathematics.structures.constructive.Matrix;
import org.example.mathematics.structures.constructive.Polynomial;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.util.ArrayList;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

public class AutoGraderTests {

    @Test
    @DisplayName("Test Sample Code Snippet")
    public void sampleTest() {
        ZModN ring = new ZModN(7);
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
        assertEquals(2, m1.getNumRows());
        assertEquals(2, m1.getNumCols());
        assertEquals(2, m2.getNumRows());
        assertEquals(2, m2.getNumCols());
        assertEquals(2, m3.getNumRows());
        assertEquals(2, m3.getNumCols());
        assertEquals(2, m4.getNumRows());
        assertEquals(2, m4.getNumCols());
        // Check matrix multiplication
        for (int i = 0; i < 2; i++) {
            for (int j = 0; j < 2; j++) {
                ZModNElement expectedValue = ring.zero();
                for (int k = 0; k < 2; k++) {
                    expectedValue = expectedValue.add(m1.getElement(i, k).multiply(m2.getElement(k, j)));
                }
                assertEquals(expectedValue, m3.getElement(i, j));
            }
        }
        // Check matrix addition
        for (int i = 0; i < 2; i++) {
            for (int j = 0; j < 2; j++) {
                ZModNElement expectedValue = m1.getElement(i, j).add(m2.getElement(i, j));
                assertEquals(expectedValue, m4.getElement(i, j));
            }
        }
    }


    @Test
    @DisplayName("Test Matrix Addition & Initialization")
    public void basicTest() {
        int modValue = 13;
        ZModN zmod13 = new ZModN(modValue);
        int matrixSize = 8;
        //create a 8x8 matrix
        List<List<ZModNElement>> tmp1 = new ArrayList<>();
        List<List<ZModNElement>> tmp2 = new ArrayList<>();
        int count = 1;
        for (int i = 0; i< matrixSize; i++) {
            List<ZModNElement> row1 = new ArrayList<>();
            List<ZModNElement> row2 = new ArrayList<>();
            for (int j=0; j<matrixSize; j++) {
                row1.add(zmod13.getElement(count));
                row2.add(zmod13.getElement((modValue - count) % modValue));
                count = (count + 1) % modValue;
            }
            tmp1.add(row1);
            tmp2.add(row2);
        }
        Matrix<ZModNElement> matrix1 = new Matrix<>(tmp1);
        Matrix<ZModNElement> matrix2 = new Matrix<>(tmp2);

        Matrix<ZModNElement> result = matrix1
                .add(matrix2)
                .add(matrix1)
                .add(matrix1.one())
                .add(matrix1.zero());
        assertEquals(matrixSize, result.getNumRows());
        assertEquals(matrixSize, result.getNumCols());
         count = 1;
        for (int i = 0; i < matrixSize; i++) {
            for (int j = 0; j < matrixSize; j++) {
                ZModNElement expectedValue = zmod13.getElement(count).add(zmod13.getElement(13-count)).add(matrix1.getElement(i,j));
                if (i ==j) {
                    expectedValue = expectedValue.add(zmod13.one());
                }
                assertEquals(expectedValue, result.getElement(i, j));
                count = (count + 1) % modValue;
            }
        }
    }

    @Test
    @DisplayName("Test Matrix Multiplication")
    public void matMultTest() {
        int modValue = 13;
        ZModN zmod13 = new ZModN(modValue);
        int matrixSize = 8;
        //create a 8x8 matrix
        List<List<ZModNElement>> tmp1 = new ArrayList<>();
        List<List<ZModNElement>> tmp2 = new ArrayList<>();
        int count = 1;
        for (int i = 0; i< matrixSize; i++) {
            List<ZModNElement> row1 = new ArrayList<>();
            List<ZModNElement> row2 = new ArrayList<>();
            for (int j=0; j<matrixSize; j++) {
                row1.add(zmod13.getElement(count));
                row2.add(zmod13.getElement((modValue - count) % modValue));
                count = (count + 1) % modValue;
            }
            tmp1.add(row1);
            tmp2.add(row2);
        }
        Matrix<ZModNElement> matrix1 = new Matrix<>(tmp1);
        Matrix<ZModNElement> matrix2 = new Matrix<>(tmp2);

        Matrix<ZModNElement> result = matrix1.multiply(matrix2);
        assertEquals(matrixSize, result.getNumRows());
        assertEquals(matrixSize, result.getNumCols());
        for (int i = 0; i < matrixSize; i++) {
            for (int j = 0; j < matrixSize; j++) {
                ZModNElement expectedValue = zmod13.zero();
                for (int k = 0; k < matrixSize; k++) {
                    expectedValue = expectedValue.add(matrix1.getElement(i, k).multiply(matrix2.getElement(k, j)));
                }
                assertEquals(expectedValue, result.getElement(i, j));
            }
        }
    }

    @Test
    @DisplayName("Test Matrix With Polynomial Elements")
    public void matPolyTest() {
        int modValue = 101;
        ZModN zmodRing = new ZModN(modValue);
        int matrixSize = 20;
        int smallMatrixSize = 4;
        int minDegree = 1;
        int maxDegree = 7;
        List<List<Matrix<Polynomial<ZModNElement>>>> tmp1 = new ArrayList<>();
        List<List<Matrix<Polynomial<ZModNElement>>>> tmp2 = new ArrayList<>();
        int count = 1;
        for (int i = 0; i < matrixSize; i++) {
            List<Matrix<Polynomial<ZModNElement>>> row1 = new ArrayList<>();
            List<Matrix<Polynomial<ZModNElement>>> row2 = new ArrayList<>();
            for (int j = 0; j < matrixSize; j++) {
                List<List<Polynomial<ZModNElement>>> smallMatrixEntries1 = new ArrayList<>();
                List<List<Polynomial<ZModNElement>>> smallMatrixEntries2 = new ArrayList<>();
                for (int k = 0; k < smallMatrixSize; k++) {
                    List<Polynomial<ZModNElement>> smallRow1 = new ArrayList<>();
                    List<Polynomial<ZModNElement>> smallRow2 = new ArrayList<>();
                    for (int m = 0; m < smallMatrixSize; m++) {
                        // Generate a polynomial with a random degree between minDegree and maxDegree
                        int degree = minDegree + count % (maxDegree - minDegree + 1);
                        List<ZModNElement> coefficients = new ArrayList<>();
                        for (int d = 0; d <= degree; d++) {
                            coefficients.add(zmodRing.getElement(count));
                            count = (count + 1) % modValue;
                        }
                        smallRow1.add(new Polynomial<>(coefficients));
                        smallRow2.add(new Polynomial<>(coefficients));
                    }
                    smallMatrixEntries1.add(smallRow1);
                    smallMatrixEntries2.add(smallRow2);
                }
                // Construct the small matrix (MxM)
                Matrix<Polynomial<ZModNElement>> smallMatrix1 = new Matrix<>(smallMatrixEntries1);
                Matrix<Polynomial<ZModNElement>> smallMatrix2 = new Matrix<>(smallMatrixEntries2);

                Matrix<Polynomial<ZModNElement>> result = smallMatrix1.multiply(smallMatrix2);
                assertEquals(smallMatrixSize, result.getNumRows());
                assertEquals(smallMatrixSize, result.getNumCols());
                for (int k = 0; k < smallMatrixSize; k++) {
                    for (int m = 0; m < smallMatrixSize; m++) {
                        Polynomial<ZModNElement> expectedValue = smallMatrix1.getElement(k, m).zero();
                        for (int n = 0; n < smallMatrixSize; n++) {
                            expectedValue = expectedValue
                                    .add(smallMatrix1.getElement(k, n).multiply(smallMatrix2.getElement(n, m)));
                        }
                        for (int term = 0; term <= expectedValue.degree(); term++) {
                            assertEquals(expectedValue.coefficient(term), result.getElement(k, m).coefficient(term));
                        }
                    }
                }
            }
        }
    }

    @Test
    @DisplayName("Matrix with matrix elements whose elements are polynomials")
    public void blockTest() {
        int modValue = 101;
        ZModN zmodRing = new ZModN(modValue);
        int matrixSize = 3;
        int smallMatrixSize = 5;
        int minDegree = 1;
        int maxDegree = 3;
        List<List<Polynomial<ZModNElement>>> tmp1 = new ArrayList<>();
        List<List<Polynomial<ZModNElement>>> tmp2 = new ArrayList<>();
        int count = 1;
        for (int i = 0; i < smallMatrixSize; i++) {
            List<Polynomial<ZModNElement>> row1 = new ArrayList<>();
            List<Polynomial<ZModNElement>> row2 = new ArrayList<>();
            for (int j = 0; j < smallMatrixSize; j++) {
                // Generate a polynomial with a random degree between minDegree and maxDegree
                int degree = minDegree + count % (maxDegree - minDegree + 1);
                List<ZModNElement> coefficients = new ArrayList<>();
                for (int d = 0; d <= degree; d++) {
                    coefficients.add(zmodRing.getElement(count));
                    count = (count + 1) % modValue;
                }
                row1.add(new Polynomial<>(coefficients));
                row2.add(new Polynomial<>(coefficients));
            }
            tmp1.add(row1);
            tmp2.add(row2);
        }
        Matrix<Polynomial<ZModNElement>> matrix1 = new Matrix<>(tmp1);
        Matrix<Polynomial<ZModNElement>> matrix2 = new Matrix<>(tmp2);
        List<List<Matrix<Polynomial<ZModNElement>>>> tmp3 = new ArrayList<>();
        List<List<Matrix<Polynomial<ZModNElement>>>> tmp4 = new ArrayList<>();
        for (int i = 0; i < matrixSize; i++) {
            List<Matrix<Polynomial<ZModNElement>>> row1 = new ArrayList<>();
            List<Matrix<Polynomial<ZModNElement>>> row2 = new ArrayList<>();
            Matrix<Polynomial<ZModNElement>> random1 = matrix1;
            Matrix<Polynomial<ZModNElement>> random2 = matrix2;
            for (int k = 0; k < matrixSize; k++) {
                random1 = random1.multiply(matrix1);
                random2 = random2.multiply(matrix2);
                random1 = random2.multiply(random1);
                random2 = random1.multiply(random2.add(matrix1));
                row1.add(random1);
                row2.add(random2);
            }
            tmp3.add(row1);
            tmp4.add(row2);
        }
        Matrix<Matrix<Polynomial<ZModNElement>>> matrix3 = new Matrix<>(tmp3);
        Matrix<Matrix<Polynomial<ZModNElement>>> matrix4 = new Matrix<>(tmp4);
        Matrix<Matrix<Polynomial<ZModNElement>>> result = matrix3.multiply(matrix4);
        assertEquals(matrixSize, result.getNumRows());
        assertEquals(matrixSize, result.getNumCols());
        for (int i = 0; i < matrixSize; i++) {
            for (int j = 0; j < matrixSize; j++) {
                Matrix<Polynomial<ZModNElement>> expectedValue = matrix3.getElement(i, j).zero();
                for (int k = 0; k < matrixSize; k++) {
                    expectedValue = expectedValue.add(matrix3.getElement(i, k).multiply(matrix4.getElement(k, j)));
                }
                for (int row = 0; row < smallMatrixSize; row++) {
                    for (int col = 0; col < smallMatrixSize; col++) {
                        Polynomial<ZModNElement> expectedPoly = expectedValue.getElement(row, col);
                        Polynomial<ZModNElement> actualPoly = result.getElement(i, j).getElement(row, col);
                        for (int term = 0; term <= expectedPoly.degree(); term++) {
                            assertEquals(expectedPoly.coefficient(term), actualPoly.coefficient(term));
                        }
                    }
                }
            }
        }
    }

    @Test
    @DisplayName("Polynomials with matrices for coefficients")
    public void polyMatTest() {
        int modValue = 101;
        ZModN zmodRing = new ZModN(modValue);
        int matrixSize = 3;
        int poly1Degree = 3;
        int poly2Degree = 5;
        List<Matrix<ZModNElement>> p1Coeffs = new ArrayList<>();
        List<Matrix<ZModNElement>> p2Coeffs = new ArrayList<>();
        for (int degPoly1 = 0; degPoly1<=poly1Degree; degPoly1++) {
            List<List<ZModNElement>> tmp1 = new ArrayList<>();
            for (int i = 0; i < matrixSize; i++) {
                List<ZModNElement> row1 = new ArrayList<>();
                for (int j = 0; j < matrixSize; j++) {
                    row1.add(zmodRing.getElement(i+j));
                }
                tmp1.add(row1);
            }
            Matrix<ZModNElement> matrix1 = new Matrix<>(tmp1);
            p1Coeffs.add(matrix1);
        }
        Polynomial<Matrix<ZModNElement>> poly1 = new Polynomial<>(p1Coeffs);
        for (int degPoly2 = 0; degPoly2<=poly2Degree; degPoly2++) {
            List<List<ZModNElement>> tmp2 = new ArrayList<>();
            for (int i = 0; i < matrixSize; i++) {
                List<ZModNElement> row2 = new ArrayList<>();
                for (int j = 0; j < matrixSize; j++) {
                    row2.add(zmodRing.getElement(i*j));
                }
                tmp2.add(row2);
            }
            Matrix<ZModNElement> matrix2 = new Matrix<>(tmp2);
            p2Coeffs.add(matrix2);
        }
        Polynomial<Matrix<ZModNElement>> poly2 = new Polynomial<>(p2Coeffs);
        Polynomial<Matrix<ZModNElement>> result = poly1.multiply(poly2);
        assertEquals(poly1Degree + poly2Degree, result.degree());
        for (int term = 0; term <= result.degree(); term++) {
            Matrix<ZModNElement> expectedValue = p1Coeffs.get(0).zero();
            for (int i = 0; i <= term; i++) {
                //check if the term is within the bounds of the coefficients
                if (i >= p1Coeffs.size() || term - i >= p2Coeffs.size()) {
                    continue; //skips adding the term (equivalent to adding additive identity e.g. zero())
                }
                expectedValue = expectedValue.add(p1Coeffs.get(i).multiply(p2Coeffs.get(term - i)));
            }
            for (int row = 0; row < matrixSize; row++) {
                for (int col = 0; col < matrixSize; col++) {
                    assertEquals(expectedValue.getElement(row, col), result.coefficient(term).getElement(row, col));
                }
            }
        }
    }
}

