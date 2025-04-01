package org.example.mathematics.structures.constructive;

import org.example.mathematics.structures.algebraic.RingElement;

import java.util.ArrayList;
import java.util.List;

public class Matrix<T extends RingElement<T>> implements RingElement<Matrix<T>> {
    //You should not add or alter the variables below.
    private final List<List<T>> elements;
    private final int rows, cols;

    public Matrix(List<List<T>> elements) {
        // The signature of the constructor should not be changed.
        // You need to fill in the missing code for the constructor body.
    }



    @Override
    public Matrix<T> multiply(Matrix<T> other) {
        if (this.cols != other.rows) {
            throw new IllegalArgumentException("Matrix multiplication requires matching dimensions.");
        }

        List<List<T>> result = new ArrayList<>();

        //This area needs to be filled with code to multiply matrices.
        //The result matrix should have dimensions this.rows x other.cols.
        //The element at row i and column j of the result matrix should be the dot product of the ith row of this matrix and the jth column of the other matrix.

        return new Matrix<>(result);
    }

    //do not change the additiveInverse code.  It is correct and provided to help you.
    @Override
    public Matrix<T> additiveInverse() {
        List<List<T>> result = new ArrayList<>();
        for (List<T> row : elements) {
            List<T> newRow = new ArrayList<>();
            for (T element : row) {
                newRow.add(element.additiveInverse());
            }
            result.add(newRow);
        }
        return new Matrix<>(result);
    }

    @Override
    public Matrix<T> zero() {
        List<List<T>> zeroMatrix = new ArrayList<>();
        // Fill in the code here to create a zero matrix of the same size as this matrix.
        // The zero matrix should have the same dimensions as this matrix.
        //Keep in mind that the zero matrix is the additive identity for matrices.
        //The zero matrix is a matrix where all elements are the additive identity of the ring.
        // Recall the generic definition for this class is Matrix<T extends RingElement<T>>.
        //RingElement<T> has a method zero() that returns the additive identity of the ring.
        //Use the zero() method to get the additive identity of the ring and fill the zero matrix with it.
        return new Matrix<>(zeroMatrix);
    }

    @Override
    public Matrix<T> one() {
        if (rows != cols) {
            throw new IllegalStateException("Cannot define identity matrix for non-square matrices.");
        }
        // You need to add code here to return an identity matrix of the same size as this matrix.
        // The advice for the zero() method applies here as well.
        //The only difference is that the identity matrix has 1s on the diagonal and 0s elsewhere.
        // RingElement<T> has a method one() that returns the multiplicative identity of the ring.
        //Use the one() method for entries on the diagonal and the zero() method for the other entries.
        // Use the Matrix constructor to create the identity matrix and return it.
    }


    // Do not change the toString method. It is correct and provided to help you.
    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append("[");
        for (int i = 0; i < elements.size(); i++) {
            sb.append(elements.get(i));
            if (i < elements.size() - 1) {
                sb.append(", ");
            }
        }
        sb.append("]");
        return sb.toString();
    }
}
