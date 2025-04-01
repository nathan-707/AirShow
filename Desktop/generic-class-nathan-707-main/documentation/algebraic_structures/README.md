# Algebraic Structures in Finite Sets

## Introduction
There are **four algebraic structures**: **Magmas, Monoids, Groups, and Rings**. Each of these structures follows certain mathematical rules that define how numbers or objects interact under **binary operations** (left and right operands - like addition or multiplication).

We will only consider **finite sets**, meaning we only consider a **fixed number of elements** rather than infinite collections like real numbers.

---

## 1. Magma
A **magma** is the simplest structure. It consists of:
- A **set** of elements.
- A **binary operation** that combines two elements of the set to produce another element in the set.

### Example: Magma in ℤ/5ℤ (Integers Modulo 5)
Let’s consider the set `{0, 1, 2, 3, 4}` and the operation **addition mod 5**:
- **2 + 3 = 0** (since 5 mod 5 is 0)
- **1 + 4 = 0**  
- **4 + 4 = 3**  

✔ **Closure**: The result of adding two elements always stays in `{0, 1, 2, 3, 4}`.  
❌ **No Identity**: There is no requirement for an identity element in a magma.

---

## 2. Monoid
A **monoid** is a **magma** that includes an **identity element**:
- The identity **does not change** other elements when used in the operation.

### Example: Monoid in ℤ/5ℤ with Addition
The set `{0, 1, 2, 3, 4}` with **addition mod 5**:
- **Identity:** `0` (because `a + 0 = a` for any `a` in the set).
- **Closure:** Still holds (all results stay in the set).

✔ **Has an Identity**: `0 + 3 = 3`, `0 + 4 = 4`, etc.  
❌ **No Inverses**: There is no guarantee that each element has an opposite (inverse).

---

## 3. Group
A **group** is a **monoid** where every element has an **inverse**:
- The **inverse** of `a` is an element `b` such that `a + b = identity`.

### Example: Group in ℤ/5ℤ with Addition
The set `{0, 1, 2, 3, 4}` under **addition mod 5**:
- **Identity:** `0`
- **Inverses:** Each element has an inverse:
  - `0 → 0` (0 + 0 = 0)
  - `1 → 4` (1 + 4 = 5 ≡ 0 mod 5)
  - `2 → 3` (2 + 3 = 5 ≡ 0 mod 5)

✔ **Has an Identity (`0`)**  
✔ **Each element has an inverse**  
✔ **Closure holds**  
❌ **Does not require multiplication**: This group is only defined with addition.

---

## 4. Ring
A **ring** combines two operations: **addition and multiplication**.
- The **addition operation** forms a **group**.
- The **multiplication operation** forms a **monoid** (meaning it has closure and an identity but may not have multiplicative inverses).
- The **multiplication operation** distributes over the **addition operation** (`a * (b + c) = a * b + a * c`)
- The **multiplication operation** takes precedence over the **additive operation**.

### Example: Ring in ℤ/5ℤ
The set `{0, 1, 2, 3, 4}` with **addition and multiplication mod 5**:
- **Addition** is a **group** (as shown earlier).
- **Multiplication** forms a **monoid**:
  - **Identity:** `1` (since `1 * a = a` for all `a`).
  - **Closure:** The result always stays in `{0, 1, 2, 3, 4}`.
  - **Example Multiplication Table mod 5:**
  
    | ×  | 0  | 1  | 2  | 3  | 4  |
    |----|----|----|----|----|----|
    | 0  | 0  | 0  | 0  | 0  | 0  |
    | 1  | 0  | 1  | 2  | 3  | 4  |
    | 2  | 0  | 2  | 4  | 1  | 3  |
    | 3  | 0  | 3  | 1  | 4  | 2  |
    | 4  | 0  | 4  | 3  | 2  | 1  |

✔ **Addition is a group**  
✔ **Multiplication is a monoid**  
❌ **Multiplication does not require inverses** (e.g., `2` has no inverse under mod 5 multiplication).  

---

## Summary Table

| Structure  | Has Set | Has Operation | Closure | Identity | Inverses |
|------------|---------|--------------|---------|----------|----------|
| **Magma**  | ✅ | ✅ | ✅ | ❌ | ❌ |
| **Monoid** | ✅ | ✅ | ✅ | ✅ | ❌ |
| **Group**  | ✅ | ✅ | ✅ | ✅ | ✅ (for addition) |
| **Ring**   | ✅ | ✅ (2 operations) | ✅ | ✅ (for both) | ✅ (for addition only) |

---

## Conclusion
- A **magma** only requires an operation to be **closed**.
- A **monoid** adds an **identity element**.
- A **group** ensures that **each element has an inverse** (for addition).
- A **ring** combines **addition (a group) and multiplication (a monoid).**

