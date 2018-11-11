package com.example.Client;


import com.example.Client.Model.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;

@RestController
public class TESTController {

    @Autowired
    private ClientDAO clientDAO;

    @RequestMapping(
            value = "/testHello",
            consumes = MediaType.APPLICATION_JSON_VALUE,
            produces = MediaType.APPLICATION_JSON_VALUE,
            method = RequestMethod.POST)
    @ResponseBody
    public TestRe testHello(@RequestBody final TestHello request) {
            TestRe testRe = new TestRe();
            testRe.setResponse("Hello, " + request.getUser());
            return testRe;
    }

    @RequestMapping(
            value = "/testFirstName",
            consumes = MediaType.APPLICATION_JSON_VALUE,
            produces = MediaType.APPLICATION_JSON_VALUE,
            method = RequestMethod.POST)
    @ResponseBody
    public ListClientInfo testFirstName(@RequestBody final Greeting request) {
            ListClientInfo listClientInfo = new ListClientInfo();
            listClientInfo.setClients(clientDAO.getClient(request.getFirstName()));
            return listClientInfo;
    }
}
