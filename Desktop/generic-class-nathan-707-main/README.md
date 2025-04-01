

# Assignment

In **enterprise-level** applications, repositories are often a collection of work by people who specialize in different areas of knowledge. Large organizations may have hundreds (possibly thousands) of repositories representing different functionalities of various business units or user interfaces.

- Components that handle **ACH transactions** may have been developed by developers in the **finance department**.
- Components that handle **risk assessments** may have been developed by developers in the **actuarial department**.
- Components that **interface with hardware devices** on equipment may have been developed by **electrical engineers**.
- Components that track **user behavior** may have been developed by developers in the **marketing department**.
- Components that track **equipment maintenance** may have been developed by **external contractors**.
- etc.

All of these systems may need to communicate with each other. It is **impossible** for any **one developer** to know all aspects of an enterprise-level system, especially with components spread across the globe. **Implementing good coding practices** results in tools that **anyone can use** without having to understand the fundamentals of how they work. **Exceptionally good coding practices** result in tools that are **easily adaptable**.

In the domain of **enterprise-level development**, this **certainly implies** the use of **object-oriented approaches** that entail **generic classes**.

This assignment aims to evaluate your ability to **use generic classes**. The classes implemented in this assignment require **formal knowledge of abstract mathematical objects**. To be clear, the required mathematical knowledge **will likely be out of scope for most students**.

Fortunately, the only mathematics you need to **complete this assignment** is **basic matrix algebra**. You guessed it... **Object-Oriented Generic Classes!**

---

## Project Manager Statement

As your **Java instructor**, I need to evaluate:
1. Your ability to **implement generic classes** to represent **complex mathematical objects**.
2. Your ability to **research and learn about a domain** to effectively write associated code.

I have created a package called `mathematics` with the following **directory structure**:

```bash
mathematics
├── implementations
│   └── rings
│       └── zmod
│           ├── ZModN.java
│           └── ZModNElement.java
└── structures
    ├── algebraic
    │   ├── Group.java
    │   ├── Magma.java
    │   ├── Monoid.java
    │   ├── Ring.java
    │   ├── RingElement.java
    │   └── TableMagma.java
    └── constructive
        ├── Matrix.java
        └── Polynomial.java
```

The only file you will need to modify  is `Matrix.java`.

### **READ THE FOLLOWING BEFORE MOVING FORWARD**
- Read the **README** in the documentation about **abstract structures**.
- Read the **README** in the documentation about **constructive structures**.
- Read the **README** in the documentation about **combining structures**.

### **Key Concepts to Consider**
- A **Ring** is a **set** with **both addition and multiplication** defined.
    - Notice that **multiplying matrices and polynomials** requires **both addition and multiplication**.
    - **Matrices** whose elements are from a **ring** form **another ring**.
    - **Polynomials** whose coefficients are from a **ring** form **another ring**.
    - Engineers frequently **analyze matrices whose elements are polynomials**—those polynomials may have **coefficients from a ring**.
    - **Block matrices** are matrices whose **elements are other matrices**.
- **Depending on the application, the nesting of structures can be quite deep.**
    - Example: A **matrix composed of matrices whose entries are polynomials** with **coefficients from a ring**.
    - These **nested structures** are **very common** in **optimization problems** and **engineering applications**.

---

## Acceptance Criteria

To receive **full credit**, you must meet the following acceptance criteria:

- **Analyze** the `Polynomial.java` file and **use it as a template** to complete `Matrix.java`.
    - The **matrix implementation** should be **easier** than the polynomial implementation.
    - **Unlike polynomials**, **matrix dimensions** do **not** change once established.
- **Realize that `Matrix` is a generic class**:
    - Some methods will **return an `int`** (e.g., `getNumRows()`).
    - The **entries** in the matrix **may be other matrices, polynomials, or ring elements**.  
    - The return types of methods **must match the template argument**.
- The **only file you should modify is `Matrix.java`**.
- The **class signature has been provided—do not alter it**.
- The `toString()` method for `Matrix` **has been provided—do not alter it**.
- The signature for the constructor for the `Matrix` class should be `public Matrix(List<List<T>> elements)`
- The only class variables for the `Matrix` class should be the the following:
    - `private final List<List<T>> elements`
    - `private final int rows`
    - `private final int cols`

### Public Methods to Implement in `Matrix`
Your `Matrix` class **must** provide the following methods:

#### Basic Getters
- `getNumRows()`  
    - Returns the **number of rows** in the matrix.
- `getNumCols()`  
    - Returns the **number of columns** in the matrix.
- `getElement(int row, int col)`
    - Returns the element at **row** and **column** (0-based index). Keep in mind the type could be a another matrix, polynomial, or ring element.  Rely on the generic parameter.

#### Mathematical Operations
- `one()`
    - Returns the **identity matrix** (only defined for **square matrices**).
    - If the **matrix is not square**, throw an error:  
      ```java
      throw new IllegalStateException("Cannot define identity matrix for non-square matrices.");
      ```
    - The **identity matrix** for **real numbers** has `1`s along the **main diagonal** and `0`s elsewhere.
    - Since `Matrix<T>` is generic, use the `.one()` and `.zero()` methods from **RingElement**.
- `zero()`
    - Returns the **zero matrix** (all entries are `0` elements from the ring). Keep in mind the element may be a matrix, polynomial, or ring element.  You should rely on the `zero()` method provided by the ringelements. 
- `additiveInverse()`
    - Returns the **additive inverse** (negates all elements in the matrix).
    - Since `T` is a **RingElement**, use `.additiveInverse()` for each entry.

#### Important Notes
- The methods `one()`, `zero()`, and `additiveInverse()` **must be implemented**, just like **RingElements**.
- The above is important because a **matrix of ring elements** is itself a **ring element** for a **higher-level ring**.

### Testing and Grading
- The file **`main_output.txt`** provides an **example of expected output** from the `Main` class.
- **Autograding functions will generate dynamic test cases**.  
    - **Do not** attempt to **hard-code solutions**—your code **must generalize** correctly.

---

## **Grading Criteria**

This assignment is worth **100 points**. Below is the **grading breakdown**:

| Task | Points |
|------|--------|
| Accepting the assignment | 10 pts |
| First commit to the repository | 20 pts |
| Passing **all unit tests** on GitHub Workflow Autograder | 70 pts |
| **Total Points Possible** | **100 pts** |

**No partial credit will be awarded in each category.**  
This means:

- **0 points** → Assignment **not accepted**.
- **10 points** → Assignment **accepted**, but **no commits**.
- **30 points** → Assignment **accepted**, and **at least one commit** was made.
- **100 points** → Assignment **fully completed**, all **unit tests passed** (GitHub Actions green checkmark ✅).

---

```
