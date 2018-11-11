package Mapper;


import Model.ClientInfo;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

public class ClientMapper implements RowMapper<ClientInfo> {
    public static final String BASE_SQL = "Select * from client";

    @Override
    public ClientInfo mapRow(ResultSet rs, int rowNum) throws SQLException {



        Long id = rs.getLong("Id");
        String first_name = rs.getString("first_name");
        String last_name = rs.getString("last_name");
        String patronumic = rs.getString("patronumic");
        int age = rs.getInt("age");

        return new ClientInfo(id, first_name, last_name, patronumic, age);
    }
}


