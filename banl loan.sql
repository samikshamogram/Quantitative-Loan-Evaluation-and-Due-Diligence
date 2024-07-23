SELECT * FROM bank_loan_data

--TOTAL LOAN APPLICATIONS

select count(id) as total_loan_applications from bank_loan_data

--MONTH TO DATE (MTD) LOAN APPLICATIONS

select count(id) as MTD_LOAN_APP from bank_loan_data
where month(issue_date)=12 and year(issue_date)= 2021

--PREVIOUS MONTH TO DATE (MTD) LOAN APPLICATIONS

select count(id) as PMTD_LOAN_APP from bank_loan_data
where month(issue_date)=11 and year(issue_date)= 2021

--TOTAL FUNDED AMOUNT

select sum(loan_amount) as mtd_total_amount_funded from bank_loan_data
where month(issue_date)=12 and year(issue_date)= 2021

select sum(loan_amount) as pmtd_total_amount_funded from bank_loan_data
where month(issue_date)=11 and year(issue_date)= 2021

--TOTAL AMOUNT RECIEVED

select sum(total_payment) as mtd_total_amount_recieved from bank_loan_data
where month(issue_date)=12 and year(issue_date)= 2021

select sum(total_payment) as pmtd_total_amount_recieved from bank_loan_data
where month(issue_date)=11 and year(issue_date)= 2021


--AVERAGE INTREST RATE

select CAST (AVG(int_rate)*100  AS DECIMAL (10,2))as avg_int_rate from bank_loan_data

select CAST (AVG(int_rate)*100  AS DECIMAL (10,2))as mtd_avg_int_rate from bank_loan_data
where month(issue_date)=12 and year(issue_date)= 2021

select CAST (AVG(int_rate)*100  AS DECIMAL (10,2))as pmtd_avg_int_rate from bank_loan_data
where month(issue_date)=11 and year(issue_date)= 2021

--AVERAGE DEBT-TO-INCOME RATIO

select avg(dti)*100 as avg_dti_ratio from bank_loan_data


select avg(dti)*100 as mtd_avg_dti_ratio from bank_loan_data
where month(issue_date)=12 and year(issue_date)= 2021

select avg(dti)*100 as pmtd_avg_dti_ratio from bank_loan_data
where month(issue_date)=11 and year(issue_date)= 2021

--PERCENTAGE OF GOOD LOAN APPLICATIONS

SELECT (COUNT(CASE WHEN loan_status = 'Fully Paid' OR loan_status = 'Current' THEN id END)*100)/
COUNT(id) as good_loan_percentage
FROM bank_loan_data


--GOOD LOAN APPLICATIONS

select count(id) as good_loan_applications from bank_loan_data
where loan_status in ('Fully Paid' , 'Current') 

--GOOD LOAN FUNDED AMOUNT

SELECT SUM(loan_amount) as good_loan_funded_amount from bank_loan_data
where loan_status in ('Fully Paid', 'Current')


--GOOD LOAN AMOUNT RECIEVED 

SELECT SUM(total_payment) as good_loan_recieved_amount from bank_loan_data
where loan_status in ('Fully Paid', 'Current')

--PERCENTAGE OF BAD LOAN APPLICATIONS

SELECT (COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END)*100)/
COUNT(id) as bad_loan_percentage
FROM bank_loan_data

--BAD LOAN APPLICATIONS

select count(id) as bad_loan_applications from bank_loan_data
where loan_status = 'Charged Off'

--BAD LOAN FUNDED AMOUNT

SELECT SUM(loan_amount) as bad_loan_funded_amount from bank_loan_data
where loan_status ='Charged Off'

--BAD LOAN AMOUNT RECIEVED 

SELECT SUM(total_payment) as badd_loan_recieved_amount from bank_loan_data
where loan_status ='Charged Off'


--LOAN STATUS GRID QUERY

SELECT 
         loan_status,
		 COUNT(id) AS LoanCount,
		 SUM(total_payment) AS Total_Amount_Recieved,
		 SUM(loan_amount) AS Total_Amount_Funded,
		 AVG(int_rate * 100) AS Intrest_Rate,
		 AVG(dti*100) AS DTI
FROM bank_loan_data
GROUP BY loan_status

--MONTHLY TRENDS BY ISSUE DATE

SELECT 
       MONTH(issue_date) AS month_number,
       DATENAME(MONTH,issue_date) AS month,
	   COUNT(id) AS total_loan_applications,
	   SUM(total_payment) AS total_amount_recieved,
	   SUM(loan_amount) AS total_amount_funded
FROM bank_loan_data
GROUP BY DATENAME(MONTH,issue_date), MONTH(issue_date)
ORDER BY  MONTH(issue_date)

--REGIONAL ANALYSIS BY EMPLOYEE LENGTH

SELECT 
      emp_length,
       COUNT(id) AS total_loan_applications,
	   SUM(total_payment) AS total_amount_recieved,
	   SUM(loan_amount) AS total_amount_funded
FROM bank_loan_data
GROUP BY emp_length
ORDER BY emp_length

--REGIONAL ANALYSIS BY STATE

SELECT 
      address_state,
       COUNT(id) AS total_loan_applications,
	   SUM(total_payment) AS total_amount_recieved,
	   SUM(loan_amount) AS total_amount_funded
FROM bank_loan_data
GROUP BY address_state
ORDER BY address_state

--REGIONAL ANALYSIS BY TERM

SELECT 
      term,
       COUNT(id) AS total_loan_applications,
	   SUM(total_payment) AS total_amount_recieved,
	   SUM(loan_amount) AS total_amount_funded
FROM bank_loan_data
GROUP BY term
ORDER BY term 

--REGIONAL ANALYSIS BY PURPOSE

SELECT 
      purpose,
       COUNT(id) AS total_loan_applications,
	   SUM(total_payment) AS total_amount_recieved,
	   SUM(loan_amount) AS total_amount_funded
FROM bank_loan_data
GROUP BY purpose
ORDER BY purpose 

--REGIONAL ANALYSIS BY HOME OWNERSHIP

SELECT 
      home_ownership,
       COUNT(id) AS total_loan_applications,
	   SUM(total_payment) AS total_amount_recieved,
	   SUM(loan_amount) AS total_amount_funded
FROM bank_loan_data
GROUP BY home_ownership
ORDER BY count(id) DESC
