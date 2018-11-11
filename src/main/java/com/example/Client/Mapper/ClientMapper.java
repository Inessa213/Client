package com.example.Client.Mapper;


import com.example.Client.Model.ClientInfo;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

public class ClientMapper implements RowMapper<ClientInfo> {


    @Override
    public ClientInfo mapRow(ResultSet rs, int rowNum) throws SQLException {

        Long id = rs.getLong("id");
        String firstName = rs.getString("first_name");
        String lastName = rs.getString("last_name");
        String patronumic = rs.getString("patronumic");
        int age = rs.getInt("age");

        return new ClientInfo(id, firstName, lastName, patronumic, age);
    }
}


