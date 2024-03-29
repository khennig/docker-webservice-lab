package de.erik.lab.interfaces;

import java.util.Map;
import java.util.stream.Collectors;

import javax.json.Json;
import javax.json.JsonObject;
import javax.json.JsonValue;
import javax.json.stream.JsonCollectors;
import javax.ws.rs.GET;
import javax.ws.rs.Path;

@Path("jvm-system-properties")
public class JvmSystemProperties {

    @GET
    public JsonObject get() {
        Map<String, JsonValue> propertyMap = System.getProperties().entrySet().stream().collect(
            Collectors.toMap(key -> key.getKey().toString(),
                value -> Json.createValue(value.getValue().toString())));
        return propertyMap.entrySet().stream().collect(JsonCollectors.toJsonObject());
    }
}