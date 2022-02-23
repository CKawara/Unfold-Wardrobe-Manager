--
-- PostgreSQL database dump
--

-- Dumped from database version 14.0
-- Dumped by pg_dump version 14.0

-- Started on 2022-02-23 14:23:04

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
-- TOC entry 215 (class 1259 OID 16662)
-- Name: articles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.articles (
    article_id integer NOT NULL,
    description character varying(256),
    image character varying,
    purchase_price double precision,
    times_worn integer NOT NULL,
    sell_price double precision,
    id integer NOT NULL,
    category_id integer NOT NULL
);


ALTER TABLE public.articles OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 16661)
-- Name: articles_article_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.articles_article_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.articles_article_id_seq OWNER TO postgres;

--
-- TOC entry 3390 (class 0 OID 0)
-- Dependencies: 214
-- Name: articles_article_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.articles_article_id_seq OWNED BY public.articles.article_id;


--
-- TOC entry 221 (class 1259 OID 24933)
-- Name: articles_outfits; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.articles_outfits (
    article_outfit_id integer NOT NULL,
    article_id integer NOT NULL,
    outfit_id integer NOT NULL
);


ALTER TABLE public.articles_outfits OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 24932)
-- Name: articles_outfits_article_outfit_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.articles_outfits_article_outfit_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.articles_outfits_article_outfit_id_seq OWNER TO postgres;

--
-- TOC entry 3391 (class 0 OID 0)
-- Dependencies: 220
-- Name: articles_outfits_article_outfit_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.articles_outfits_article_outfit_id_seq OWNED BY public.articles_outfits.article_outfit_id;


--
-- TOC entry 211 (class 1259 OID 16592)
-- Name: base_categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.base_categories (
    base_category_id character varying NOT NULL,
    name character varying(64) NOT NULL,
    description character varying(256) NOT NULL
);


ALTER TABLE public.base_categories OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 16626)
-- Name: categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categories (
    category_id integer NOT NULL,
    name character varying(64) NOT NULL,
    description character varying(256),
    id integer NOT NULL,
    base_category_id character varying(10) NOT NULL
);


ALTER TABLE public.categories OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 16625)
-- Name: categories_category_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.categories_category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.categories_category_id_seq OWNER TO postgres;

--
-- TOC entry 3392 (class 0 OID 0)
-- Dependencies: 212
-- Name: categories_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categories_category_id_seq OWNED BY public.categories.category_id;


--
-- TOC entry 219 (class 1259 OID 24921)
-- Name: outfits; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.outfits (
    outfit_id integer NOT NULL,
    name character varying(64),
    description character varying(256),
    times_worn integer NOT NULL,
    id integer NOT NULL
);


ALTER TABLE public.outfits OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 24920)
-- Name: outfits_outfit_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.outfits_outfit_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.outfits_outfit_id_seq OWNER TO postgres;

--
-- TOC entry 3393 (class 0 OID 0)
-- Dependencies: 218
-- Name: outfits_outfit_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.outfits_outfit_id_seq OWNED BY public.outfits.outfit_id;


--
-- TOC entry 217 (class 1259 OID 16702)
-- Name: tags; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tags (
    tag_id integer NOT NULL,
    name character varying(32) NOT NULL,
    id integer NOT NULL
);


ALTER TABLE public.tags OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 16701)
-- Name: tags_tag_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tags_tag_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tags_tag_id_seq OWNER TO postgres;

--
-- TOC entry 3394 (class 0 OID 0)
-- Dependencies: 216
-- Name: tags_tag_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tags_tag_id_seq OWNED BY public.tags.tag_id;


--
-- TOC entry 210 (class 1259 OID 16575)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    fullname character varying(100) NOT NULL,
    username character varying(50) NOT NULL,
    password character varying(255) NOT NULL,
    email character varying(50) NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 16574)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO postgres;

--
-- TOC entry 3395 (class 0 OID 0)
-- Dependencies: 209
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 223 (class 1259 OID 24950)
-- Name: wear_events; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.wear_events (
    wear_event_id integer NOT NULL,
    name character varying(128) NOT NULL,
    description character varying(256),
    date timestamp without time zone NOT NULL,
    temperature double precision,
    weather_cond character varying(128),
    id integer NOT NULL,
    outfit_id integer
);


