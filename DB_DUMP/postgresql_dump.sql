--
-- PostgreSQL database dump
--

-- Dumped from database version 9.1.13
-- Dumped by pg_dump version 9.1.13
-- Started on 2014-11-23 18:53:19 EET

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 1898 (class 1262 OID 16384)
-- Name: mydb; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE mydb WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.UTF-8' LC_CTYPE = 'en_US.UTF-8';


ALTER DATABASE mydb OWNER TO postgres;

\connect mydb

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 163 (class 3079 OID 11679)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 1901 (class 0 OID 0)
-- Dependencies: 163
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- TOC entry 175 (class 1255 OID 16385)
-- Dependencies: 490 6
-- Name: save_to_db(text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION save_to_db(newname text, newauthor text) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    LOOP
        -- first try to update the key
        UPDATE book SET inserted_at = CURRENT_DATE WHERE name = newname AND author = newauthor;
        IF found THEN
            RETURN;
        END IF;
        -- not there, so try to insert the key
        -- if someone else inserts the same key concurrently,
        -- we could get a unique-key failure
        BEGIN
            INSERT INTO book(name, author, inserted_at) VALUES (newname, newauthor, CURRENT_DATE);
            RETURN;
        EXCEPTION WHEN unique_violation THEN
            -- Do nothing, and loop to try the UPDATE again.
        END;
    END LOOP;
END;
$$;


ALTER FUNCTION public.save_to_db(newname text, newauthor text) OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 161 (class 1259 OID 16386)
-- Dependencies: 1421 1421 6
-- Name: book; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE book (
    id integer NOT NULL,
    name text COLLATE pg_catalog."C.UTF-8",
    author text COLLATE pg_catalog."C.UTF-8",
    inserted_at date
);


ALTER TABLE public.book OWNER TO postgres;

--
-- TOC entry 162 (class 1259 OID 16392)
-- Dependencies: 161 6
-- Name: book_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE book_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.book_id_seq OWNER TO postgres;

--
-- TOC entry 1902 (class 0 OID 0)
-- Dependencies: 162
-- Name: book_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE book_id_seq OWNED BY book.id;


--
-- TOC entry 1787 (class 2604 OID 16394)
-- Dependencies: 162 161
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY book ALTER COLUMN id SET DEFAULT nextval('book_id_seq'::regclass);


--
-- TOC entry 1892 (class 0 OID 16386)
-- Dependencies: 161 1894
-- Data for Name: book; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO book VALUES (6, 'Име на книга 6', 'Автор 6', '2014-11-23');
INSERT INTO book VALUES (7, 'ホテル予約サービスへようこそ。当社では北京のホテルを 71', '日本国 71', '2014-11-23');
INSERT INTO book VALUES (8, '当社では北京のホテルを 8', '日本国 8', '2014-11-23');
INSERT INTO book VALUES (9, 'Име на книга 1', 'Автор 1', '2014-11-23');
INSERT INTO book VALUES (10, 'Име на книга 3', 'Автор 3', '2014-11-23');
INSERT INTO book VALUES (11, 'Име на книга 4', 'Автор 4', '2014-11-23');
INSERT INTO book VALUES (12, 'Име на книга 0', 'Автор 0', '2014-11-23');
INSERT INTO book VALUES (13, 'Име на книга 5', 'Автор 5', '2014-11-23');
INSERT INTO book VALUES (14, 'Име на книга 7', 'Автор 7', '2014-11-23');
INSERT INTO book VALUES (15, 'Име на книга 8', 'Автор 8', '2014-11-23');
INSERT INTO book VALUES (16, 'Име на книга 9', 'Автор 9', '2014-11-23');
INSERT INTO book VALUES (17, 'Име на книга 10', 'Автор 10', '2014-11-23');
INSERT INTO book VALUES (18, 'Име на книга 11', 'Автор 11', '2014-11-23');
INSERT INTO book VALUES (19, 'Име на книга 12', 'Автор 12', '2014-11-23');
INSERT INTO book VALUES (20, 'Име на книга 13', 'Автор 13', '2014-11-23');
INSERT INTO book VALUES (21, 'Име на книга 14', 'Автор 14', '2014-11-23');
INSERT INTO book VALUES (22, 'Име на книга 15', 'Автор 15', '2014-11-23');
INSERT INTO book VALUES (23, 'Име на книга 16', 'Автор 16', '2014-11-23');
INSERT INTO book VALUES (24, 'Име на книга 17', 'Автор 17', '2014-11-23');
INSERT INTO book VALUES (25, 'Име на книга 18', 'Автор 18', '2014-11-23');
INSERT INTO book VALUES (26, 'Име на книга 19', 'Автор 19', '2014-11-23');
INSERT INTO book VALUES (27, 'Име на книга 20', 'Автор 20', '2014-11-23');
INSERT INTO book VALUES (28, 'Име на книга 21', 'Автор 21', '2014-11-23');
INSERT INTO book VALUES (29, 'Име на книга 22', 'Автор 22', '2014-11-23');
INSERT INTO book VALUES (30, 'Име на книга 23', 'Автор 23', '2014-11-23');
INSERT INTO book VALUES (31, 'Име на книга 24', 'Автор 24', '2014-11-23');
INSERT INTO book VALUES (32, 'Име на книга 25', 'Автор 25', '2014-11-23');
INSERT INTO book VALUES (33, 'Име на книга 26', 'Автор 26', '2014-11-23');
INSERT INTO book VALUES (34, 'Име на книга 27', 'Автор 27', '2014-11-23');
INSERT INTO book VALUES (35, 'Име на книга 28', 'Автор 28', '2014-11-23');
INSERT INTO book VALUES (36, 'Име на книга 29', 'Автор 29', '2014-11-23');
INSERT INTO book VALUES (37, 'Име на книга 30', 'Автор 30', '2014-11-23');
INSERT INTO book VALUES (38, 'Име на книга 31', 'Автор 31', '2014-11-23');
INSERT INTO book VALUES (39, 'Име на книга 32', 'Автор 32', '2014-11-23');
INSERT INTO book VALUES (40, 'Име на книга 33', 'Автор 33', '2014-11-23');
INSERT INTO book VALUES (41, 'Име на книга 34', 'Автор 34', '2014-11-23');
INSERT INTO book VALUES (42, 'Име на книга 35', 'Автор 35', '2014-11-23');
INSERT INTO book VALUES (43, 'Име на книга 36', 'Автор 36', '2014-11-23');
INSERT INTO book VALUES (44, 'Име на книга 37', 'Автор 37', '2014-11-23');
INSERT INTO book VALUES (45, 'Име на книга 38', 'Автор 38', '2014-11-23');
INSERT INTO book VALUES (46, 'Име на книга 39', 'Автор 39', '2014-11-23');
INSERT INTO book VALUES (47, 'Име на книга 40', 'Автор 40', '2014-11-23');
INSERT INTO book VALUES (48, 'Име на книга 41', 'Автор 41', '2014-11-23');
INSERT INTO book VALUES (49, 'Име на книга 42', 'Автор 42', '2014-11-23');
INSERT INTO book VALUES (51, 'Име на книга 44', 'Автор 44', '2014-11-23');
INSERT INTO book VALUES (52, 'Име на книга 45', 'Автор 45', '2014-11-23');
INSERT INTO book VALUES (53, 'Име на книга 46', 'Автор 46', '2014-11-23');
INSERT INTO book VALUES (54, 'Име на книга 47', 'Автор 47', '2014-11-23');
INSERT INTO book VALUES (55, 'Име на книга 48', 'Автор 48', '2014-11-23');
INSERT INTO book VALUES (56, 'Име на книга 49', 'Автор 49', '2014-11-23');
INSERT INTO book VALUES (57, 'Име на книга 50', 'Автор 50', '2014-11-23');
INSERT INTO book VALUES (58, 'Име на книга 51', 'Автор 51', '2014-11-23');
INSERT INTO book VALUES (59, 'Име на книга 52', 'Автор 52', '2014-11-23');
INSERT INTO book VALUES (60, 'Име на книга 53', 'Автор 53', '2014-11-23');
INSERT INTO book VALUES (61, 'Име на книга 54', 'Автор 54', '2014-11-23');
INSERT INTO book VALUES (62, 'Име на книга 55', 'Автор 55', '2014-11-23');
INSERT INTO book VALUES (63, 'Име на книга 56', 'Автор 56', '2014-11-23');
INSERT INTO book VALUES (64, 'Име на книга 57', 'Автор 57', '2014-11-23');
INSERT INTO book VALUES (65, 'Име на книга 58', 'Автор 58', '2014-11-23');
INSERT INTO book VALUES (66, 'Име на книга 59', 'Автор 59', '2014-11-23');
INSERT INTO book VALUES (67, 'Име на книга 60', 'Автор 60', '2014-11-23');
INSERT INTO book VALUES (68, 'Име на книга 61', 'Автор 61', '2014-11-23');
INSERT INTO book VALUES (70, 'Име на книга 63', 'Автор 63', '2014-11-23');
INSERT INTO book VALUES (71, 'Име на книга 64', 'Автор 64', '2014-11-23');
INSERT INTO book VALUES (72, 'Име на книга 65', 'Автор 65', '2014-11-23');
INSERT INTO book VALUES (73, 'Име на книга 66', 'Автор 66', '2014-11-23');
INSERT INTO book VALUES (74, 'Име на книга 67', 'Автор 67', '2014-11-23');
INSERT INTO book VALUES (75, 'Име на книга 68', 'Автор 68', '2014-11-23');
INSERT INTO book VALUES (76, 'Име на книга 69', 'Автор 69', '2014-11-23');
INSERT INTO book VALUES (77, 'Име на книга 70', 'Автор 70', '2014-11-23');
INSERT INTO book VALUES (78, 'Име на книга 71', 'Автор 71', '2014-11-23');
INSERT INTO book VALUES (79, 'Име на книга 72', 'Автор 72', '2014-11-23');
INSERT INTO book VALUES (80, 'Име на книга 73', 'Автор 73', '2014-11-23');
INSERT INTO book VALUES (81, 'Име на книга 74', 'Автор 74', '2014-11-23');
INSERT INTO book VALUES (82, 'Име на книга 75', 'Автор 75', '2014-11-23');
INSERT INTO book VALUES (83, 'Име на книга 76', 'Автор 76', '2014-11-23');
INSERT INTO book VALUES (84, 'Име на книга 77', 'Автор 77', '2014-11-23');
INSERT INTO book VALUES (85, 'Име на книга 78', 'Автор 78', '2014-11-23');
INSERT INTO book VALUES (86, 'Име на книга 79', 'Автор 79', '2014-11-23');
INSERT INTO book VALUES (87, 'Име на книга 80', 'Автор 80', '2014-11-23');
INSERT INTO book VALUES (89, 'Име на книга 82', 'Автор 82', '2014-11-23');
INSERT INTO book VALUES (90, 'Име на книга 83', 'Автор 83', '2014-11-23');
INSERT INTO book VALUES (91, 'Име на книга 84', 'Автор 84', '2014-11-23');
INSERT INTO book VALUES (92, 'Име на книга 85', 'Автор 85', '2014-11-23');
INSERT INTO book VALUES (93, 'Име на книга 86', 'Автор 86', '2014-11-23');
INSERT INTO book VALUES (94, 'Име на книга 87', 'Автор 87', '2014-11-23');
INSERT INTO book VALUES (95, 'Име на книга 88', 'Автор 88', '2014-11-23');
INSERT INTO book VALUES (96, 'Име на книга 89', 'Автор 89', '2014-11-23');
INSERT INTO book VALUES (97, 'Име на книга 90', 'Автор 90', '2014-11-23');
INSERT INTO book VALUES (98, 'Име на книга 91', 'Автор 91', '2014-11-23');
INSERT INTO book VALUES (99, 'Име на книга 92', 'Автор 92', '2014-11-23');
INSERT INTO book VALUES (100, 'Име на книга 93', 'Автор 93', '2014-11-23');
INSERT INTO book VALUES (101, 'Име на книга 94', 'Автор 94', '2014-11-23');
INSERT INTO book VALUES (102, 'Име на книга 95', 'Автор 95', '2014-11-23');
INSERT INTO book VALUES (103, 'Име на книга 96', 'Автор 96', '2014-11-23');
INSERT INTO book VALUES (104, 'Име на книга 97', 'Автор 97', '2014-11-23');
INSERT INTO book VALUES (105, 'Име на книга 98', 'Автор 98', '2014-11-23');
INSERT INTO book VALUES (2, 'Име на книга 2', 'Автор 2', '2014-11-23');
INSERT INTO book VALUES (4, 'Име на книга 4', 'Author 4', '2014-11-23');
INSERT INTO book VALUES (109, 'Име на книга 102', 'Автор 102', '2014-11-23');
INSERT INTO book VALUES (110, 'Име на книга 103', 'Автор 103', '2014-11-23');
INSERT INTO book VALUES (111, 'Име на книга 104', 'Автор 104', '2014-11-23');
INSERT INTO book VALUES (113, 'Име на книга 106', 'Автор 106', '2014-11-23');
INSERT INTO book VALUES (114, 'Име на книга 107', 'Автор 107', '2014-11-23');
INSERT INTO book VALUES (115, 'Име на книга 108', 'Автор 108', '2014-11-23');
INSERT INTO book VALUES (116, 'Име на книга 109', 'Автор 109', '2014-11-23');
INSERT INTO book VALUES (117, 'Име на книга 110', 'Автор 110', '2014-11-23');
INSERT INTO book VALUES (118, 'Име на книга 111', 'Автор 111', '2014-11-23');
INSERT INTO book VALUES (119, 'Име на книга 112', 'Автор 112', '2014-11-23');
INSERT INTO book VALUES (120, 'Име на книга 113', 'Автор 113', '2014-11-23');
INSERT INTO book VALUES (121, 'Име на книга 114', 'Автор 114', '2014-11-23');
INSERT INTO book VALUES (122, 'Име на книга 115', 'Автор 115', '2014-11-23');
INSERT INTO book VALUES (123, 'Име на книга 116', 'Автор 116', '2014-11-23');
INSERT INTO book VALUES (124, 'Име на книга 117', 'Автор 117', '2014-11-23');
INSERT INTO book VALUES (125, 'Име на книга 118', 'Автор 118', '2014-11-23');
INSERT INTO book VALUES (126, 'Име на книга 119', 'Автор 119', '2014-11-23');
INSERT INTO book VALUES (127, 'Име на книга 120', 'Автор 120', '2014-11-23');
INSERT INTO book VALUES (128, 'Име на книга 121', 'Автор 121', '2014-11-23');
INSERT INTO book VALUES (129, 'Име на книга 122', 'Автор 122', '2014-11-23');
INSERT INTO book VALUES (130, 'Име на книга 123', 'Автор 123', '2014-11-23');
INSERT INTO book VALUES (131, 'Име на книга 124', 'Автор 124', '2014-11-23');
INSERT INTO book VALUES (132, 'Име на книга 125', 'Автор 125', '2014-11-23');
INSERT INTO book VALUES (134, 'Име на книга 127', 'Автор 127', '2014-11-23');
INSERT INTO book VALUES (135, 'Име на книга 128', 'Автор 128', '2014-11-23');
INSERT INTO book VALUES (136, 'Име на книга 129', 'Автор 129', '2014-11-23');
INSERT INTO book VALUES (137, 'Име на книга 130', 'Автор 130', '2014-11-23');
INSERT INTO book VALUES (138, 'Име на книга 131', 'Автор 131', '2014-11-23');
INSERT INTO book VALUES (139, 'Име на книга 132', 'Автор 132', '2014-11-23');
INSERT INTO book VALUES (140, 'Име на книга 133', 'Автор 133', '2014-11-23');
INSERT INTO book VALUES (141, 'Име на книга 134', 'Автор 134', '2014-11-23');
INSERT INTO book VALUES (142, 'Име на книга 135', 'Автор 135', '2014-11-23');
INSERT INTO book VALUES (143, 'Име на книга 136', 'Автор 136', '2014-11-23');
INSERT INTO book VALUES (144, 'Име на книга 137', 'Автор 137', '2014-11-23');
INSERT INTO book VALUES (145, 'Име на книга 138', 'Автор 138', '2014-11-23');
INSERT INTO book VALUES (146, 'Име на книга 139', 'Автор 139', '2014-11-23');
INSERT INTO book VALUES (147, 'Име на книга 140', 'Автор 140', '2014-11-23');
INSERT INTO book VALUES (148, 'Име на книга 141', 'Автор 141', '2014-11-23');
INSERT INTO book VALUES (149, 'Име на книга 142', 'Автор 142', '2014-11-23');
INSERT INTO book VALUES (150, 'Име на книга 143', 'Автор 143', '2014-11-23');
INSERT INTO book VALUES (151, 'Име на книга 144', 'Автор 144', '2014-11-23');
INSERT INTO book VALUES (152, 'Име на книга 145', 'Автор 145', '2014-11-23');
INSERT INTO book VALUES (153, 'Име на книга 146', 'Автор 146', '2014-11-23');
INSERT INTO book VALUES (155, 'Име на книга 148', 'Автор 148', '2014-11-23');
INSERT INTO book VALUES (156, 'Име на книга 149', 'Автор 149', '2014-11-23');
INSERT INTO book VALUES (157, 'Име на книга 150', 'Автор 150', '2014-11-23');
INSERT INTO book VALUES (158, 'Име на книга 151', 'Автор 151', '2014-11-23');
INSERT INTO book VALUES (159, 'Име на книга 152', 'Автор 152', '2014-11-23');
INSERT INTO book VALUES (160, 'Име на книга 153', 'Автор 153', '2014-11-23');
INSERT INTO book VALUES (161, 'Име на книга 154', 'Автор 154', '2014-11-23');
INSERT INTO book VALUES (162, 'Име на книга 155', 'Автор 155', '2014-11-23');
INSERT INTO book VALUES (163, 'Име на книга 156', 'Автор 156', '2014-11-23');
INSERT INTO book VALUES (164, 'Име на книга 157', 'Автор 157', '2014-11-23');
INSERT INTO book VALUES (165, 'Име на книга 158', 'Автор 158', '2014-11-23');
INSERT INTO book VALUES (166, 'Име на книга 159', 'Автор 159', '2014-11-23');
INSERT INTO book VALUES (167, 'Име на книга 160', 'Автор 160', '2014-11-23');
INSERT INTO book VALUES (168, 'Име на книга 161', 'Автор 161', '2014-11-23');
INSERT INTO book VALUES (169, 'Име на книга 162', 'Автор 162', '2014-11-23');
INSERT INTO book VALUES (170, 'Име на книга 163', 'Автор 163', '2014-11-23');
INSERT INTO book VALUES (171, 'Име на книга 164', 'Автор 164', '2014-11-23');
INSERT INTO book VALUES (172, 'Име на книга 165', 'Автор 165', '2014-11-23');
INSERT INTO book VALUES (173, 'Име на книга 166', 'Автор 166', '2014-11-23');
INSERT INTO book VALUES (174, 'Име на книга 167', 'Автор 167', '2014-11-23');
INSERT INTO book VALUES (176, 'Име на книга 169', 'Автор 169', '2014-11-23');
INSERT INTO book VALUES (177, 'Име на книга 170', 'Автор 170', '2014-11-23');
INSERT INTO book VALUES (178, 'Име на книга 171', 'Автор 171', '2014-11-23');
INSERT INTO book VALUES (179, 'Име на книга 172', 'Автор 172', '2014-11-23');
INSERT INTO book VALUES (180, 'Име на книга 173', 'Автор 173', '2014-11-23');
INSERT INTO book VALUES (181, 'Име на книга 174', 'Автор 174', '2014-11-23');
INSERT INTO book VALUES (182, 'Име на книга 175', 'Автор 175', '2014-11-23');
INSERT INTO book VALUES (183, 'Име на книга 176', 'Автор 176', '2014-11-23');
INSERT INTO book VALUES (184, 'Име на книга 177', 'Автор 177', '2014-11-23');
INSERT INTO book VALUES (185, 'Име на книга 178', 'Автор 178', '2014-11-23');
INSERT INTO book VALUES (186, 'Име на книга 179', 'Автор 179', '2014-11-23');
INSERT INTO book VALUES (187, 'Име на книга 180', 'Автор 180', '2014-11-23');
INSERT INTO book VALUES (188, 'Име на книга 181', 'Автор 181', '2014-11-23');
INSERT INTO book VALUES (189, 'Име на книга 182', 'Автор 182', '2014-11-23');
INSERT INTO book VALUES (190, 'Име на книга 183', 'Автор 183', '2014-11-23');
INSERT INTO book VALUES (191, 'Име на книга 184', 'Автор 184', '2014-11-23');
INSERT INTO book VALUES (192, 'Име на книга 185', 'Автор 185', '2014-11-23');
INSERT INTO book VALUES (193, 'Име на книга 186', 'Автор 186', '2014-11-23');
INSERT INTO book VALUES (194, 'Име на книга 187', 'Автор 187', '2014-11-23');
INSERT INTO book VALUES (195, 'Име на книга 188', 'Автор 188', '2014-11-23');
INSERT INTO book VALUES (197, 'Име на книга 190', 'Автор 190', '2014-11-23');
INSERT INTO book VALUES (198, 'Име на книга 191', 'Автор 191', '2014-11-23');
INSERT INTO book VALUES (199, 'Име на книга 192', 'Автор 192', '2014-11-23');
INSERT INTO book VALUES (200, 'Име на книга 193', 'Автор 193', '2014-11-23');
INSERT INTO book VALUES (201, 'Име на книга 194', 'Автор 194', '2014-11-23');
INSERT INTO book VALUES (202, 'Име на книга 195', 'Автор 195', '2014-11-23');
INSERT INTO book VALUES (107, 'Име на книга 100', 'Автор 100', '2014-11-23');
INSERT INTO book VALUES (108, 'Име на книга 101', 'Автор 101', '2014-11-23');
INSERT INTO book VALUES (206, 'Име на книга 199', 'Автор 199', '2014-11-23');
INSERT INTO book VALUES (207, 'Име на книга 200', 'Автор 200', '2014-11-23');
INSERT INTO book VALUES (208, 'Име на книга 201', 'Автор 201', '2014-11-23');
INSERT INTO book VALUES (210, 'Име на книга 203', 'Автор 203', '2014-11-23');
INSERT INTO book VALUES (211, 'Име на книга 204', 'Автор 204', '2014-11-23');
INSERT INTO book VALUES (212, 'Име на книга 205', 'Автор 205', '2014-11-23');
INSERT INTO book VALUES (213, 'Име на книга 206', 'Автор 206', '2014-11-23');
INSERT INTO book VALUES (214, 'Име на книга 207', 'Автор 207', '2014-11-23');
INSERT INTO book VALUES (215, 'Име на книга 208', 'Автор 208', '2014-11-23');
INSERT INTO book VALUES (216, 'Име на книга 209', 'Автор 209', '2014-11-23');
INSERT INTO book VALUES (217, 'Име на книга 210', 'Автор 210', '2014-11-23');
INSERT INTO book VALUES (218, 'Име на книга 211', 'Автор 211', '2014-11-23');
INSERT INTO book VALUES (219, 'Име на книга 212', 'Автор 212', '2014-11-23');
INSERT INTO book VALUES (220, 'Име на книга 213', 'Автор 213', '2014-11-23');
INSERT INTO book VALUES (221, 'Име на книга 214', 'Автор 214', '2014-11-23');
INSERT INTO book VALUES (222, 'Име на книга 215', 'Автор 215', '2014-11-23');
INSERT INTO book VALUES (223, 'Име на книга 216', 'Автор 216', '2014-11-23');
INSERT INTO book VALUES (224, 'Име на книга 217', 'Автор 217', '2014-11-23');
INSERT INTO book VALUES (225, 'Име на книга 218', 'Автор 218', '2014-11-23');
INSERT INTO book VALUES (226, 'Име на книга 219', 'Автор 219', '2014-11-23');
INSERT INTO book VALUES (227, 'Име на книга 220', 'Автор 220', '2014-11-23');
INSERT INTO book VALUES (228, 'Име на книга 221', 'Автор 221', '2014-11-23');
INSERT INTO book VALUES (229, 'Име на книга 222', 'Автор 222', '2014-11-23');
INSERT INTO book VALUES (231, 'Име на книга 224', 'Автор 224', '2014-11-23');
INSERT INTO book VALUES (232, 'Име на книга 225', 'Автор 225', '2014-11-23');
INSERT INTO book VALUES (233, 'Име на книга 226', 'Автор 226', '2014-11-23');
INSERT INTO book VALUES (234, 'Име на книга 227', 'Автор 227', '2014-11-23');
INSERT INTO book VALUES (235, 'Име на книга 228', 'Автор 228', '2014-11-23');
INSERT INTO book VALUES (236, 'Име на книга 229', 'Автор 229', '2014-11-23');
INSERT INTO book VALUES (237, 'Име на книга 230', 'Автор 230', '2014-11-23');
INSERT INTO book VALUES (238, 'Име на книга 231', 'Автор 231', '2014-11-23');
INSERT INTO book VALUES (239, 'Име на книга 232', 'Автор 232', '2014-11-23');
INSERT INTO book VALUES (240, 'Име на книга 233', 'Автор 233', '2014-11-23');
INSERT INTO book VALUES (241, 'Име на книга 234', 'Автор 234', '2014-11-23');
INSERT INTO book VALUES (242, 'Име на книга 235', 'Автор 235', '2014-11-23');
INSERT INTO book VALUES (243, 'Име на книга 236', 'Автор 236', '2014-11-23');
INSERT INTO book VALUES (244, 'Име на книга 237', 'Автор 237', '2014-11-23');
INSERT INTO book VALUES (245, 'Име на книга 238', 'Автор 238', '2014-11-23');
INSERT INTO book VALUES (246, 'Име на книга 239', 'Автор 239', '2014-11-23');
INSERT INTO book VALUES (247, 'Име на книга 240', 'Автор 240', '2014-11-23');
INSERT INTO book VALUES (248, 'Име на книга 241', 'Автор 241', '2014-11-23');
INSERT INTO book VALUES (249, 'Име на книга 242', 'Автор 242', '2014-11-23');
INSERT INTO book VALUES (250, 'Име на книга 243', 'Автор 243', '2014-11-23');
INSERT INTO book VALUES (252, 'Име на книга 245', 'Автор 245', '2014-11-23');
INSERT INTO book VALUES (253, 'Име на книга 246', 'Автор 246', '2014-11-23');
INSERT INTO book VALUES (254, 'Име на книга 247', 'Автор 247', '2014-11-23');
INSERT INTO book VALUES (255, 'Име на книга 248', 'Автор 248', '2014-11-23');
INSERT INTO book VALUES (256, 'Име на книга 249', 'Автор 249', '2014-11-23');
INSERT INTO book VALUES (257, 'Име на книга 250', 'Автор 250', '2014-11-23');
INSERT INTO book VALUES (258, 'Име на книга 251', 'Автор 251', '2014-11-23');
INSERT INTO book VALUES (259, 'Име на книга 252', 'Автор 252', '2014-11-23');
INSERT INTO book VALUES (260, 'Име на книга 253', 'Автор 253', '2014-11-23');
INSERT INTO book VALUES (261, 'Име на книга 254', 'Автор 254', '2014-11-23');
INSERT INTO book VALUES (262, 'Име на книга 255', 'Автор 255', '2014-11-23');
INSERT INTO book VALUES (263, 'Име на книга 256', 'Автор 256', '2014-11-23');
INSERT INTO book VALUES (264, 'Име на книга 257', 'Автор 257', '2014-11-23');
INSERT INTO book VALUES (265, 'Име на книга 258', 'Автор 258', '2014-11-23');
INSERT INTO book VALUES (266, 'Име на книга 259', 'Автор 259', '2014-11-23');
INSERT INTO book VALUES (267, 'Име на книга 260', 'Автор 260', '2014-11-23');
INSERT INTO book VALUES (268, 'Име на книга 261', 'Автор 261', '2014-11-23');
INSERT INTO book VALUES (269, 'Име на книга 262', 'Автор 262', '2014-11-23');
INSERT INTO book VALUES (270, 'Име на книга 263', 'Автор 263', '2014-11-23');
INSERT INTO book VALUES (271, 'Име на книга 264', 'Автор 264', '2014-11-23');
INSERT INTO book VALUES (273, 'Име на книга 266', 'Автор 266', '2014-11-23');
INSERT INTO book VALUES (274, 'Име на книга 267', 'Автор 267', '2014-11-23');
INSERT INTO book VALUES (275, 'Име на книга 268', 'Автор 268', '2014-11-23');
INSERT INTO book VALUES (276, 'Име на книга 269', 'Автор 269', '2014-11-23');
INSERT INTO book VALUES (277, 'Име на книга 270', 'Автор 270', '2014-11-23');
INSERT INTO book VALUES (278, 'Име на книга 271', 'Автор 271', '2014-11-23');
INSERT INTO book VALUES (279, 'Име на книга 272', 'Автор 272', '2014-11-23');
INSERT INTO book VALUES (280, 'Име на книга 273', 'Автор 273', '2014-11-23');
INSERT INTO book VALUES (281, 'Име на книга 274', 'Автор 274', '2014-11-23');
INSERT INTO book VALUES (282, 'Име на книга 275', 'Автор 275', '2014-11-23');
INSERT INTO book VALUES (283, 'Име на книга 276', 'Автор 276', '2014-11-23');
INSERT INTO book VALUES (284, 'Име на книга 277', 'Автор 277', '2014-11-23');
INSERT INTO book VALUES (285, 'Име на книга 278', 'Автор 278', '2014-11-23');
INSERT INTO book VALUES (286, 'Име на книга 279', 'Автор 279', '2014-11-23');
INSERT INTO book VALUES (287, 'Име на книга 280', 'Автор 280', '2014-11-23');
INSERT INTO book VALUES (288, 'Име на книга 281', 'Автор 281', '2014-11-23');
INSERT INTO book VALUES (289, 'Име на книга 282', 'Автор 282', '2014-11-23');
INSERT INTO book VALUES (290, 'Име на книга 283', 'Автор 283', '2014-11-23');
INSERT INTO book VALUES (291, 'Име на книга 284', 'Автор 284', '2014-11-23');
INSERT INTO book VALUES (292, 'Име на книга 285', 'Автор 285', '2014-11-23');
INSERT INTO book VALUES (294, 'Име на книга 287', 'Автор 287', '2014-11-23');
INSERT INTO book VALUES (295, 'Име на книга 288', 'Автор 288', '2014-11-23');
INSERT INTO book VALUES (296, 'Име на книга 289', 'Автор 289', '2014-11-23');
INSERT INTO book VALUES (297, 'Име на книга 290', 'Автор 290', '2014-11-23');
INSERT INTO book VALUES (298, 'Име на книга 291', 'Автор 291', '2014-11-23');
INSERT INTO book VALUES (299, 'Име на книга 292', 'Автор 292', '2014-11-23');
INSERT INTO book VALUES (204, 'Име на книга 197', 'Автор 197', '2014-11-23');
INSERT INTO book VALUES (205, 'Име на книга 198', 'Автор 198', '2014-11-23');
INSERT INTO book VALUES (307, 'Име на книга 300', 'Автор 300', '2014-11-23');
INSERT INTO book VALUES (308, 'Име на книга 7', 'ホテルを 7', '2014-11-23');
INSERT INTO book VALUES (1, 'Име на " '' книга 1', 'Автор " '' 1', '2014-11-23');
INSERT INTO book VALUES (3, 'Schnelle vegetarische Küche 3', 'Автор 3', '2014-11-23');
INSERT INTO book VALUES (5, 'Agodaホテル予約サービスへようこそ。当社では北京のホテルを 5', '日本国 5', '2014-11-23');
INSERT INTO book VALUES (50, 'Име на книга 43', 'Автор 43', '2014-11-23');
INSERT INTO book VALUES (69, 'Име на книга 62', 'Автор 62', '2014-11-23');
INSERT INTO book VALUES (88, 'Име на книга 81', 'Автор 81', '2014-11-23');
INSERT INTO book VALUES (106, 'Име на книга 99', 'Автор 99', '2014-11-23');
INSERT INTO book VALUES (112, 'Име на книга 105', 'Автор 105', '2014-11-23');
INSERT INTO book VALUES (133, 'Име на книга 126', 'Автор 126', '2014-11-23');
INSERT INTO book VALUES (154, 'Име на книга 147', 'Автор 147', '2014-11-23');
INSERT INTO book VALUES (175, 'Име на книга 168', 'Автор 168', '2014-11-23');
INSERT INTO book VALUES (196, 'Име на книга 189', 'Автор 189', '2014-11-23');
INSERT INTO book VALUES (203, 'Име на книга 196', 'Автор 196', '2014-11-23');
INSERT INTO book VALUES (209, 'Име на книга 202', 'Автор 202', '2014-11-23');
INSERT INTO book VALUES (230, 'Име на книга 223', 'Автор 223', '2014-11-23');
INSERT INTO book VALUES (251, 'Име на книга 244', 'Автор 244', '2014-11-23');
INSERT INTO book VALUES (272, 'Име на книга 265', 'Автор 265', '2014-11-23');
INSERT INTO book VALUES (293, 'Име на книга 286', 'Автор 286', '2014-11-23');
INSERT INTO book VALUES (300, 'Име на книга 293', 'Автор 293', '2014-11-23');
INSERT INTO book VALUES (301, 'Име на книга 294', 'Автор 294', '2014-11-23');
INSERT INTO book VALUES (302, 'Име на книга 295', 'Автор 295', '2014-11-23');
INSERT INTO book VALUES (303, 'Име на книга 296', 'Автор 296', '2014-11-23');
INSERT INTO book VALUES (304, 'Име на книга 297', 'Автор 297', '2014-11-23');
INSERT INTO book VALUES (305, 'Име на книга 298', 'Автор 298', '2014-11-23');
INSERT INTO book VALUES (306, 'Име на книга 299', 'Автор 299', '2014-11-23');


--
-- TOC entry 1903 (class 0 OID 0)
-- Dependencies: 162
-- Name: book_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('book_id_seq', 308, true);


--
-- TOC entry 1789 (class 2606 OID 16396)
-- Dependencies: 161 161 1895
-- Name: book_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY book
    ADD CONSTRAINT book_pkey PRIMARY KEY (id);


--
-- TOC entry 1790 (class 1259 OID 16397)
-- Dependencies: 161 161 1421 1895
-- Name: lower_author_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX lower_author_idx ON book USING btree (lower(author));


--
-- TOC entry 1900 (class 0 OID 0)
-- Dependencies: 6
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2014-11-23 18:53:20 EET

--
-- PostgreSQL database dump complete
--

