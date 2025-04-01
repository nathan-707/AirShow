package org.example.mathematics.implementations.rings.zmod;

import org.example.mathematics.structures.algebraic.Group;
import org.example.mathematics.structures.algebraic.Monoid;
import org.example.mathematics.structures.algebraic.Ring;

import java.util.ArrayList;
import java.util.List;
import java.util.function.BiFunction;
import java.util.function.Function;

public class ZModN extends Ring<ZModNElement> {
    private final int modulus;
    private final List<ZModNElement> elements;

    public ZModN(int modulus) {
        super(
                createAdditiveGroup(modulus), // Additive Group (Z/nZ, +)
                createMultiplicativeMonoid(modulus) // Multiplicative Monoid (Z/nZ, *)
        );

        if (modulus <= 0) {
            throw new IllegalArgumentException("Modulus must be positive.");
        }
        this.modulus = modulus;
        this.elements = new ArrayList<>();

        // Precompute elements in Z/nZ
        for (int i = 0; i < modulus; i++) {
            elements.add(new ZModNElement(i, modulus));
        }
    }

    public int getModulus() {
        return modulus;
    }

    public ZModNElement getElement(int value) {
        return elements.get((value % modulus + modulus) % modulus);
    }

    // Create the additive group (Z/nZ, +)
    private static Group<ZModNElement> createAdditiveGroup(int modulus) {
        BiFunction<ZModNElement, ZModNElement, ZModNElement> addition =
                (a, b) -> new ZModNElement(a.getValue() + b.getValue(), modulus);

        Function<ZModNElement, ZModNElement> additiveInverse =
                a -> new ZModNElement(-a.getValue(), modulus);

        List<ZModNElement> elements = new ArrayList<>();
        for (int i = 0; i < modulus; i++) {
            elements.add(new ZModNElement(i, modulus));
        }

        return new Group<>(new Monoid<>(addition, new ZModNElement(0, modulus), elements), additiveInverse);
    }

    // Create the multiplicative monoid (Z/nZ, *)
    private static Monoid<ZModNElement> createMultiplicativeMonoid(int modulus) {
        BiFunction<ZModNElement, ZModNElement, ZModNElement> multiplication =
                (a, b) -> new ZModNElement(a.getValue() * b.getValue(), modulus);

        List<ZModNElement> elements = new ArrayList<>();
        for (int i = 0; i < modulus; i++) {
            elements.add(new ZModNElement(i, modulus));
        }

        return new Monoid<>(multiplication, new ZModNElement(1, modulus), elements);
    }
}