ALTER TABLE public.wear_events OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 24949)
-- Name: wear_events_wear_event_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.wear_events_wear_event_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wear_events_wear_event_id_seq OWNER TO postgres;

--
-- TOC entry 3396 (class 0 OID 0)
-- Dependencies: 222
-- Name: wear_events_wear_event_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.wear_events_wear_event_id_seq OWNED BY public.wear_events.wear_event_id;


--
-- TOC entry 3200 (class 2604 OID 16665)
-- Name: articles article_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.articles ALTER COLUMN article_id SET DEFAULT nextval('public.articles_article_id_seq'::regclass);


--
-- TOC entry 3203 (class 2604 OID 24936)
-- Name: articles_outfits article_outfit_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.articles_outfits ALTER COLUMN article_outfit_id SET DEFAULT nextval('public.articles_outfits_article_outfit_id_seq'::regclass);


--
-- TOC entry 3199 (class 2604 OID 16629)
-- Name: categories category_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories ALTER COLUMN category_id SET DEFAULT nextval('public.categories_category_id_seq'::regclass);


--
-- TOC entry 3202 (class 2604 OID 24924)
-- Name: outfits outfit_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.outfits ALTER COLUMN outfit_id SET DEFAULT nextval('public.outfits_outfit_id_seq'::regclass);


--
-- TOC entry 3201 (class 2604 OID 16705)
-- Name: tags tag_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tags ALTER COLUMN tag_id SET DEFAULT nextval('public.tags_tag_id_seq'::regclass);


--
-- TOC entry 3198 (class 2604 OID 16578)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 3204 (class 2604 OID 24953)
-- Name: wear_events wear_event_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wear_events ALTER COLUMN wear_event_id SET DEFAULT nextval('public.wear_events_wear_event_id_seq'::regclass);


