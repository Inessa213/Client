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


    public List<ClientInfo> getClient(String firstName) {

        String sql = "Select id, first_name, last_name, patronumic, age from public.get_client_by_name_fn(?)";
       // Object[] params = new Object[]{};
        ClientMapper mapper = new ClientMapper();
        List<ClientInfo> list = this.getJdbcTemplate().query(sql, mapper, firstName);

        return list;

    }
}



