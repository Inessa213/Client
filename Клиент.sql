--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.10
-- Dumped by pg_dump version 9.6.0

-- Started on 2018-11-11 10:49:22

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 1 (class 3079 OID 12387)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2150 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- TOC entry 205 (class 1255 OID 16475)
-- Name: add_address_fn(character varying, character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION add_address_fn(first_name1 character varying, last_name1 character varying, patronumic1 character varying, city character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
begin
	insert into address (city, client_id) values (city, 
	(select id from client as c
		WHERE
  			c.first_name = first_name1 AND 
  			c.last_name = last_name1 AND 
  			c.patronumic = patronumic1 ));
end
$$;


ALTER FUNCTION public.add_address_fn(first_name1 character varying, last_name1 character varying, patronumic1 character varying, city character varying) OWNER TO postgres;

--
-- TOC entry 204 (class 1255 OID 16504)
-- Name: add_client_fn(character varying, character varying, character varying, integer, integer, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION add_client_fn(first_name character varying, last_name character varying, patronumic character varying, age integer, id_a integer, city character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
begin    
    insert into client (first_name, last_name, patronumic, age) 
		   values (first_name, last_name, patronumic, age);
end
$$;


ALTER FUNCTION public.add_client_fn(first_name character varying, last_name character varying, patronumic character varying, age integer, id_a integer, city character varying) OWNER TO postgres;

--
-- TOC entry 203 (class 1255 OID 16503)
-- Name: get_client_by_name_fn(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION get_client_by_name_fn(first_name1 character varying) RETURNS TABLE(id integer, first_name character varying, last_name character varying, patronumic character varying, age integer)
    LANGUAGE sql
    AS $$
    select * from client as c
    where c.first_name = first_name1;
$$;


ALTER FUNCTION public.get_client_by_name_fn(first_name1 character varying) OWNER TO postgres;

--
-- TOC entry 202 (class 1255 OID 16501)
-- Name: get_older_client_fn(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION get_older_client_fn() RETURNS TABLE(first_name character varying, last_name character varying, patronumic character varying, age integer)
    LANGUAGE sql
    AS $$
SELECT 
  c.first_name,
  c.last_name,
  c.patronumic,
  c.age AS "FIELD_1"
FROM
  client c
WHERE
  c.age = (SELECT max(age) AS "FIELD_1" FROM client);
$$;


ALTER FUNCTION public.get_older_client_fn() OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 186 (class 1259 OID 16399)
-- Name: address; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE address (
    id integer DEFAULT nextval(('public.address_id_seq'::text)::regclass) NOT NULL,
    client_id integer,
    city character varying(50) DEFAULT NULL::character varying
);


ALTER TABLE address OWNER TO postgres;

--
-- TOC entry 189 (class 1259 OID 16466)
-- Name: address_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE address_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE address_id_seq OWNER TO postgres;

--
-- TOC entry 185 (class 1259 OID 16394)
-- Name: client; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE client (
    id integer DEFAULT nextval(('public.client_id_seq'::text)::regclass) NOT NULL,
    first_name character varying(50) NOT NULL,
    last_name character varying(50) NOT NULL,
    patronumic character varying(50) NOT NULL,
    age integer NOT NULL
);


ALTER TABLE client OWNER TO postgres;

--
-- TOC entry 188 (class 1259 OID 16449)
-- Name: client_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE client_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE client_id_seq OWNER TO postgres;

--
-- TOC entry 187 (class 1259 OID 16439)
-- Name: tblname_colname_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE tblname_colname_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    MAXVALUE 100
    CACHE 1;


ALTER TABLE tblname_colname_seq OWNER TO postgres;

--
-- TOC entry 2140 (class 0 OID 16399)
-- Dependencies: 186
-- Data for Name: address; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY address (id, client_id, city) FROM stdin;
1	4	Dnepr
2	1	Odessa
3	3	Poltava
4	5	Kirovograd
5	15	Donetsk
\.


--
-- TOC entry 2151 (class 0 OID 0)
-- Dependencies: 189
-- Name: address_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('address_id_seq', 26, true);


--
-- TOC entry 2139 (class 0 OID 16394)
-- Dependencies: 185
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY client (id, first_name, last_name, patronumic, age) FROM stdin;
1	Inna	Pavliuk	Romanovna	20
3	Alex	Petrov	Petrovich	21
4	Anton	Lopatin	Ivanovich	32
5	Inna	Ivanova	Ivanovna	18
15	Oleg	Skachkov	Dmitrievich	32
\.


--
-- TOC entry 2152 (class 0 OID 0)
-- Dependencies: 188
-- Name: client_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('client_id_seq', 5, true);


--
-- TOC entry 2153 (class 0 OID 0)
-- Dependencies: 187
-- Name: tblname_colname_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('tblname_colname_seq', 1, false);


--
-- TOC entry 2020 (class 2606 OID 16469)
-- Name: address address_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY address
    ADD CONSTRAINT address_pkey PRIMARY KEY (id);


--
-- TOC entry 2017 (class 2606 OID 16452)
-- Name: client client_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY client
    ADD CONSTRAINT client_pkey PRIMARY KEY (id);


--
-- TOC entry 2018 (class 1259 OID 16406)
-- Name: address_client_id_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX address_client_id_key ON public.address USING btree (client_id);


--
-- TOC entry 2021 (class 2606 OID 16460)
-- Name: address address_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY address
    ADD CONSTRAINT address_fk FOREIGN KEY (client_id) REFERENCES client(id);


-- Completed on 2018-11-11 10:49:24

--
-- PostgreSQL database dump complete
--