--
-- TOC entry 3376 (class 0 OID 16662)
-- Dependencies: 215
-- Data for Name: articles; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.articles (article_id, description, image, purchase_price, times_worn, sell_price, id, category_id) VALUES (86, 'red velvet heels', '2carrson-sandal-steve.png', 2500, 0, NULL, 1, 29);
INSERT INTO public.articles (article_id, description, image, purchase_price, times_worn, sell_price, id, category_id) VALUES (87, 'black trench coat', '45c3fa8dc5822318d4c64ddd86a24518.jpg', 800, 0, NULL, 1, 30);
INSERT INTO public.articles (article_id, description, image, purchase_price, times_worn, sell_price, id, category_id) VALUES (88, 'beige trench coat', '71nHPbYgFqL._AC_UL1500_.jpg', 1200, 0, NULL, 1, 30);
INSERT INTO public.articles (article_id, description, image, purchase_price, times_worn, sell_price, id, category_id) VALUES (89, 'black hoody', '6880049_preview.png', 400, 0, NULL, 1, 32);
INSERT INTO public.articles (article_id, description, image, purchase_price, times_worn, sell_price, id, category_id) VALUES (90, 'peach blazer', '41jebfLevQL._AC_SY580_.jpg', 900, 0, NULL, 1, 30);
INSERT INTO public.articles (article_id, description, image, purchase_price, times_worn, sell_price, id, category_id) VALUES (91, 'little black dress', 'bandage.jpg', 1000, 0, NULL, 1, 27);
INSERT INTO public.articles (article_id, description, image, purchase_price, times_worn, sell_price, id, category_id) VALUES (92, 'glitter', 'black.jpg', 1500, 0, NULL, 1, 35);
INSERT INTO public.articles (article_id, description, image, purchase_price, times_worn, sell_price, id, category_id) VALUES (93, '3/4 sleeved black and white top', 'black_and__white_top.jpg', 200, 0, NULL, 1, 33);
INSERT INTO public.articles (article_id, description, image, purchase_price, times_worn, sell_price, id, category_id) VALUES (94, 'black tie up top', 'black_blouse.jpg', 350, 0, NULL, 1, 34);
INSERT INTO public.articles (article_id, description, image, purchase_price, times_worn, sell_price, id, category_id) VALUES (95, 'black detailed casual top', 'black_casual_top.jpg', 800, 0, NULL, 1, 33);
INSERT INTO public.articles (article_id, description, image, purchase_price, times_worn, sell_price, id, category_id) VALUES (96, 'black casual jeans', 'black_jeans.jpg', 600, 0, NULL, 1, 25);
INSERT INTO public.articles (article_id, description, image, purchase_price, times_worn, sell_price, id, category_id) VALUES (97, 'black comfy sandals', 'black_sandles.jpg', 400, 0, NULL, 1, 31);
INSERT INTO public.articles (article_id, description, image, purchase_price, times_worn, sell_price, id, category_id) VALUES (98, 'black shorts ', 'black_shorts.jpg', 700, 0, NULL, 1, 37);
INSERT INTO public.articles (article_id, description, image, purchase_price, times_worn, sell_price, id, category_id) VALUES (99, 'skater skirt', 'black_skirt.jpg', 800, 0, NULL, 1, 26);
INSERT INTO public.articles (article_id, description, image, purchase_price, times_worn, sell_price, id, category_id) VALUES (100, 'somewhat dressy sweat shirt', 'black_sweat_shirt.jpg', 800, 0, NULL, 1, 32);
INSERT INTO public.articles (article_id, description, image, purchase_price, times_worn, sell_price, id, category_id) VALUES (101, 'graphic tee shirt', 'black_tee.jpg', 200, 0, NULL, 1, 34);
INSERT INTO public.articles (article_id, description, image, purchase_price, times_worn, sell_price, id, category_id) VALUES (102, 'blue jumpsuit', 'blue.jpg', 1700, 0, NULL, 1, 35);
INSERT INTO public.articles (article_id, description, image, purchase_price, times_worn, sell_price, id, category_id) VALUES (103, 'blue mum jeans', 'blue_jeans.jpg', 850, 0, NULL, 1, 25);
INSERT INTO public.articles (article_id, description, image, purchase_price, times_worn, sell_price, id, category_id) VALUES (104, 'brown checked shorts', 'brown_shorts.jpg', 650, 0, NULL, 1, 37);
INSERT INTO public.articles (article_id, description, image, purchase_price, times_worn, sell_price, id, category_id) VALUES (105, 'blue denim jacket', 'c245f45a-77f1-4f2e-b202-8372de2024da.jpg', 550, 0, NULL, 1, 30);
INSERT INTO public.articles (article_id, description, image, purchase_price, times_worn, sell_price, id, category_id) VALUES (106, 'brown cashmere sweater', 'cashmere.jpg', 150, 0, NULL, 1, 32);
INSERT INTO public.articles (article_id, description, image, purchase_price, times_worn, sell_price, id, category_id) VALUES (107, 'black converse', 'converse_shoes.jpg', 800, 0, NULL, 1, 28);
INSERT INTO public.articles (article_id, description, image, purchase_price, times_worn, sell_price, id, category_id) VALUES (108, 'dark brown knee length boots', 'dark_brown_boots.jpg', 750, 0, NULL, 1, 24);
INSERT INTO public.articles (article_id, description, image, purchase_price, times_worn, sell_price, id, category_id) VALUES (109, 'dark purple chiffon top', 'dark_purple_chiffon_top.jpg', 500, 0, NULL, 1, 23);
INSERT INTO public.articles (article_id, description, image, purchase_price, times_worn, sell_price, id, category_id) VALUES (110, 'pink floral dress', 'floral.jpg', 700, 0, NULL, 1, 27);
INSERT INTO public.articles (article_id, description, image, purchase_price, times_worn, sell_price, id, category_id) VALUES (111, 'gold heels', 'gold_heels.jpg', 1500, 0, NULL, 1, 29);
INSERT INTO public.articles (article_id, description, image, purchase_price, times_worn, sell_price, id, category_id) VALUES (112, 'green sleeveless velvet top', 'green_velvet_top.jpg', 200, 0, NULL, 1, 34);
INSERT INTO public.articles (article_id, description, image, purchase_price, times_worn, sell_price, id, category_id) VALUES (113, 'grey mom jeans', 'grey_mom_jeans.jpg', 800, 0, NULL, 1, 25);
INSERT INTO public.articles (article_id, description, image, purchase_price, times_worn, sell_price, id, category_id) VALUES (114, 'grey sweatpants', 'grey_sweats.jpg', 300, 0, NULL, 1, 36);
INSERT INTO public.articles (article_id, description, image, purchase_price, times_worn, sell_price, id, category_id) VALUES (115, 'grey blouse', 'grey_top.jpg', 500, 0, NULL, 1, 23);
INSERT INTO public.articles (article_id, description, image, purchase_price, times_worn, sell_price, id, category_id) VALUES (116, 'black steeleto heels', 'gvjluyhbuy.png', 1000, 0, NULL, 1, 29);
INSERT INTO public.articles (article_id, description, image, purchase_price, times_worn, sell_price, id, category_id) VALUES (117, 'black heeled ankle-boots', 'heeled_boots.jpg', 800, 0, NULL, 1, 24);
INSERT INTO public.articles (article_id, description, image, purchase_price, times_worn, sell_price, id, category_id) VALUES (118, 'blue hoodie', 'hooded.jpg', 500, 0, NULL, 1, 32);
INSERT INTO public.articles (article_id, description, image, purchase_price, times_worn, sell_price, id, category_id) VALUES (119, 'orange bandage dress', 'HTB1OUYoaHj1gK0jSZFOq6A7GpXaw.jpg', 800, 0, NULL, 1, 27);
INSERT INTO public.articles (article_id, description, image, purchase_price, times_worn, sell_price, id, category_id) VALUES (120, 'black and white jordans', 'jordans.jpg', 1500, 0, NULL, 1, 28);
INSERT INTO public.articles (article_id, description, image, purchase_price, times_worn, sell_price, id, category_id) VALUES (121, 'maroon pencil skirt', 'maroon_pensil_skirt.jpg', 700, 0, NULL, 1, 26);
INSERT INTO public.articles (article_id, description, image, purchase_price, times_worn, sell_price, id, category_id) VALUES (122, '-Mock-Neck-Pullover', '-Mock-Neck-Pullover.png', 600, 0, NULL, 1, 32);
INSERT INTO public.articles (article_id, description, image, purchase_price, times_worn, sell_price, id, category_id) VALUES (123, 'mustard skirt', 'mustard_skirt.jpg', 300, 0, NULL, 1, 26);
INSERT INTO public.articles (article_id, description, image, purchase_price, times_worn, sell_price, id, category_id) VALUES (124, 'platform boots', 'patform_boots.jpg', 1200, 0, NULL, 1, 24);
INSERT INTO public.articles (article_id, description, image, purchase_price, times_worn, sell_price, id, category_id) VALUES (125, 'peach sandals', 'peach_sandles.jpg', 500, 0, NULL, 1, 31);
INSERT INTO public.articles (article_id, description, image, purchase_price, times_worn, sell_price, id, category_id) VALUES (126, 'print maxi skirt', 'print_maxi_skirt.jpg', 550, 0, NULL, 1, 26);
INSERT INTO public.articles (article_id, description, image, purchase_price, times_worn, sell_price, id, category_id) VALUES (127, 'purple-leather jacket', 'purple-leather.jpg', 1550, 0, NULL, 1, 30);
INSERT INTO public.articles (article_id, description, image, purchase_price, times_worn, sell_price, id, category_id) VALUES (128, 'red pants', 'red_pants.jpg', 750, 0, NULL, 1, 36);
INSERT INTO public.articles (article_id, description, image, purchase_price, times_worn, sell_price, id, category_id) VALUES (129, 'red-formal jumpsuit', 'red-formal.jpeg', 1250, 0, NULL, 1, 35);
INSERT INTO public.articles (article_id, description, image, purchase_price, times_worn, sell_price, id, category_id) VALUES (130, 'skinny jeans', 'skinny_jeans.jpg', 650, 0, NULL, 1, 25);
INSERT INTO public.articles (article_id, description, image, purchase_price, times_worn, sell_price, id, category_id) VALUES (131, 'b&w stripped_blouse', 'stripped_blouse.jpg', 450, 0, NULL, 1, 23);
INSERT INTO public.articles (article_id, description, image, purchase_price, times_worn, sell_price, id, category_id) VALUES (132, 'blazer', '2carrson-sandal-steve.png', 87, 0, NULL, 1, 25);
INSERT INTO public.articles (article_id, description, image, purchase_price, times_worn, sell_price, id, category_id) VALUES (133, '', 'black.jpg', 1500, 0, NULL, 1, 35);


