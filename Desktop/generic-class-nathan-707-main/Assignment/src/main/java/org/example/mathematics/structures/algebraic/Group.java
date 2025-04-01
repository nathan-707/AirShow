package org.example.mathematics.structures.algebraic;

import java.util.function.Function;

public class Group<T> {
    private final Monoid<T> monoid;
    private final Function<T, T> inverse;

    public Group(Monoid<T> monoid, Function<T, T> inverse) {
        this.monoid = monoid;
        this.inverse = inverse;
    }

    public T operate(T a, T b) {
        return monoid.operate(a, b);
    }

    public T getIdentity() {
        return monoid.getIdentity();
    }

    public T getInverse(T a) {
        return inverse.apply(a);
    }

    public int getOrder() {
        return monoid.getOrder();
    }

    public T getElement(int index) {
        return monoid.getElement(index);
    }
}
