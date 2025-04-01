package org.example.mathematics.structures.algebraic;

import java.util.List;

public class TableMagma<T> implements Magma<T> {
    private final List<T> elements;    // Finite set of elements
    private final T[][] operationTable; // algebraic table

    public TableMagma(List<T> elements, T[][] operationTable) {
        if (elements.size() != operationTable.length || elements.size() != operationTable[0].length) {
            throw new IllegalArgumentException("Operation table must match the number of elements.");
        }
        this.elements = elements;
        this.operationTable = operationTable;
    }

    @Override
    public T operate(T a, T b) {
        int indexA = elements.indexOf(a);
        int indexB = elements.indexOf(b);
        if (indexA == -1 || indexB == -1) {
            throw new IllegalArgumentException("Elements must be from the defined set.");
        }
        return operationTable[indexA][indexB];
    }

    @Override
    public int getOrder() {
        return elements.size();
    }

    @Override
    public T getElement(int index) {
        return elements.get(index);
    }
}
