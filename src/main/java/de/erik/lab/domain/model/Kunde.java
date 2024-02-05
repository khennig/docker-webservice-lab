package de.erik.lab.domain.model;

import java.util.Objects;

import javax.persistence.Embedded;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class Kunde {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	Long id;

	@Embedded
	Name name;

	Kunde() {
		// required by jpa
	}

	public Kunde(Name name) {
		changeName(name);
	}

	public Long getId() {
		return id;
	}

	public Name getName() {
		return name;
	}

	public void changeName(Name name) {
		this.name = Objects.requireNonNull(name, "Name erforderlich");
	}
}
