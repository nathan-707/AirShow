package org.example.mathematics.structures.algebraic;

public class Ring<T> {
    private final Group<T> additiveGroup;
    private final Monoid<T> multiplicativeMonoid;

    public Ring(Group<T> additiveGroup, Monoid<T> multiplicativeMonoid) {
        this.additiveGroup = additiveGroup;
        this.multiplicativeMonoid = multiplicativeMonoid;
    }

    public T add(T a, T b) {
        return additiveGroup.operate(a, b);
    }

    public T addInverse(T a) {
        return additiveGroup.getInverse(a);
    }

    public T multiply(T a, T b) {
        return multiplicativeMonoid.operate(a, b);
    }

    public T zero() {
        return additiveGroup.getIdentity();
    }

    public T one() {
        return multiplicativeMonoid.getIdentity();
    }

    public int getOrder() {
        return additiveGroup.getOrder();
    }

    public T getElement(int index) {
        return additiveGroup.getElement(index);
    }
}
