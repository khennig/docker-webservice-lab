package de.erik.lab.interfaces;

import java.util.List;

import javax.inject.Inject;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import de.erik.lab.domain.model.Kunde;
import de.erik.lab.domain.model.KundenRepository;

@Path("kunden")
@Produces(MediaType.APPLICATION_JSON)
public class KundenResource {

    @Inject
    KundenRepository kundenRepository;

    @GET
    public List<Kunde> getKunden() {
        return kundenRepository.getKunden();
    }
}
