const Employee = require('../app/employeedata')


test('Test an incorrect value in National Insurance Number input', () => {
    const emp = {ni_number: 'A456a'}
    const result = Employee.validate(emp)
    expect(result).toBe('National insurance number is incorrect')
})

test('Test a correct value in National Insurance Number input', () => {
    const emp = {ni_number: 'QQ 12 34 56 C'}
    const result = Employee.validate(emp)
    expect(result).toBe('Test a correct value in National Insurance Number input')
})
