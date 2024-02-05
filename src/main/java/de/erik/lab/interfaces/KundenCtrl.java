package de.erik.lab.interfaces;

import java.io.Serializable;
import java.util.List;

import javax.faces.view.ViewScoped;
import javax.inject.Inject;
import javax.inject.Named;
import javax.ws.rs.GET;

import de.erik.lab.domain.model.Kunde;
import de.erik.lab.domain.model.KundenRepository;

@Named
@ViewScoped
public class KundenCtrl implements Serializable {

    @Inject
    transient KundenRepository kundenRepository;

    @GET
    public List<Kunde> getKunden() {
        return kundenRepository.getKunden();
    }
}
