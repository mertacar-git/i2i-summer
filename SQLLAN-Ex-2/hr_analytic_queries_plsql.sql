-- Soru 1: PL/SQL ile LISTAGG işlemi
BEGIN
  FOR rec IN (
    SELECT department_id,
           LISTAGG(first_name || ' ' || last_name, ', ') WITHIN GROUP (ORDER BY employee_id) AS employees
    FROM employees
    GROUP BY department_id
  ) LOOP
    DBMS_OUTPUT.PUT_LINE('Department: ' || rec.department_id || ' => ' || rec.employees);
  END LOOP;
END;
/

-- Soru 2: Önceki ve sonraki maaş toplamı
BEGIN
  FOR rec IN (
    SELECT employee_id,
           job_id,
           salary,
           NVL(LAG(salary) OVER (PARTITION BY job_id ORDER BY employee_id), 0) +
           NVL(LEAD(salary) OVER (PARTITION BY job_id ORDER BY employee_id), 0) AS sum_neighbors
    FROM employees
  ) LOOP
    DBMS_OUTPUT.PUT_LINE('Emp ID: ' || rec.employee_id || ' Sum: ' || rec.sum_neighbors);
  END LOOP;
END;
/

-- Soru 3: Sonraki telefon numarası
BEGIN
  FOR rec IN (
    SELECT employee_id,
           LEAD(phone_number) OVER (PARTITION BY job_id ORDER BY employee_id) AS next_phone
    FROM employees
  ) LOOP
    DBMS_OUTPUT.PUT_LINE('Emp ID: ' || rec.employee_id || ' Next Phone: ' || rec.next_phone);
  END LOOP;
END;
/

-- Soru 4: Maaş sıralaması (RANK)
BEGIN
  FOR rec IN (
    SELECT employee_id,
           salary,
           hire_date,
           RANK() OVER (ORDER BY salary DESC, hire_date ASC) AS salary_rank
    FROM employees
  ) LOOP
    DBMS_OUTPUT.PUT_LINE('Emp ID: ' || rec.employee_id || ' Rank: ' || rec.salary_rank);
  END LOOP;
END;
/

-- Soru 5: NTILE ile 10’arlı gruplar
BEGIN
  FOR rec IN (
    SELECT employee_id,
           NTILE(10) OVER (ORDER BY employee_id) AS group_number
    FROM employees
  ) LOOP
    DBMS_OUTPUT.PUT_LINE('Emp ID: ' || rec.employee_id || ' Group: ' || rec.group_number);
  END LOOP;
END;
/

-- Soru 6: Maaş ortalamasına göre 0-1 işaretleme
BEGIN
  FOR rec IN (
    SELECT employee_id,
           department_id,
           salary,
           CASE 
             WHEN salary < AVG(salary) OVER (PARTITION BY department_id) THEN 0
             ELSE 1
           END AS salary_flag
    FROM employees
  ) LOOP
    DBMS_OUTPUT.PUT_LINE('Emp ID: ' || rec.employee_id || ' Flag: ' || rec.salary_flag);
  END LOOP;
END;
/

-- Soru 7: Yıla göre ilk alınan çalışan
BEGIN
  FOR rec IN (
    SELECT *
    FROM (
        SELECT employee_id,
               first_name,
               hire_date,
               EXTRACT(YEAR FROM hire_date) AS hire_year,
               ROW_NUMBER() OVER (PARTITION BY EXTRACT(YEAR FROM hire_date) ORDER BY hire_date ASC) AS rn
        FROM employees
    ) WHERE rn = 1
  ) LOOP
    DBMS_OUTPUT.PUT_LINE('Year: ' || rec.hire_year || ' Emp: ' || rec.first_name);
  END LOOP;
END;
/

-- Soru 8: En yüksek maaş dışındakiler
BEGIN
  FOR rec IN (
    SELECT employee_id, salary, department_id
    FROM (
      SELECT employee_id, salary, department_id,
             MAX(salary) OVER (PARTITION BY department_id) AS max_salary
      FROM employees
    ) WHERE salary < max_salary
  ) LOOP
    DBMS_OUTPUT.PUT_LINE('Emp ID: ' || rec.employee_id || ' Salary: ' || rec.salary);
  END LOOP;
END;
/

-- Soru 9: Departmandaki en yüksek 2 maaş
BEGIN
  FOR rec IN (
    SELECT *
    FROM (
      SELECT employee_id, department_id, salary,
             RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS salary_rank
      FROM employees
    ) WHERE salary_rank <= 2
  ) LOOP
    DBMS_OUTPUT.PUT_LINE('Emp ID: ' || rec.employee_id || ' Rank: ' || rec.salary_rank);
  END LOOP;
END;
/

-- Soru 10: Önceki ve sonraki çalışan adları
BEGIN
  FOR rec IN (
    SELECT employee_id,
           first_name,
           last_name,
           department_id,
           LAG(first_name || ' ' || last_name) OVER (PARTITION BY department_id ORDER BY hire_date) AS previous_employee,
           LEAD(first_name || ' ' || last_name) OVER (PARTITION BY department_id ORDER BY hire_date) AS next_employee
    FROM employees
  ) LOOP
    DBMS_OUTPUT.PUT_LINE('Emp ID: ' || rec.employee_id || ' Prev: ' || rec.previous_employee || ' Next: ' || rec.next_employee);
  END LOOP;
END;
/