--
-- TOC entry 3382 (class 0 OID 24933)
-- Dependencies: 221
-- Data for Name: articles_outfits; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3372 (class 0 OID 16592)
-- Dependencies: 211
-- Data for Name: base_categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.base_categories (base_category_id, name, description) VALUES ('tops', 'Tops', 'General category for torso coverage');
INSERT INTO public.base_categories (base_category_id, name, description) VALUES ('bottoms', 'bottoms', 'General category for waist and leg coverage');
INSERT INTO public.base_categories (base_category_id, name, description) VALUES ('fulls', 'Full-length', 'General category for full-body coverage - includes jumpsuits and dresses');
INSERT INTO public.base_categories (base_category_id, name, description) VALUES ('shoes', 'Shoes', 'General category for footwear');
INSERT INTO public.base_categories (base_category_id, name, description) VALUES ('outers', 'Outerwear', 'General category for jackets and coats');
INSERT INTO public.base_categories (base_category_id, name, description) VALUES ('others', 'Other', 'General category for articles that dont fit into other categories');


--
-- TOC entry 3374 (class 0 OID 16626)
-- Dependencies: 213
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.categories (category_id, name, description, id, base_category_id) VALUES (23, 'Blouses', 'Long sleeved dressier shirts', 1, 'tops');
INSERT INTO public.categories (category_id, name, description, id, base_category_id) VALUES (24, 'Boots', 'warmer shoes', 1, 'shoes');
INSERT INTO public.categories (category_id, name, description, id, base_category_id) VALUES (25, 'Jeans', 'Denim pants', 1, 'bottoms');
INSERT INTO public.categories (category_id, name, description, id, base_category_id) VALUES (26, 'Skirts', 'Long or short skirts', 1, 'bottoms');
INSERT INTO public.categories (category_id, name, description, id, base_category_id) VALUES (27, 'Dresses', 'Long or short', 1, 'fulls');
INSERT INTO public.categories (category_id, name, description, id, base_category_id) VALUES (28, 'Sneakers', 'Casual athletic shoes', 1, 'shoes');
INSERT INTO public.categories (category_id, name, description, id, base_category_id) VALUES (29, 'Heels', 'fancy high shoes', 1, 'shoes');
INSERT INTO public.categories (category_id, name, description, id, base_category_id) VALUES (30, 'Jackets', 'warm outerwear', 1, 'outers');
INSERT INTO public.categories (category_id, name, description, id, base_category_id) VALUES (31, 'Sandals', 'low heeled casual shoes', 1, 'shoes');
INSERT INTO public.categories (category_id, name, description, id, base_category_id) VALUES (32, 'Sweaters', 'warm outerwear', 1, 'outers');
INSERT INTO public.categories (category_id, name, description, id, base_category_id) VALUES (33, 'Long-sleeved', 'shirts or blouses with long sleeves', 1, 'tops');
INSERT INTO public.categories (category_id, name, description, id, base_category_id) VALUES (34, 'Short-sleeved', 'shirts or blouses with short sleeves', 1, 'tops');
INSERT INTO public.categories (category_id, name, description, id, base_category_id) VALUES (35, 'jumpsuits', 'clothers with full coverage', 1, 'fulls');
INSERT INTO public.categories (category_id, name, description, id, base_category_id) VALUES (36, 'Pants', 'bottoms with coverage past the knees', 1, 'bottoms');
INSERT INTO public.categories (category_id, name, description, id, base_category_id) VALUES (37, 'Shorts', 'bottoms without coverage past the knees', 1, 'bottoms');
INSERT INTO public.categories (category_id, name, description, id, base_category_id) VALUES (43, 'gfv', '', 1, 'bottoms');


