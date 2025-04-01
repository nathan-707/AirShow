package org.example.mathematics.implementations.rings.zmod;

import org.example.mathematics.structures.algebraic.RingElement;

public class ZModNElement implements RingElement<ZModNElement> {
    private final int value;
    private final int modulus;

    public ZModNElement(int value, int modulus) {
        if (modulus <= 0) {
            throw new IllegalArgumentException("Modulus must be positive.");
        }
        this.value = (value % modulus + modulus) % modulus; // Ensure non-negative representation
        this.modulus = modulus;
    }

    @Override
    public ZModNElement add(ZModNElement other) {
        if (this.modulus != other.modulus) {
            throw new IllegalArgumentException("Moduli must match.");
        }
        return new ZModNElement(this.value + other.value, modulus);
    }

    @Override
    public ZModNElement multiply(ZModNElement other) {
        if (this.modulus != other.modulus) {
            throw new IllegalArgumentException("Moduli must match.");
        }
        return new ZModNElement(this.value * other.value, modulus);
    }

    @Override
    public ZModNElement additiveInverse() {
        return new ZModNElement(-this.value, modulus);
    }

    @Override
    public ZModNElement zero() {
        return new ZModNElement(0, modulus);
    }

    @Override
    public ZModNElement one() {
        return new ZModNElement(1, modulus);
    }

    public int getValue() {
        return value;
    }

    @Override
    public String toString() {
        return Integer.toString(value); // Display only the value without "mod n"
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        if (obj instanceof ZModNElement other) {
            return this.value == other.value && this.modulus == other.modulus;
        }
        return false;
    }

    @Override
    public int hashCode() {
        return Integer.hashCode(value) ^ Integer.hashCode(modulus);
    }
}
