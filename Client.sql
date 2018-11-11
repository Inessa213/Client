--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.10
-- Dumped by pg_dump version 9.6.0

-- Started on 2018-11-11 20:40:45

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
-- TOC entry 2154 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- TOC entry 205 (class 1255 OID 16547)
-- Name: add_address_fn(text, text, text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION add_address_fn(first_name1 text, last_name1 text, patronumic1 text, city text) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
id1 integer; 
id_client integer;
begin
	id_client = (
    select id from client as c
		WHERE
  			c.first_name = first_name1 AND 
  			c.last_name = last_name1 AND 
  			c.patronumic = patronumic1);
	   	      
      if (id_client is NULL) then
      	RAISE EXCEPTION 'Клиент не найден! '; 
      else
      	id1 = nextval('address_id_seq');
		insert into address (id, city, client_id) values (id1, city, id_client);
      end if;
end
$$;


ALTER FUNCTION public.add_address_fn(first_name1 text, last_name1 text, patronumic1 text, city text) OWNER TO postgres;

--
-- TOC entry 202 (class 1255 OID 16539)
-- Name: add_client_fn(text, text, text, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION add_client_fn(first_name text, last_name text, patronumic text, age integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
id1 integer; 

begin 
id1 = nextval('client_id_seq');   
    insert into client (id, first_name, last_name, patronumic, age) 
		   values (id1, first_name, last_name, patronumic, age);
end
$$;


ALTER FUNCTION public.add_client_fn(first_name text, last_name text, patronumic text, age integer) OWNER TO postgres;

--
-- TOC entry 204 (class 1255 OID 16541)
-- Name: get_client_by_name_fn(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION get_client_by_name_fn(first_name1 text) RETURNS TABLE(id integer, first_name text, last_name text, patronumic text, age integer)
    LANGUAGE sql
    AS $$
    select c.id, c.first_name, c.last_name, c.patronumic, c.age from client as c
    where c.first_name = first_name1;
$$;


ALTER FUNCTION public.get_client_by_name_fn(first_name1 text) OWNER TO postgres;

--
-- TOC entry 203 (class 1255 OID 16542)
-- Name: get_older_client_fn(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION get_older_client_fn() RETURNS TABLE(first_name text, last_name text, patronumic text, age integer)
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
    city text DEFAULT NULL::character varying
);


ALTER TABLE address OWNER TO postgres;

--
-- TOC entry 188 (class 1259 OID 16466)
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
    first_name text NOT NULL,
    last_name text NOT NULL,
    patronumic text NOT NULL,
    age integer NOT NULL
);


ALTER TABLE client OWNER TO postgres;

--
-- TOC entry 187 (class 1259 OID 16449)
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
-- TOC entry 189 (class 1259 OID 16506)
-- Name: test; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE test (
    id integer
);


ALTER TABLE test OWNER TO postgres;

--
-- TOC entry 2144 (class 0 OID 16399)
-- Dependencies: 186
-- Data for Name: address; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY address (id, client_id, city) FROM stdin;
1	4	Dnepr
2	1	Odessa
3	3	Poltava
4	5	Kirovograd
5	15	Donetsk
41	6	Kiev
\.


--
-- TOC entry 2155 (class 0 OID 0)
-- Dependencies: 188
-- Name: address_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('address_id_seq', 41, true);


--
-- TOC entry 2143 (class 0 OID 16394)
-- Dependencies: 185
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY client (id, first_name, last_name, patronumic, age) FROM stdin;
1	Inna	Pavliuk	Romanovna	20
3	Alex	Petrov	Petrovich	21
4	Anton	Lopatin	Ivanovich	32
5	Inna	Ivanova	Ivanovna	18
15	Oleg	Skachkov	Dmitrievich	32
6	Anna	Andreeva	Olegovna	25
\.


--
-- TOC entry 2156 (class 0 OID 0)
-- Dependencies: 187
-- Name: client_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('client_id_seq', 6, true);


--
-- TOC entry 2147 (class 0 OID 16506)
-- Dependencies: 189
-- Data for Name: test; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY test (id) FROM stdin;
6
7
\.


--
-- TOC entry 2024 (class 2606 OID 16469)
-- Name: address address_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY address
    ADD CONSTRAINT address_pkey PRIMARY KEY (id);


--
-- TOC entry 2021 (class 2606 OID 16452)
-- Name: client client_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY client
    ADD CONSTRAINT client_pkey PRIMARY KEY (id);


--
-- TOC entry 2022 (class 1259 OID 16406)
-- Name: address_client_id_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX address_client_id_key ON public.address USING btree (client_id);


--
-- TOC entry 2025 (class 2606 OID 16460)
-- Name: address address_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY address
    ADD CONSTRAINT address_fk FOREIGN KEY (client_id) REFERENCES client(id);


-- Completed on 2018-11-11 20:40:49

--
-- PostgreSQL database dump complete
--