--
-- TOC entry 3380 (class 0 OID 24921)
-- Dependencies: 219
-- Data for Name: outfits; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.outfits (outfit_id, name, description, times_worn, id) VALUES (2, 'work', 'work vibe', 0, 1);
INSERT INTO public.outfits (outfit_id, name, description, times_worn, id) VALUES (6, 'Saturday brunch', 'casual wear', 0, 1);


--
-- TOC entry 3378 (class 0 OID 16702)
-- Dependencies: 217
-- Data for Name: tags; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.tags (tag_id, name, id) VALUES (28, 'Formal', 1);
INSERT INTO public.tags (tag_id, name, id) VALUES (29, 'baggy', 1);
INSERT INTO public.tags (tag_id, name, id) VALUES (30, 'favorite', 1);
INSERT INTO public.tags (tag_id, name, id) VALUES (31, 'cosy', 1);
INSERT INTO public.tags (tag_id, name, id) VALUES (32, 'brunch', 1);
INSERT INTO public.tags (tag_id, name, id) VALUES (33, 'professional', 1);
INSERT INTO public.tags (tag_id, name, id) VALUES (34, 'cashmere', 1);
INSERT INTO public.tags (tag_id, name, id) VALUES (35, 'sporty', 1);
INSERT INTO public.tags (tag_id, name, id) VALUES (36, 'hooded', 1);
INSERT INTO public.tags (tag_id, name, id) VALUES (37, 'grunge', 1);
INSERT INTO public.tags (tag_id, name, id) VALUES (38, 'street wear', 1);
INSERT INTO public.tags (tag_id, name, id) VALUES (39, 'casual', 1);
INSERT INTO public.tags (tag_id, name, id) VALUES (40, 'Chic', 1);
INSERT INTO public.tags (tag_id, name, id) VALUES (41, 'decent', 1);
INSERT INTO public.tags (tag_id, name, id) VALUES (42, 'elegant', 1);
INSERT INTO public.tags (tag_id, name, id) VALUES (43, 'classy', 1);
INSERT INTO public.tags (tag_id, name, id) VALUES (44, 'comdortable', 1);
INSERT INTO public.tags (tag_id, name, id) VALUES (45, 'warm', 1);
INSERT INTO public.tags (tag_id, name, id) VALUES (46, 'flattering', 1);
INSERT INTO public.tags (tag_id, name, id) VALUES (47, 'dressy', 1);
INSERT INTO public.tags (tag_id, name, id) VALUES (48, 'simple', 1);
INSERT INTO public.tags (tag_id, name, id) VALUES (49, 'skimpy', 1);


