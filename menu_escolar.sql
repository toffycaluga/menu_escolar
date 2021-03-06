--
-- PostgreSQL database dump
--

-- Dumped from database version 14.1
-- Dumped by pg_dump version 14.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders (
    id integer NOT NULL,
    date timestamp without time zone NOT NULL,
    is_rectified boolean DEFAULT false,
    observations character varying(1024),
    school_id integer NOT NULL,
    vegetarian integer NOT NULL,
    vegetarian_real integer DEFAULT 0,
    celiac integer NOT NULL,
    celiac_real integer DEFAULT 0,
    standart integer NOT NULL,
    standar_real integer DEFAULT 0,
    caloric integer NOT NULL,
    caloric_real integer DEFAULT 0,
    ethnic integer NOT NULL,
    ethnic_real integer DEFAULT 0
);


ALTER TABLE public.orders OWNER TO postgres;

--
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.orders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.orders_id_seq OWNER TO postgres;

--
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;


--
-- Name: schools; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.schools (
    id integer NOT NULL,
    name character varying(45) NOT NULL,
    email character varying(45) NOT NULL,
    password character varying(255) NOT NULL,
    es_admin boolean
);


ALTER TABLE public.schools OWNER TO postgres;

--
-- Name: schools_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.schools_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.schools_id_seq OWNER TO postgres;

--
-- Name: schools_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.schools_id_seq OWNED BY public.schools.id;


--
-- Name: orders id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);


--
-- Name: schools id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schools ALTER COLUMN id SET DEFAULT nextval('public.schools_id_seq'::regclass);


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orders (id, date, is_rectified, observations, school_id, vegetarian, vegetarian_real, celiac, celiac_real, standart, standar_real, caloric, caloric_real, ethnic, ethnic_real) FROM stdin;
4	2022-07-14 00:00:00	f	\N	2	30	0	16	0	18	0	30	0	29	0
2	2022-07-14 00:00:00	t	todo ok	2	17	15	12	10	13	5	15	12	12	11
3	2022-08-10 00:00:00	t	wasfs	2	50	12	15	12	80	12	20	12	15	12
5	2022-07-13 00:00:00	f	\N	3	52	0	65	0	65	0	22	0	45	0
\.


--
-- Data for Name: schools; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.schools (id, name, email, password, es_admin) FROM stdin;
1	Admin Junaeb	admin@junaeb.cl	$2b$10$UvdixLtZqQZFPBfVtd8Z0.baspf7ZbI9uFvdP.COEUxSS/2XHDQ1.	t
2	escuela de prueba	test@test.cl	$2b$10$kJVgkX7Nm97vobo0e8gf6e1zm7QhiQN6ouH/huUTDapwmaEazTf/K	\N
3	escuela 2 de prueba	test2@test.cl	$2b$10$NDUzTFPKNwzS4YNU6XmOwute.6HePeZ6pFdRVaGpIIqI57PdGQP56	\N
\.


--
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.orders_id_seq', 5, true);


--
-- Name: schools_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.schools_id_seq', 3, true);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: schools schools_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schools
    ADD CONSTRAINT schools_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

