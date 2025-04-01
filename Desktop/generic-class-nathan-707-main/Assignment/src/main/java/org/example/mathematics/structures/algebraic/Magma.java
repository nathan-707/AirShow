package org.example.mathematics.structures.algebraic;

public interface Magma<T> {
    T operate(T a, T b);
    int getOrder(); // Returns the number of elements in the magma
    T getElement(int index); // Returns an element by index
}
