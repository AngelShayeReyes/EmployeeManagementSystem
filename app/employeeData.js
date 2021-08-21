const mysql = require('mysql'); 
const dbconfig = require('./dbconfig.json'); 
const util = require ('util')
const db = wrapDB(dbconfig)

function wrapDB (dbconfig) { 
    const pool = mysql.createPool(dbconfig) 
    return { 
        query(sql, args) { 
            return util.promisify( pool.query ) 
            .call(pool, sql, args) 
        }, 
        release () { 
            return util.promisify( pool.releaseConnection ) 
            .call( pool ) 
        } 
    } 
}

getEmployeesAll = async (  ) => { 
    return await db.query( 
        "SELECT * FROM Employee") 
 }

exports.getEmployees = async () => { 
    return await getEmployeesAll(); 
}

exports.validate = (employee) => {
    if (!(employee.employee_name)||!(employee.ni_number)||!(employee.employee_address)||
        !(employee.employee_postcode)||!(employee.salary)||!(employee.account_num)||!(employee.sort_code)) {
       return "Field missing";
    }

    const ni_regex = /^\s*[a-zA-Z]{2}(?:\s*\d\s*){6}[a-zA-Z]?\s*$/
    if(!(ni_regex).test(employee.ni_number)){
       return "National Insurance Number format is incorrect.";
    }

    if(employee.salary < 7000){
        return "Salary cannot be below 7000.";
    }

    if(isNaN(employee.salary)){
        return "Salary can only be a number.";
    }

    const account_num_regex = /^\s*[0-9]{8}$/
    if(!account_num_regex.test(employee.account_num)){
           return "Incorrect account number format.";
    }
    const sort_code_regex = /[0-9]{2}-?[0-9]{2}-?[0-9]{2}$/
    if(!sort_code_regex.test(employee.sort_code)){
           return "Incorrect sort code format.";
    }
  }

exports.addEmployee = async (newEmployee) => {
    let results = await db.query('INSERT INTO Employee SET ?', newEmployee)
    console.log(newEmployee)
    return results.insertId;
}

getSalesEmployeesAll = async (  ) => { 
    return await db.query( 
        "select * from Employee Join SalesEmployee using (employee_id )") 
 }

exports.getSalesEmployees = async () => { 
    return await getSalesEmployeesAll(); 
}

getTopEarner = async (  ) => { 
    return await db.query( 
        "SELECT * FROM Employee LEFT JOIN SalesEmployee using(employee_id) ORDER BY total_sales DESC LIMIT 1;") 
 }

exports.getTopEarner = async () => { 
    return await getTopEarner(); 
}

exports.addSalesEmployee = async (newSalesEmployee) => { 
    
    const normalEmployee = {
        employee_id: newSalesEmployee.employee_id,
        employee_name: newSalesEmployee.employee_name,
        ni_number: newSalesEmployee.ni_number,
        employee_address: newSalesEmployee.employee_address,
        employee_postcode: newSalesEmployee.employee_postcode,
        salary: newSalesEmployee.salary,
        account_num: newSalesEmployee.account_num,
        sort_code: newSalesEmployee.sort_code,
        is_manager: newSalesEmployee.is_manager,
        active: newSalesEmployee.active,
        employee_type: "Sales"
    };

    let salesID = await this.addEmployee(normalEmployee);
    console.log(salesID);

    const salesEmployee = {
        employee_id: salesID,
        commission_rate: newSalesEmployee.commission_rate,
        total_sales: newSalesEmployee.total_sales
    };

    let results = await db.query('INSERT INTO SalesEmployee SET ?', salesEmployee) 

    return results.insertId; 
}