--
-- TOC entry 3371 (class 0 OID 16575)
-- Dependencies: 210
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.users (id, fullname, username, password, email) VALUES (1, 'Ketto', 'Ketto', 'pbkdf2:sha256:260000$AfEZ6tmziKwJKeb8$25bf24b153afe8ec618399f41619eba42474700ad86b5ce69f331ec58f84bec6', 'empressketto@gmail.com');


--
-- TOC entry 3384 (class 0 OID 24950)
-- Dependencies: 223
-- Data for Name: wear_events; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.wear_events (wear_event_id, name, description, date, temperature, weather_cond, id, outfit_id) VALUES (4, 'Brunch', 'going out for brunch with friends', '2022-02-04 10:00:00', NULL, NULL, 1, 6);


--
-- TOC entry 3397 (class 0 OID 0)
-- Dependencies: 214
-- Name: articles_article_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.articles_article_id_seq', 133, true);


--
-- TOC entry 3398 (class 0 OID 0)
-- Dependencies: 220
-- Name: articles_outfits_article_outfit_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.articles_outfits_article_outfit_id_seq', 1, false);


--
-- TOC entry 3399 (class 0 OID 0)
-- Dependencies: 212
-- Name: categories_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categories_category_id_seq', 43, true);


--
-- TOC entry 3400 (class 0 OID 0)
-- Dependencies: 218
-- Name: outfits_outfit_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.outfits_outfit_id_seq', 8, true);


