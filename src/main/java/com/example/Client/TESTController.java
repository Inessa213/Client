package com.example.Client;


import Model.ClientInfo;
import Model.Greeting;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
public class TESTController {

    @Autowired
    private ClientDAO clientDAO;

    @RequestMapping(
            value = "/test.action",
            consumes = MediaType.APPLICATION_JSON_VALUE,
            produces = MediaType.APPLICATION_JSON_VALUE,
            method = RequestMethod.POST)

    @ResponseBody
    public List<ClientInfo> testRisk(@RequestBody final Greeting request){


        List<ClientInfo> list = clientDAO.getClient(request.getFirst_name());

        return list;
    }

}
