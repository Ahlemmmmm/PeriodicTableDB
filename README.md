# 🧪 Periodic Table Database

This project builds a **PostgreSQL database** for chemical elements of the periodic table, and a Bash script to query element information.  
It is part of the **FreeCodeCamp Relational Database Certification**.

---

## 📁 Project Structure

```

periodic_table/
├── fix_periodic_table.sql   # SQL script to fix schema, constraints, and add elements
├── element.sh               # Bash script to query elements by atomic number, symbol, or name
├── atomic_mass.txt          # Reference file with corrected atomic masses
├── README.md                # Project documentation
└── .gitignore               # Optional

````

---

## 🧠 Overview

The project includes:  

- **Database fixes and enhancements:**
  - Renamed columns for clarity (`weight → atomic_mass`, `melting_point → melting_point_celsius`, `boiling_point → boiling_point_celsius`)
  - Added `NOT NULL` and `UNIQUE` constraints
  - Capitalized symbols
  - Removed trailing zeros in `atomic_mass`
  - Added foreign key relationships between `elements`, `properties`, and `types` tables
  - Deleted invalid elements

- **Types table:**
  - Created `types` table to store element types (metal, nonmetal, metalloid)
  - Updated `properties` table with `type_id` referencing `types`

- **Element additions:**
  - Added Fluorine (atomic number 9) and Neon (atomic number 10)

- **Bash script (`element.sh`):**
  - Accepts atomic number, symbol, or element name as an argument
  - Outputs formatted element information including type, atomic mass, melting point, and boiling point
  - Handles invalid or missing input

---

## 🛠 Usage

1. **Set up the database:**

```bash
psql --username=freecodecamp --dbname=periodic_table -f fix_periodic_table.sql
````

2. **Run the Bash script:**

```bash
./element.sh 1        # Example with atomic number
./element.sh H        # Example with symbol
./element.sh Hydrogen # Example with name
```

3. **Output example:**

```
The element with atomic number 1 is Hydrogen (H). It's a nonmetal, with a mass of 1.008 amu. Hydrogen has a melting point of -259.1 celsius and a boiling point of -252.9 celsius.
```

4. **No argument provided:**

```
Please provide an element as an argument.
```

5. **Nonexistent element:**

```
I could not find that element in the database.
```

---

## 📌 Git

* The repository contains a **main branch** with at least **five commits**.
* Commit messages follow the format: `Initial commit`, `fix:`, `feat:`, `refactor:`, `chore:`, or `test:`.

---

## 🛠 Technologies

* PostgreSQL
* SQL
* Bash
* Git

---

## ⚡ Author : Ahlem LOUNAS

Created as part of **FreeCodeCamp Relational Database Certification**.

