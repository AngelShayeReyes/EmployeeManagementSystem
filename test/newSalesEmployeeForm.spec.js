const employeeData = require('../app/employeedata')

test('Test validation for sales employee values', () => {
    const result = employeeData.validateSalesEmployee({total_sales: '1000',
                                                  commission_rate: '1.2'})
    expect(result).toBe(undefined)
})

test('Test invalidation for empty total sales', () => {
    const result = employeeData.validateSalesEmployee({total_sales: '',
                                                  commission_rate: '1.2'})
    expect(result).toBe('Field missing')
})

test('Test invalidation for empty commission rate', () => {
    const result = employeeData.validateSalesEmployee({total_sales: '1000',
                                                  commission_rate: ''})
    expect(result).toBe("Field missing")
})

test('Test invalidation for total sales being a number', () => {
    const result = employeeData.validateSalesEmployee({total_sales: 'a',
                                                  commission_rate: '1.2'})
    expect(result).toBe("Total sales can only be a number.")
})

test('Test invalidation for commission rate being over 100', () => {
    const result = employeeData.validateSalesEmployee({total_sales: '1000',
                                                  commission_rate: '101'})
    expect(result).toBe("Commission rate is maximum 100.")
})