--
-- TOC entry 3401 (class 0 OID 0)
-- Dependencies: 216
-- Name: tags_tag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tags_tag_id_seq', 49, true);


--
-- TOC entry 3402 (class 0 OID 0)
-- Dependencies: 209
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 1, true);


--
-- TOC entry 3403 (class 0 OID 0)
-- Dependencies: 222
-- Name: wear_events_wear_event_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.wear_events_wear_event_id_seq', 4, true);


--
-- TOC entry 3218 (class 2606 OID 24938)
-- Name: articles_outfits articles_outfits_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.articles_outfits
    ADD CONSTRAINT articles_outfits_pkey PRIMARY KEY (article_outfit_id);


--
-- TOC entry 3212 (class 2606 OID 16669)
-- Name: articles articles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.articles
    ADD CONSTRAINT articles_pkey PRIMARY KEY (article_id);


--
-- TOC entry 3208 (class 2606 OID 16598)
-- Name: base_categories base_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.base_categories
    ADD CONSTRAINT base_categories_pkey PRIMARY KEY (base_category_id);


--
-- TOC entry 3210 (class 2606 OID 16631)
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (category_id);


--
-- TOC entry 3216 (class 2606 OID 24926)
-- Name: outfits outfits_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.outfits
    ADD CONSTRAINT outfits_pkey PRIMARY KEY (outfit_id);


--
-- TOC entry 3214 (class 2606 OID 16707)
-- Name: tags tags_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (tag_id);


--
-- TOC entry 3206 (class 2606 OID 16580)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 3220 (class 2606 OID 24957)
-- Name: wear_events wear_events_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wear_events
    ADD CONSTRAINT wear_events_pkey PRIMARY KEY (wear_event_id);


--
-- TOC entry 3223 (class 2606 OID 16670)
-- Name: articles articles_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.articles
    ADD CONSTRAINT articles_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.categories(category_id);


--
-- TOC entry 3224 (class 2606 OID 16675)
-- Name: articles articles_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.articles
    ADD CONSTRAINT articles_id_fkey FOREIGN KEY (id) REFERENCES public.users(id);


--
-- TOC entry 3227 (class 2606 OID 24939)
-- Name: articles_outfits articles_outfits_article_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.articles_outfits
    ADD CONSTRAINT articles_outfits_article_id_fkey FOREIGN KEY (article_id) REFERENCES public.articles(article_id);


--
-- TOC entry 3228 (class 2606 OID 24944)
-- Name: articles_outfits articles_outfits_outfit_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.articles_outfits
    ADD CONSTRAINT articles_outfits_outfit_id_fkey FOREIGN KEY (outfit_id) REFERENCES public.outfits(outfit_id);


--
-- TOC entry 3221 (class 2606 OID 16632)
-- Name: categories categories_base_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_base_category_id_fkey FOREIGN KEY (base_category_id) REFERENCES public.base_categories(base_category_id);


--
-- TOC entry 3222 (class 2606 OID 16637)
-- Name: categories categories_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_user_id_fkey FOREIGN KEY (id) REFERENCES public.users(id);


--
-- TOC entry 3226 (class 2606 OID 24927)
-- Name: outfits outfits_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.outfits
    ADD CONSTRAINT outfits_id_fkey FOREIGN KEY (id) REFERENCES public.users(id);


--
-- TOC entry 3225 (class 2606 OID 16708)
-- Name: tags tags_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tags
    ADD CONSTRAINT tags_id_fkey FOREIGN KEY (id) REFERENCES public.users(id);


--
-- TOC entry 3229 (class 2606 OID 24958)
-- Name: wear_events wear_events_outfit_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wear_events
    ADD CONSTRAINT wear_events_outfit_id_fkey FOREIGN KEY (outfit_id) REFERENCES public.outfits(outfit_id);


--
-- TOC entry 3230 (class 2606 OID 24963)
-- Name: wear_events wear_events_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wear_events
    ADD CONSTRAINT wear_events_user_id_fkey FOREIGN KEY (id) REFERENCES public.users(id);


-- Completed on 2022-02-23 14:23:05

--
-- PostgreSQL database dump complete
--

