
package com.example.customerapp.service;

import com.example.customerapp.dto.CustomerDTO;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class CustomerService {

    private final Map<Long, CustomerDTO> customerMap = new HashMap<>();
    private Long idCounter = 1L;

    public CustomerDTO createCustomer(CustomerDTO customer) {
        customer.setId(idCounter++);
        customerMap.put(customer.getId(), customer);
        return customer;
    }

    public CustomerDTO getCustomerById(Long id) {
        return customerMap.get(id);
    }

    public List<CustomerDTO> getAllCustomers() {
        return new ArrayList<>(customerMap.values());
    }

    public CustomerDTO updateCustomer(Long id, CustomerDTO updatedCustomer) {
        if (customerMap.containsKey(id)) {
            updatedCustomer.setId(id);
            customerMap.put(id, updatedCustomer);
            return updatedCustomer;
        }
        return null;
    }

    public boolean deleteCustomer(Long id) {
        return customerMap.remove(id) != null;
    }
}
