package com.example.Client;


import Model.ClientInfo;
import Mapper.ClientMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.support.JdbcDaoSupport;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;
import java.util.List;


@Repository
public class ClientDAO extends JdbcDaoSupport {

    @Autowired
    public ClientDAO(DataSource dataSource) {
        this.setDataSource(dataSource);
    }


    public List<ClientInfo> getClient(String first_name) {

        String sql = "Select * from client where first_name = '"+first_name+"'";
        Object[] params = new Object[]{};
        ClientMapper mapper = new ClientMapper();
        List<ClientInfo> list = this.getJdbcTemplate().query(sql, params, mapper);

        return list;

    }
}



