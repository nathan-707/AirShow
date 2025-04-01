package org.example.mathematics.structures.algebraic;

import java.util.List;
import java.util.function.BiFunction;

public class Monoid<T> {
    private final BiFunction<T, T, T> operation;
    private final T identity;
    private final List<T> elements; // Optional: Only needed for finite monoids

    public Monoid(BiFunction<T, T, T> operation, T identity, List<T> elements) {
        this.operation = operation;
        this.identity = identity;
        this.elements = elements;
    }

    public T operate(T a, T b) {
        return operation.apply(a, b);
    }

    public T getIdentity() {
        return identity;
    }

    public int getOrder() {
        return elements.size();
    }

    public T getElement(int index) {
        return elements.get(index);
    }
}
