--
-- PostgreSQL database dump
--

-- Dumped from database version 14.13 (Homebrew)
-- Dumped by pg_dump version 14.13 (Homebrew)

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

DROP DATABASE salon;
--
-- Name: salon; Type: DATABASE; Schema: -; Owner: elliothill
--

CREATE DATABASE salon WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'C';


ALTER DATABASE salon OWNER TO elliothill;

\connect salon

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
-- Name: appointments; Type: TABLE; Schema: public; Owner: elliothill
--

CREATE TABLE public.appointments (
    appointment_id integer NOT NULL,
    service_id integer NOT NULL,
    customer_id integer,
    "time" character varying(30) NOT NULL
);


ALTER TABLE public.appointments OWNER TO elliothill;

--
-- Name: appointments_appointment_id_seq; Type: SEQUENCE; Schema: public; Owner: elliothill
--

CREATE SEQUENCE public.appointments_appointment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.appointments_appointment_id_seq OWNER TO elliothill;

--
-- Name: appointments_appointment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: elliothill
--

ALTER SEQUENCE public.appointments_appointment_id_seq OWNED BY public.appointments.appointment_id;


--
-- Name: customers; Type: TABLE; Schema: public; Owner: elliothill
--

CREATE TABLE public.customers (
    customer_id integer NOT NULL,
    phone character varying(16),
    name character varying(50) NOT NULL
);


ALTER TABLE public.customers OWNER TO elliothill;

--
-- Name: customers_customer_id_seq; Type: SEQUENCE; Schema: public; Owner: elliothill
--

CREATE SEQUENCE public.customers_customer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.customers_customer_id_seq OWNER TO elliothill;

--
-- Name: customers_customer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: elliothill
--

ALTER SEQUENCE public.customers_customer_id_seq OWNED BY public.customers.customer_id;


--
-- Name: services; Type: TABLE; Schema: public; Owner: elliothill
--

CREATE TABLE public.services (
    service_id integer NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE public.services OWNER TO elliothill;

--
-- Name: services_service_id_seq; Type: SEQUENCE; Schema: public; Owner: elliothill
--

CREATE SEQUENCE public.services_service_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.services_service_id_seq OWNER TO elliothill;

--
-- Name: services_service_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: elliothill
--

ALTER SEQUENCE public.services_service_id_seq OWNED BY public.services.service_id;


--
-- Name: appointments appointment_id; Type: DEFAULT; Schema: public; Owner: elliothill
--

ALTER TABLE ONLY public.appointments ALTER COLUMN appointment_id SET DEFAULT nextval('public.appointments_appointment_id_seq'::regclass);


--
-- Name: customers customer_id; Type: DEFAULT; Schema: public; Owner: elliothill
--

ALTER TABLE ONLY public.customers ALTER COLUMN customer_id SET DEFAULT nextval('public.customers_customer_id_seq'::regclass);


--
-- Name: services service_id; Type: DEFAULT; Schema: public; Owner: elliothill
--

ALTER TABLE ONLY public.services ALTER COLUMN service_id SET DEFAULT nextval('public.services_service_id_seq'::regclass);


--
-- Data for Name: appointments; Type: TABLE DATA; Schema: public; Owner: elliothill
--

INSERT INTO public.appointments VALUES (1, 1, 6, '10 am');
INSERT INTO public.appointments VALUES (2, 2, 4, '10:30');
INSERT INTO public.appointments VALUES (3, 1, 7, '10:30');
INSERT INTO public.appointments VALUES (4, 2, 7, '11am');
INSERT INTO public.appointments VALUES (5, 5, 8, '12:30');
INSERT INTO public.appointments VALUES (6, 2, 9, '3pm');


--
-- Data for Name: customers; Type: TABLE DATA; Schema: public; Owner: elliothill
--

INSERT INTO public.customers VALUES (2, '222-222-2222', 'Test');
INSERT INTO public.customers VALUES (3, '333-333-3333', 'Johnny Appleseed');
INSERT INTO public.customers VALUES (4, '111-1111', 'Maggie');
INSERT INTO public.customers VALUES (5, '123-123-1234', 'Henry');
INSERT INTO public.customers VALUES (6, '123-456-7890', 'Mary');
INSERT INTO public.customers VALUES (7, '555-555-5555', 'Fabio');
INSERT INTO public.customers VALUES (8, '234-2344', 'Maurice');
INSERT INTO public.customers VALUES (9, '234-234-2344', 'Amy');


--
-- Data for Name: services; Type: TABLE DATA; Schema: public; Owner: elliothill
--

INSERT INTO public.services VALUES (1, 'cut');
INSERT INTO public.services VALUES (2, 'blowout');
INSERT INTO public.services VALUES (3, 'color');
INSERT INTO public.services VALUES (4, 'style');
INSERT INTO public.services VALUES (5, 'trim');


--
-- Name: appointments_appointment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: elliothill
--

SELECT pg_catalog.setval('public.appointments_appointment_id_seq', 6, true);


--
-- Name: customers_customer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: elliothill
--

SELECT pg_catalog.setval('public.customers_customer_id_seq', 9, true);


--
-- Name: services_service_id_seq; Type: SEQUENCE SET; Schema: public; Owner: elliothill
--

SELECT pg_catalog.setval('public.services_service_id_seq', 5, true);


--
-- Name: appointments appointments_pkey; Type: CONSTRAINT; Schema: public; Owner: elliothill
--

ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT appointments_pkey PRIMARY KEY (appointment_id);


--
-- Name: customers customers_phone_key; Type: CONSTRAINT; Schema: public; Owner: elliothill
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_phone_key UNIQUE (phone);


--
-- Name: customers customers_pkey; Type: CONSTRAINT; Schema: public; Owner: elliothill
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (customer_id);


--
-- Name: services services_pkey; Type: CONSTRAINT; Schema: public; Owner: elliothill
--

ALTER TABLE ONLY public.services
    ADD CONSTRAINT services_pkey PRIMARY KEY (service_id);


--
-- Name: appointments appointments_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: elliothill
--

ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT appointments_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customers(customer_id);


--
-- Name: appointments appointments_service_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: elliothill
--

ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT appointments_service_id_fkey FOREIGN KEY (service_id) REFERENCES public.services(service_id);


--
-- PostgreSQL database dump complete
--

