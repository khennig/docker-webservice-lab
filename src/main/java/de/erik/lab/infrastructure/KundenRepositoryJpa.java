package de.erik.lab.infrastructure;

import java.util.List;

import javax.enterprise.context.ApplicationScoped;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import de.erik.lab.domain.model.Kunde;
import de.erik.lab.domain.model.KundenRepository;

@ApplicationScoped
public class KundenRepositoryJpa implements KundenRepository {

    @PersistenceContext(name = "default")
    EntityManager em;

    @Override
    public List<Kunde> getKunden() {
        return em.createQuery("SELECT k FROM Kunde k").getResultList();
    }
}
