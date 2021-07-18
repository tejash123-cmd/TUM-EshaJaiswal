package de.tum.in.ase.eist;

import java.util.ArrayList;
import java.util.List;

// TODO 1: Implement the Supervisor class
public class Supervisor extends Employee {
	private List<Employee> supervisedEmployees = new ArrayList<Employee>();

	public Supervisor(String name) {
		super(name);
		// TODO Auto-generated constructor stub
	}

	public List<Employee> getSupervisedEmployees() {
		return supervisedEmployees;
	}

	@Override
	public void list(int level) {
		// TODO Auto-generated method stub
		printName(level);
		for (Employee employee : supervisedEmployees) {
			employee.list(level + 1);
		}

	}

	public void addEmployee(Employee employee) {
		supervisedEmployees.add(employee);
	}

	public void fireEmployee(Employee employee) {
		supervisedEmployees.remove(employee);
	}

	// TODO 3: Implement list() for Supervisor
}
