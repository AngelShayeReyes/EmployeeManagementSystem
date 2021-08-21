const employeeData = require('../app/employeedata')

test('Test validation for employee values', () => {
    const result = employeeData.validateEmployee({employee_name: 'Anya Tora',
                                                  ni_number: 'AA 12 34 56 A',
                                                  employee_address: '77 Zoo Lane',
                                                  employee_postcode: 'ZL12 31BB',
                                                  salary: '50000',
                                                  account_num: '12345678',
                                                  sort_code: '12-34-56'})
    expect(result).toBe(undefined)
})

test('Test invalidation for an incorrect value in National Insurance Number input', () => {
    const result = employeeData.validateEmployee({employee_name: 'Anya Tora',
                                                  ni_number: 'A456a',
                                                  employee_address: '77 Zoo Lane',
                                                  employee_postcode: 'ZL12 31BB',
                                                  salary: '50000',
                                                  account_num: '12345678',
                                                  sort_code: '12-34-56'})
    expect(result).toBe('National Insurance Number format is incorrect.')
})

test('Test invalidation for an incorrect value in Salary input', () => {
    const result = employeeData.validateEmployee({employee_name: 'Anya Tora',
                                                  ni_number: 'AA 12 34 56 A',
                                                  employee_address: '77 Zoo Lane',
                                                  employee_postcode: 'ZL12 31BB',
                                                  salary: '50',
                                                  account_num: '12345678',
                                                  sort_code: '12-34-56'})
    expect(result).toBe('Salary cannot be below 7000.')
})

test('Test invalidation for field missing name', () => {
    const result = employeeData.validateEmployee({employee_name: '',
                                                      ni_number: 'AA 12 34 56 A',
                                                      employee_address: '77 Zoo Lane',
                                                      employee_postcode: 'ZL12 31BB',
                                                      salary: '50000',
                                                      account_num: '12345678',
                                                      sort_code: '12-34-56'})
    expect(result).toBe('Field missing')
})

test('Test invalidation for salary being a number', () => {
    const result = employeeData.validateEmployee({employee_name: 'Anya Tora',
                                                      ni_number: 'AA 12 34 56 A',
                                                      employee_address: '77 Zoo Lane',
                                                      employee_postcode: 'ZL12 31BB',
                                                      salary: 'aa',
                                                      account_num: '12345678',
                                                      sort_code: '12-34-56'})
    expect(result).toBe('Salary can only be a number.')
})

test('Test invalidation for account number format', () => {
    const result = employeeData.validateEmployee({employee_name: 'Anya Tora',
                                                      ni_number: 'AA 12 34 56 A',
                                                      employee_address: '77 Zoo Lane',
                                                      employee_postcode: 'ZL12 31BB',
                                                      salary: '50000',
                                                      account_num: '1111111',
                                                      sort_code: '12-34-56'})
    expect(result).toBe('Incorrect account number format.')
})

test('Test invalidation for account number being a number', () => {
    const result = employeeData.validateEmployee({employee_name: 'Anya Tora',
                                                      ni_number: 'AA 12 34 56 A',
                                                      employee_address: '77 Zoo Lane',
                                                      employee_postcode: 'ZL12 31BB',
                                                      salary: '50000',
                                                      account_num: 'a',
                                                      sort_code: '12-34-56'})
    expect(result).toBe('Incorrect account number format.')
})

test('Test invalidation for sort code format', () => {
    const result = employeeData.validateEmployee({employee_name: 'Anya Tora',
                                                      ni_number: 'AA 12 34 56 A',
                                                      employee_address: '77 Zoo Lane',
                                                      employee_postcode: 'ZL12 31BB',
                                                      salary: '50000',
                                                      account_num: '12345678',
                                                      sort_code: '123455'})
    expect(result).toBe('Incorrect sort code format.')
})