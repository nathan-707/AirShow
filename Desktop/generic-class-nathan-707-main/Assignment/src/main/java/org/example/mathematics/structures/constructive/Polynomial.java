package org.example.mathematics.structures.constructive;

import org.example.mathematics.structures.algebraic.RingElement;

import java.util.ArrayList;
import java.util.List;

public class Polynomial<T extends RingElement<T>> implements RingElement<Polynomial<T>> {
    private final List<T> coefficients;

    public Polynomial(List<T> coefficients) {
        this.coefficients = removeLeadingZeros(new ArrayList<>(coefficients));
        // Ensure at least one zero coefficient (so empty polynomials do not cause errors)
        if (this.coefficients.isEmpty()) {
            this.coefficients.add(coefficients.get(0).zero());
        }
    }

    private List<T> removeLeadingZeros(List<T> coeffs) {
        int lastNonZero = coeffs.size() - 1;
        while (lastNonZero >= 0 && coeffs.get(lastNonZero).equals(coeffs.get(lastNonZero).zero())) {
            lastNonZero--;
        }
        return coeffs.subList(0, lastNonZero + 1);
    }

    @Override
    public Polynomial<T> add(Polynomial<T> other) {
        int maxDegree = Math.max(this.coefficients.size(), other.coefficients.size());
        List<T> result = new ArrayList<>();

        for (int i = 0; i < maxDegree; i++) {
            T a = (i < this.coefficients.size()) ? this.coefficients.get(i) : this.zero().coefficients.get(0);
            T b = (i < other.coefficients.size()) ? other.coefficients.get(i) : other.zero().coefficients.get(0);
            result.add(a.add(b));
        }
        return new Polynomial<>(result);
    }

    @Override
    public Polynomial<T> multiply(Polynomial<T> other) {
        int newDegree = this.coefficients.size() + other.coefficients.size() - 1;
        List<T> result = new ArrayList<>();

        // Ensure the result has enough coefficients initialized to zero
        for (int i = 0; i < newDegree; i++) {
            result.add(this.coefficients.get(0).zero());
        }

        // Perform polynomial multiplication
        for (int i = 0; i < this.coefficients.size(); i++) {
            for (int j = 0; j < other.coefficients.size(); j++) {
                T term = this.coefficients.get(i).multiply(other.coefficients.get(j));
                result.set(i + j, result.get(i + j).add(term)); // Combine like terms
            }
        }

        return new Polynomial<>(result);
    }

    @Override
    public Polynomial<T> additiveInverse() {
        List<T> negCoefficients = new ArrayList<>();
        for (T coef : coefficients) {
            negCoefficients.add(coef.additiveInverse());
        }
        return new Polynomial<>(negCoefficients);
    }

    @Override
    public Polynomial<T> zero() {
        return new Polynomial<>(List.of(this.coefficients.get(0).zero())); // Ensures at least one zero element
    }

    @Override
    public Polynomial<T> one() {
        return new Polynomial<>(List.of(this.coefficients.get(0).one())); // Ensures at least one identity element
    }

    public int degree() {
        for (int i = coefficients.size() - 1; i >= 0; i--) {
            if (!coefficients.get(i).equals(coefficients.get(i).zero())) {
                return i;
            }
        }
        return 0;
    }

    public T coefficient(int degree) {
        if (degree < 0 || degree >= coefficients.size()) {
            return coefficients.get(0).zero();
        }
        return coefficients.get(degree);
    }

    @Override
    public String toString() {
        if (coefficients.isEmpty()) return "0"; // Safeguard for completely empty polynomials

        StringBuilder sb = new StringBuilder();
        boolean hasNonZero = false;

        for (int i = 0; i < coefficients.size(); i++) {
            if (!coefficients.get(i).equals(coefficients.get(i).zero())) {
                hasNonZero = true;
                if (i == 0) {
                    sb.append(coefficients.get(i)).append(" + ");
                } else {
                    sb.append(coefficients.get(i)).append("x^").append(i).append(" + ");
                }
            }
        }

        if (!hasNonZero) {
            return "0"; // Return "0" if all coefficients were zero
        }
        return sb.substring(0, sb.length() - 3); // Remove last " + "
    }

}
