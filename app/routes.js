const express = require('express')
const router = express.Router()
const employeeData = require('./employeeData.js')
const departmentData = require('./departmentData.js')

router.get('/', (req, res) => {
    res.render('navigation');
});

router.get('/listEmployees', async (req, res) => {
    res.render('listEmployees', { employees: await employeeData.getEmployees() } )
});

router.get('/listSalesEmployees', async (req, res) => {
    res.render('listSalesEmployees', { employees: await employeeData.getSalesEmployees(), topEarner: await employeeData.getTopEarner() } )
});

router.get('/listEmployeesPerDepartment/:department', async (req, res) => {
    res.render('listEmployeesPerDepartment', { departmentEmployees: await departmentData.getEmployeesInDepartment(req.params.department), departmentName: req.params.department} );
});

router.get('/addemployee', async(req, res)=>{
    res.render('newEmployeeForm', { employees: await employeeData.getEmployees() } );
  });

router.post('/addemployee', async(req, res) => {
    var employee = req.body
    var errorMessage = employeeData.validateEmployee(employee);
    if(errorMessage){
        res.locals.errormessage = errorMessage;
        res.render('newEmployeeForm', employee )
    } else {
        let insertedKey = await employeeData.addEmployee(employee)
        res.render('listEmployees', { employees: await employeeData.getEmployees()} )
    }
})

router.get('/addsalesemployee', async(req, res)=>{
    res.render('newSalesEmployeeform', { employees: await employeeData.getSalesEmployees(), topEarner: await employeeData.getTopEarner()  } );
});

router.post('/addsalesemployee', async(req, res) => {
    var salesEmployee = req.body
    var errorMessageOne = employeeData.validateEmployee(salesEmployee);
    var errorMessageTwo = employeeData.validateSalesEmployee(salesEmployee);
    if(errorMessageOne||errorMessageTwo){
        res.locals.errormessage = errorMessageOne||errorMessageTwo;
        res.render('newSalesEmployeeForm', salesEmployee )
    } else {
        let insertedKey = await employeeData.addSalesEmployee(salesEmployee)
        res.render('listSalesEmployees', {  employees: await employeeData.getEmployees(),
                                            employees: await employeeData.getSalesEmployees(),
                                            topEarner: await employeeData.getTopEarner()} )
    }
})

module.exports = router