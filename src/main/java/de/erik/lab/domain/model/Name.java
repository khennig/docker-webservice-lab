package de.erik.lab.domain.model;

import java.util.Objects;

import javax.persistence.Embeddable;
import javax.validation.constraints.NotNull;

@Embeddable
public class Name {

	@NotNull
	String vorname;

	@NotNull
	String nachname;

	Name() {
		// required for jpa
	}

	public Name(String vorname, String nachname) {
		this.vorname = Objects.requireNonNull(vorname, "Vorname erforderlich");
		this.nachname = Objects.requireNonNull(nachname, "Nachname erforderlich");
	}

	public String getVorname() {
		return vorname;
	}

	public String getNachname() {
		return nachname;
	}
}
