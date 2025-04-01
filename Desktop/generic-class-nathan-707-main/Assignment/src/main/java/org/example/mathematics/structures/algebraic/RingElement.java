package org.example.mathematics.structures.algebraic;

public interface RingElement<T> {
    T add(T other);
    T multiply(T other);
    T additiveInverse();
    T zero();
    T one();
}
