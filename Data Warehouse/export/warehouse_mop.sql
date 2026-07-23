--
-- PostgreSQL database dump
--

\restrict GK2gX2HCnuhuKn6JD9lkBYPpC7dZIZT3idykllrbtoyxEIbaOxlPgUH4MQJFkYS

-- Dumped from database version 14.21 (Homebrew)
-- Dumped by pg_dump version 14.21 (Homebrew)

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

--
-- Name: warehouse; Type: SCHEMA; Schema: -; Owner: danesha
--

CREATE SCHEMA warehouse;


ALTER SCHEMA warehouse OWNER TO danesha;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: bank_transfer_payments; Type: TABLE; Schema: public; Owner: danesha
--

CREATE TABLE public.bank_transfer_payments (
    payment_id integer NOT NULL,
    bank_name character varying(100) NOT NULL,
    account_number character varying(50) NOT NULL
);


ALTER TABLE public.bank_transfer_payments OWNER TO danesha;

--
-- Name: cart_items; Type: TABLE; Schema: public; Owner: danesha
--

CREATE TABLE public.cart_items (
    cart_item_id integer NOT NULL,
    cart_id integer NOT NULL,
    variant_id character varying(50) NOT NULL,
    quantity integer NOT NULL,
    CONSTRAINT cart_items_quantity_check CHECK ((quantity > 0))
);


ALTER TABLE public.cart_items OWNER TO danesha;

--
-- Name: cart_items_cart_item_id_seq; Type: SEQUENCE; Schema: public; Owner: danesha
--

CREATE SEQUENCE public.cart_items_cart_item_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cart_items_cart_item_id_seq OWNER TO danesha;

--
-- Name: cart_items_cart_item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: danesha
--

ALTER SEQUENCE public.cart_items_cart_item_id_seq OWNED BY public.cart_items.cart_item_id;


--
-- Name: carts; Type: TABLE; Schema: public; Owner: danesha
--

CREATE TABLE public.carts (
    cart_id integer NOT NULL,
    customer_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.carts OWNER TO danesha;

--
-- Name: carts_cart_id_seq; Type: SEQUENCE; Schema: public; Owner: danesha
--

CREATE SEQUENCE public.carts_cart_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.carts_cart_id_seq OWNER TO danesha;

--
-- Name: carts_cart_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: danesha
--

ALTER SEQUENCE public.carts_cart_id_seq OWNED BY public.carts.cart_id;


--
-- Name: categories; Type: TABLE; Schema: public; Owner: danesha
--

CREATE TABLE public.categories (
    category_id integer NOT NULL,
    slug character varying(100) NOT NULL,
    name character varying(100) NOT NULL
);


ALTER TABLE public.categories OWNER TO danesha;

--
-- Name: categories_category_id_seq; Type: SEQUENCE; Schema: public; Owner: danesha
--

CREATE SEQUENCE public.categories_category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.categories_category_id_seq OWNER TO danesha;

--
-- Name: categories_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: danesha
--

ALTER SEQUENCE public.categories_category_id_seq OWNED BY public.categories.category_id;


--
-- Name: customer_addresses; Type: TABLE; Schema: public; Owner: danesha
--

CREATE TABLE public.customer_addresses (
    address_id integer NOT NULL,
    customer_id integer NOT NULL,
    street character varying(255) NOT NULL,
    city character varying(100) NOT NULL,
    province character varying(100) NOT NULL,
    zip_code character varying(10)
);


ALTER TABLE public.customer_addresses OWNER TO danesha;

--
-- Name: customer_addresses_address_id_seq; Type: SEQUENCE; Schema: public; Owner: danesha
--

CREATE SEQUENCE public.customer_addresses_address_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.customer_addresses_address_id_seq OWNER TO danesha;

--
-- Name: customer_addresses_address_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: danesha
--

ALTER SEQUENCE public.customer_addresses_address_id_seq OWNED BY public.customer_addresses.address_id;


--
-- Name: customers; Type: TABLE; Schema: public; Owner: danesha
--

CREATE TABLE public.customers (
    customer_id integer NOT NULL,
    name character varying(150) NOT NULL,
    email character varying(150) NOT NULL,
    phone character varying(30)
);


ALTER TABLE public.customers OWNER TO danesha;

--
-- Name: customers_customer_id_seq; Type: SEQUENCE; Schema: public; Owner: danesha
--

CREATE SEQUENCE public.customers_customer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.customers_customer_id_seq OWNER TO danesha;

--
-- Name: customers_customer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: danesha
--

ALTER SEQUENCE public.customers_customer_id_seq OWNED BY public.customers.customer_id;


--
-- Name: ewallet_payments; Type: TABLE; Schema: public; Owner: danesha
--

CREATE TABLE public.ewallet_payments (
    payment_id integer NOT NULL,
    wallet_provider character varying(50) NOT NULL
);


ALTER TABLE public.ewallet_payments OWNER TO danesha;

--
-- Name: order_items; Type: TABLE; Schema: public; Owner: danesha
--

CREATE TABLE public.order_items (
    order_item_id integer NOT NULL,
    order_id integer NOT NULL,
    variant_id character varying(50) NOT NULL,
    quantity integer NOT NULL,
    price_at_purchase numeric(12,2) NOT NULL,
    CONSTRAINT order_items_quantity_check CHECK ((quantity > 0))
);


ALTER TABLE public.order_items OWNER TO danesha;

--
-- Name: order_items_order_item_id_seq; Type: SEQUENCE; Schema: public; Owner: danesha
--

CREATE SEQUENCE public.order_items_order_item_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.order_items_order_item_id_seq OWNER TO danesha;

--
-- Name: order_items_order_item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: danesha
--

ALTER SEQUENCE public.order_items_order_item_id_seq OWNED BY public.order_items.order_item_id;


--
-- Name: orders; Type: TABLE; Schema: public; Owner: danesha
--

CREATE TABLE public.orders (
    order_id integer NOT NULL,
    customer_id integer NOT NULL,
    shipping_address_id integer NOT NULL,
    order_date date DEFAULT CURRENT_DATE NOT NULL,
    status character varying(30) DEFAULT 'pending'::character varying NOT NULL
);


ALTER TABLE public.orders OWNER TO danesha;

--
-- Name: orders_order_id_seq; Type: SEQUENCE; Schema: public; Owner: danesha
--

CREATE SEQUENCE public.orders_order_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.orders_order_id_seq OWNER TO danesha;

--
-- Name: orders_order_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: danesha
--

ALTER SEQUENCE public.orders_order_id_seq OWNED BY public.orders.order_id;


--
-- Name: payments; Type: TABLE; Schema: public; Owner: danesha
--

CREATE TABLE public.payments (
    payment_id integer NOT NULL,
    order_id integer NOT NULL,
    payment_date date DEFAULT CURRENT_DATE NOT NULL,
    payment_type character varying(20) NOT NULL,
    amount numeric(12,2) NOT NULL,
    CONSTRAINT payments_payment_type_check CHECK (((payment_type)::text = ANY ((ARRAY['bank_transfer'::character varying, 'ewallet'::character varying])::text[])))
);


ALTER TABLE public.payments OWNER TO danesha;

--
-- Name: payments_payment_id_seq; Type: SEQUENCE; Schema: public; Owner: danesha
--

CREATE SEQUENCE public.payments_payment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.payments_payment_id_seq OWNER TO danesha;

--
-- Name: payments_payment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: danesha
--

ALTER SEQUENCE public.payments_payment_id_seq OWNED BY public.payments.payment_id;


--
-- Name: product_categories; Type: TABLE; Schema: public; Owner: danesha
--

CREATE TABLE public.product_categories (
    product_id character varying(255) NOT NULL,
    category_id integer NOT NULL
);


ALTER TABLE public.product_categories OWNER TO danesha;

--
-- Name: products; Type: TABLE; Schema: public; Owner: danesha
--

CREATE TABLE public.products (
    product_id character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    category character varying(100),
    description text,
    netto character varying(50),
    pao character varying(50),
    url character varying(500)
);


ALTER TABLE public.products OWNER TO danesha;

--
-- Name: variants; Type: TABLE; Schema: public; Owner: danesha
--

CREATE TABLE public.variants (
    variant_id character varying(50) NOT NULL,
    product_id character varying(255) NOT NULL,
    sku character varying(50),
    shade_name character varying(100),
    price numeric(12,2) NOT NULL,
    compare_at_price numeric(12,2),
    availability character varying(30),
    bpom_number character varying(50)
);


ALTER TABLE public.variants OWNER TO danesha;

--
-- Name: availability; Type: TABLE; Schema: warehouse; Owner: danesha
--

CREATE TABLE warehouse.availability (
    availability_id integer NOT NULL,
    status character varying(30) NOT NULL
);


ALTER TABLE warehouse.availability OWNER TO danesha;

--
-- Name: availability_availability_id_seq; Type: SEQUENCE; Schema: warehouse; Owner: danesha
--

CREATE SEQUENCE warehouse.availability_availability_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE warehouse.availability_availability_id_seq OWNER TO danesha;

--
-- Name: availability_availability_id_seq; Type: SEQUENCE OWNED BY; Schema: warehouse; Owner: danesha
--

ALTER SEQUENCE warehouse.availability_availability_id_seq OWNED BY warehouse.availability.availability_id;


--
-- Name: sales; Type: TABLE; Schema: warehouse; Owner: danesha
--

CREATE TABLE warehouse.sales (
    product_id character varying(255) NOT NULL,
    variant_id character varying(50) NOT NULL,
    category_id integer NOT NULL,
    availability_id integer NOT NULL,
    price numeric(12,2) NOT NULL,
    compare_at_price numeric(12,2),
    discount_amount numeric(12,2) DEFAULT 0 NOT NULL,
    discount_percentage numeric(5,2) DEFAULT 0 NOT NULL
);


ALTER TABLE warehouse.sales OWNER TO danesha;

--
-- Name: cart_items cart_item_id; Type: DEFAULT; Schema: public; Owner: danesha
--

ALTER TABLE ONLY public.cart_items ALTER COLUMN cart_item_id SET DEFAULT nextval('public.cart_items_cart_item_id_seq'::regclass);


--
-- Name: carts cart_id; Type: DEFAULT; Schema: public; Owner: danesha
--

ALTER TABLE ONLY public.carts ALTER COLUMN cart_id SET DEFAULT nextval('public.carts_cart_id_seq'::regclass);


--
-- Name: categories category_id; Type: DEFAULT; Schema: public; Owner: danesha
--

ALTER TABLE ONLY public.categories ALTER COLUMN category_id SET DEFAULT nextval('public.categories_category_id_seq'::regclass);


--
-- Name: customer_addresses address_id; Type: DEFAULT; Schema: public; Owner: danesha
--

ALTER TABLE ONLY public.customer_addresses ALTER COLUMN address_id SET DEFAULT nextval('public.customer_addresses_address_id_seq'::regclass);


--
-- Name: customers customer_id; Type: DEFAULT; Schema: public; Owner: danesha
--

ALTER TABLE ONLY public.customers ALTER COLUMN customer_id SET DEFAULT nextval('public.customers_customer_id_seq'::regclass);


--
-- Name: order_items order_item_id; Type: DEFAULT; Schema: public; Owner: danesha
--

ALTER TABLE ONLY public.order_items ALTER COLUMN order_item_id SET DEFAULT nextval('public.order_items_order_item_id_seq'::regclass);


--
-- Name: orders order_id; Type: DEFAULT; Schema: public; Owner: danesha
--

ALTER TABLE ONLY public.orders ALTER COLUMN order_id SET DEFAULT nextval('public.orders_order_id_seq'::regclass);


--
-- Name: payments payment_id; Type: DEFAULT; Schema: public; Owner: danesha
--

ALTER TABLE ONLY public.payments ALTER COLUMN payment_id SET DEFAULT nextval('public.payments_payment_id_seq'::regclass);


--
-- Name: availability availability_id; Type: DEFAULT; Schema: warehouse; Owner: danesha
--

ALTER TABLE ONLY warehouse.availability ALTER COLUMN availability_id SET DEFAULT nextval('warehouse.availability_availability_id_seq'::regclass);


--
-- Data for Name: bank_transfer_payments; Type: TABLE DATA; Schema: public; Owner: danesha
--

COPY public.bank_transfer_payments (payment_id, bank_name, account_number) FROM stdin;
\.


--
-- Data for Name: cart_items; Type: TABLE DATA; Schema: public; Owner: danesha
--

COPY public.cart_items (cart_item_id, cart_id, variant_id, quantity) FROM stdin;
\.


--
-- Data for Name: carts; Type: TABLE DATA; Schema: public; Owner: danesha
--

COPY public.carts (cart_id, customer_id, created_at) FROM stdin;
\.


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: danesha
--

COPY public.categories (category_id, slug, name) FROM stdin;
1	face-all	Face All
2	eyes	Eyes
3	lips-all	Lips All
4	cheeks	Cheeks
5	skincare	Skincare
6	headband	Headband
\.


--
-- Data for Name: customer_addresses; Type: TABLE DATA; Schema: public; Owner: danesha
--

COPY public.customer_addresses (address_id, customer_id, street, city, province, zip_code) FROM stdin;
\.


--
-- Data for Name: customers; Type: TABLE DATA; Schema: public; Owner: danesha
--

COPY public.customers (customer_id, name, email, phone) FROM stdin;
\.


--
-- Data for Name: ewallet_payments; Type: TABLE DATA; Schema: public; Owner: danesha
--

COPY public.ewallet_payments (payment_id, wallet_provider) FROM stdin;
\.


--
-- Data for Name: order_items; Type: TABLE DATA; Schema: public; Owner: danesha
--

COPY public.order_items (order_item_id, order_id, variant_id, quantity, price_at_purchase) FROM stdin;
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: danesha
--

COPY public.orders (order_id, customer_id, shipping_address_id, order_date, status) FROM stdin;
\.


--
-- Data for Name: payments; Type: TABLE DATA; Schema: public; Owner: danesha
--

COPY public.payments (payment_id, order_id, payment_date, payment_type, amount) FROM stdin;
\.


--
-- Data for Name: product_categories; Type: TABLE DATA; Schema: public; Owner: danesha
--

COPY public.product_categories (product_id, category_id) FROM stdin;
abracadabrow-tinted-brow-laminator-universal-ash	1
am-to-pm-colorfast-hypertint-01-date-night	1
anti-cakey-lock-and-smooth-gripping-primer	1
bulletproof-set-and-protect-continous-mist	1
c-m-i-i-w-skin-corrector	1
microblur-translucent-loose-powder	1
microblur-translucent-pressed-powder	1
mop-c-o-a-center-of-attention-ultra-cover-long-lasting-powder-foundation	1
mop-cover-age-high-coverage-creamy-concealer	1
mop-picture-perfect-soft-focus-satin-concealer	1
mop-unbothered-demi-matte-cushion	1
so-x-tra-hybrid-matte-foundation-peptides-infused-spf-40-pa	1
abracadabrow-tinted-brow-laminator-universal-ash	2
am-to-pm-colorfast-hypertint-01-date-night	2
anti-cakey-lock-and-smooth-gripping-primer	2
browgraphy-angled-precision-brow-pen-01-dark-brown	2
maxcara-volumizing-lengthening-mascara	2
vantablack-waterproof-precision-liner	2
abracadabrow-tinted-brow-laminator-universal-ash	3
am-to-pm-colorfast-hypertint-01-date-night	3
anti-cakey-lock-and-smooth-gripping-primer	3
g-w-s-gleaming-wonderful-shiny-plump-gloss-01-mlbb	3
lip-sculptor	3
my-perfect-nude-lip-cream	3
abracadabrow-tinted-brow-laminator-universal-ash	4
am-to-pm-colorfast-hypertint-01-date-night	4
anti-cakey-lock-and-smooth-gripping-primer	4
mop-bloom-maximum-intensity-pigment-blusher	4
mop-bloomdrop-longwear-liquid-blush	4
tender-touch-creamy-butter-bronzer	4
tender-touch-creamy-butter-contour	4
tender-touch-illuminating-finishing-powder	4
tender-touch-soft-ombre-powder-blush	4
abracadabrow-tinted-brow-laminator-universal-ash	5
am-to-pm-colorfast-hypertint-01-date-night	5
anti-cakey-lock-and-smooth-gripping-primer	5
invincible-nano-gel-capsule-sunscreen-spf50-pa	5
lippy-shield-nourishing-and-protecting-balm-spf-35-pa	5
abracadabrow-tinted-brow-laminator-universal-ash	6
am-to-pm-colorfast-hypertint-01-date-night	6
anti-cakey-lock-and-smooth-gripping-primer	6
mop-multifunctional-brush	6
mother-of-puff-beauty-sponge	6
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: danesha
--

COPY public.products (product_id, name, category, description, netto, pao, url) FROM stdin;
abracadabrow-tinted-brow-laminator-universal-ash	Abracadabrow Tinted Brow Laminator	\N	anti-clumpy	4.5 g	\N	https://motherofpearl.id/products/abracadabrow-tinted-brow-laminator-universal-ash
am-to-pm-colorfast-hypertint-01-date-night	AM to PM Colorfast Hypertint	\N	long-lasting	6 ml	12 months	https://motherofpearl.id/products/am-to-pm-colorfast-hypertint-01-date-night
anti-cakey-lock-and-smooth-gripping-primer	Anti Cakey Lock and Smooth Gripping Primer	\N	anti-cakey	\N	\N	https://motherofpearl.id/products/anti-cakey-lock-and-smooth-gripping-primer
browgraphy-angled-precision-brow-pen-01-dark-brown	Browgraphy Angled Precision Brow Pen	\N	precise	0.15 g	\N	https://motherofpearl.id/products/browgraphy-angled-precision-brow-pen-01-dark-brown
bulletproof-set-and-protect-continous-mist	Bulletproof Set and Protect Continous Mist	\N	misty-fresh	\N	\N	https://motherofpearl.id/products/bulletproof-set-and-protect-continous-mist
c-m-i-i-w-skin-corrector	C.M.I.I.W Skin Corrector	\N	color-correcting	3.5 g	12 months	https://motherofpearl.id/products/c-m-i-i-w-skin-corrector
g-w-s-gleaming-wonderful-shiny-plump-gloss-01-mlbb	G.W.S (Gleaming, Wonderful, Shiny) Plump Gloss	\N	plumping	4 ml	12 months	https://motherofpearl.id/products/g-w-s-gleaming-wonderful-shiny-plump-gloss-01-mlbb
invincible-nano-gel-capsule-sunscreen-spf50-pa	Invincible Nano Gel Capsule Sunscreen SPF50+/PA++++	\N	protective	30 ml	12 months	https://motherofpearl.id/products/invincible-nano-gel-capsule-sunscreen-spf50-pa
lip-sculptor	Lip Sculptor Lip Liner	\N	sculpting	\N	\N	https://motherofpearl.id/products/lip-sculptor
lippy-shield-nourishing-and-protecting-balm-spf-35-pa	Lippy Shield Nourishing and Protecting Balm SPF 35 PA++++	\N	nourishing	3.3 g	12 months	https://motherofpearl.id/products/lippy-shield-nourishing-and-protecting-balm-spf-35-pa
maxcara-volumizing-lengthening-mascara	MaxCara Volumizing & Lengthening Mascara	\N	lengthening	\N	\N	https://motherofpearl.id/products/maxcara-volumizing-lengthening-mascara
microblur-translucent-loose-powder	Microblur Loose Powder	\N	blurring	8.5 g	\N	https://motherofpearl.id/products/microblur-translucent-loose-powder
microblur-translucent-pressed-powder	Microblur Translucent Pressed Powder	\N	mattifying	\N	\N	https://motherofpearl.id/products/microblur-translucent-pressed-powder
mop-bloom-maximum-intensity-pigment-blusher	BLOOM Maximum Intensity Pigment Blusher	\N	buildable	3 g	18 months	https://motherofpearl.id/products/mop-bloom-maximum-intensity-pigment-blusher
mop-bloomdrop-longwear-liquid-blush	BloomDrop Longwear Liquid Blush	\N	radiant	3.5 g	\N	https://motherofpearl.id/products/mop-bloomdrop-longwear-liquid-blush
mop-c-o-a-center-of-attention-ultra-cover-long-lasting-powder-foundation	C.O.A (Center of Attention) Ultra Cover Long-Lasting Powder Foundation	\N	high-coverage	\N	\N	https://motherofpearl.id/products/mop-c-o-a-center-of-attention-ultra-cover-long-lasting-powder-foundation
mop-cover-age-high-coverage-creamy-concealer	Cover Age High Coverage Creamy Concealer	\N	concealing	\N	\N	https://motherofpearl.id/products/mop-cover-age-high-coverage-creamy-concealer
mop-multifunctional-brush	Multifunctional Liquid Brush	\N	blending	\N	\N	https://motherofpearl.id/products/mop-multifunctional-brush
mop-picture-perfect-soft-focus-satin-concealer	Picture Perfect Soft-Focus Satin Concealer	\N	satin-smooth	\N	\N	https://motherofpearl.id/products/mop-picture-perfect-soft-focus-satin-concealer
mop-unbothered-demi-matte-cushion	Unbothered Demi-Matte Cushion SPF 40 PA ++++	\N	demi-matte	\N	\N	https://motherofpearl.id/products/mop-unbothered-demi-matte-cushion
mother-of-puff-beauty-sponge	Mother of Puff Beauty Sponge	\N	bouncy	5 g	\N	https://motherofpearl.id/products/mother-of-puff-beauty-sponge
my-perfect-nude-lip-cream	My Perfect Nude Lip Cream	\N	nude-wear	6 ml	12 months	https://motherofpearl.id/products/my-perfect-nude-lip-cream
so-x-tra-hybrid-matte-foundation-peptides-infused-spf-40-pa	So X-TRA! Hybrid Matte Foundation Peptides Infused SPF 40 PA++	\N	high-coverage	38 ml	12 months	https://motherofpearl.id/products/so-x-tra-hybrid-matte-foundation-peptides-infused-spf-40-pa
tender-touch-creamy-butter-bronzer	Tender Touch Creamy Butter Bronzer	\N	bronzing	4.5 g	12 months	https://motherofpearl.id/products/tender-touch-creamy-butter-bronzer
tender-touch-creamy-butter-contour	Tender Touch Creamy Butter Contour	\N	sculpting	4.5 g	12 months	https://motherofpearl.id/products/tender-touch-creamy-butter-contour
tender-touch-illuminating-finishing-powder	Tender Touch Illuminating Finishing Powder	\N	illuminating	4 g	12 months	https://motherofpearl.id/products/tender-touch-illuminating-finishing-powder
tender-touch-soft-ombre-powder-blush	Tender Touch Soft Ombré Powder Blush	\N	soft-blend	\N	\N	https://motherofpearl.id/products/tender-touch-soft-ombre-powder-blush
vantablack-waterproof-precision-liner	Vantablack Waterproof Precision Liner	\N	precision	1.3 ml	\N	https://motherofpearl.id/products/vantablack-waterproof-precision-liner
\.


--
-- Data for Name: variants; Type: TABLE DATA; Schema: public; Owner: danesha
--

COPY public.variants (variant_id, product_id, sku, shade_name, price, compare_at_price, availability, bpom_number) FROM stdin;
48497983553780	abracadabrow-tinted-brow-laminator-universal-ash	OFB8H24	Universal Ash	101150.00	119000.00	InStock	\N
48497983586548	abracadabrow-tinted-brow-laminator-universal-ash	OFB8J144	Dark Brown	101150.00	119000.00	InStock	\N
48497983619316	abracadabrow-tinted-brow-laminator-universal-ash	OFB8J145	Ash Brown	101150.00	119000.00	InStock	\N
48497983652084	abracadabrow-tinted-brow-laminator-universal-ash	OFB8J146	Chocolate	101150.00	119000.00	InStock	\N
46618478149876	am-to-pm-colorfast-hypertint-01-date-night	OFB8J41	Date Night	89100.00	99000.00	InStock	NA18231300569
46618478182644	am-to-pm-colorfast-hypertint-01-date-night	OFB8J42	Gym Sesh	89100.00	99000.00	InStock	NA18231300567
46618478215412	am-to-pm-colorfast-hypertint-01-date-night	OFB8J43	Night Ride	89100.00	99000.00	InStock	NA18231300570
46618478248180	am-to-pm-colorfast-hypertint-01-date-night	OFB8J44	Game Day	89100.00	99000.00	InStock	NA18231300584
46618478280948	am-to-pm-colorfast-hypertint-01-date-night	OFB8J45	Coffee Break	89100.00	99000.00	InStock	NA18231300583
46618478313716	am-to-pm-colorfast-hypertint-01-date-night	OFB8J46	Office Hours	89100.00	99000.00	InStock	NA18231300568
46618478346484	am-to-pm-colorfast-hypertint-01-date-night	OFB8J47	Brunch	89100.00	99000.00	InStock	NA18231300566
46618478379252	am-to-pm-colorfast-hypertint-01-date-night	OFB8J48	Movie Time	89100.00	99000.00	InStock	NA18231300582
46618478412020	am-to-pm-colorfast-hypertint-01-date-night	OFB8J49	Staycation	89100.00	99000.00	InStock	\N
46618478444788	am-to-pm-colorfast-hypertint-01-date-night	OFB8J50	Healing Time	89100.00	99000.00	InStock	\N
46618478477556	am-to-pm-colorfast-hypertint-01-date-night	OFB8J51	Morning Tea	89100.00	99000.00	InStock	\N
46618478510324	am-to-pm-colorfast-hypertint-01-date-night	OFB8J52	Golden Hour	89100.00	99000.00	InStock	\N
46292079313140	anti-cakey-lock-and-smooth-gripping-primer	OFB8J16	\N	173630.00	179000.00	InStock	NA18210300271
44315834712308	browgraphy-angled-precision-brow-pen-01-dark-brown	OFB8H20	Dark Brown	73030.00	109000.00	InStock	\N
44315834745076	browgraphy-angled-precision-brow-pen-01-dark-brown	OFB8H21	Ash Brown	73030.00	109000.00	OutOfStock	\N
44315834777844	browgraphy-angled-precision-brow-pen-01-dark-brown	OFB8H22	Chocolate	73030.00	109000.00	OutOfStock	\N
45387283300596	bulletproof-set-and-protect-continous-mist	OFB8J11	Satin 50ml	77400.00	129000.00	InStock	\N
45387283366132	bulletproof-set-and-protect-continous-mist	OFB8J12	Matte 50ml	77400.00	129000.00	InStock	\N
46308535009524	bulletproof-set-and-protect-continous-mist	OFB8J28	Satin 150ml	139880.00	269000.00	InStock	\N
46308535042292	bulletproof-set-and-protect-continous-mist	OFB8J29	Matte 150ml	134500.00	269000.00	InStock	\N
46284794102004	c-m-i-i-w-skin-corrector	OFB8J18	Peach Me If I'm Dull	101150.00	119000.00	InStock	NA18230301127
46284794134772	c-m-i-i-w-skin-corrector	OFB8J17	Yellow Me If I'm Red	101150.00	119000.00	InStock	NA18230301126
46284845351156	g-w-s-gleaming-wonderful-shiny-plump-gloss-01-mlbb	OFB8J22	MLBB	84150.00	99000.00	InStock	NA18231300591
46284849578228	g-w-s-gleaming-wonderful-shiny-plump-gloss-01-mlbb	OFB8J23	Nudieversal	84150.00	99000.00	InStock	NA18231300589
46287092613364	g-w-s-gleaming-wonderful-shiny-plump-gloss-01-mlbb	OFB8J24	Berryphoria	87120.00	99000.00	InStock	NA18231300590
46284853051636	g-w-s-gleaming-wonderful-shiny-plump-gloss-01-mlbb	OFB8J25	Mauversal	99000.00	\N	InStock	\N
46284836536564	g-w-s-gleaming-wonderful-shiny-plump-gloss-01-mlbb	OFB8J26	Choco Loco	84150.00	99000.00	InStock	\N
46284834472180	g-w-s-gleaming-wonderful-shiny-plump-gloss-01-mlbb	OFB8J27	Rosy Posy	84150.00	99000.00	InStock	\N
46656554762484	g-w-s-gleaming-wonderful-shiny-plump-gloss-01-mlbb	OFB8J53	GWS XTRA Fiery Peach	87120.00	99000.00	InStock	\N
46284791644404	invincible-nano-gel-capsule-sunscreen-spf50-pa	OFB8J20	\N	126750.00	169000.00	InStock	\N
48514059993332	lip-sculptor	OFB8J124	01 Mauve	119000.00	\N	OutOfStock	\N
48514060026100	lip-sculptor	OFB8J125	02 Chestnut	119000.00	\N	OutOfStock	\N
46284843712756	lippy-shield-nourishing-and-protecting-balm-spf-35-pa	OFB8J21	\N	84150.00	99000.00	InStock	\N
46750896685300	maxcara-volumizing-lengthening-mascara	OFB8J54	MaxCara	104300.00	149000.00	InStock	\N
48637699916020	maxcara-volumizing-lengthening-mascara	OFB8J73	Maxcara Remover	59000.00	149000.00	InStock	\N
48541955064052	microblur-translucent-loose-powder	OFB8J19	Translucent 8.5gr	131970.00	159000.00	InStock	\N
48541955096820	microblur-translucent-loose-powder	OFB8J119	Oat 8.5gr	131970.00	159000.00	InStock	\N
48541955129588	microblur-translucent-loose-powder	OFB8J120	Wheat 8.5gr	131970.00	159000.00	InStock	\N
48541955162356	microblur-translucent-loose-powder	OFB8J121	Latte 8.5gr	131970.00	159000.00	InStock	\N
48541955195124	microblur-translucent-loose-powder	OFB8J40	Translucent 20gr	200970.00	159000.00	InStock	\N
48514683273460	microblur-translucent-pressed-powder	OFB8J97	\N	154980.00	189000.00	InStock	\N
47354368262388	mop-bloom-maximum-intensity-pigment-blusher	OFB8J100	Blushwood	109480.00	259000.00	InStock	\N
47354368295156	mop-bloom-maximum-intensity-pigment-blusher	OFB8J101	Carmine	109480.00	259000.00	InStock	\N
47354368327924	mop-bloom-maximum-intensity-pigment-blusher	OFB8J102	Sienna	109480.00	259000.00	InStock	\N
48511801950452	mop-bloom-maximum-intensity-pigment-blusher	OFB8J103	Camellia	109480.00	259000.00	OutOfStock	\N
48511801983220	mop-bloom-maximum-intensity-pigment-blusher	OFB8J98	Carnation	109480.00	259000.00	OutOfStock	\N
48511802015988	mop-bloom-maximum-intensity-pigment-blusher	OFB8J99	Roseatte	109480.00	259000.00	OutOfStock	\N
47354371637492	mop-bloomdrop-longwear-liquid-blush	OFB8J111	Carnation	98770.00	119000.00	InStock	\N
47354371670260	mop-bloomdrop-longwear-liquid-blush	OFB8J114	Mauvelle	98770.00	119000.00	InStock	\N
47354371703028	mop-bloomdrop-longwear-liquid-blush	OFB8J118	Dahlia	98770.00	119000.00	InStock	\N
47354371735796	mop-bloomdrop-longwear-liquid-blush	OFB8J116	Cherry Blossom	98770.00	119000.00	InStock	\N
47354371768564	mop-bloomdrop-longwear-liquid-blush	OFB8J113	Lulu	98770.00	119000.00	InStock	\N
47354371801332	mop-bloomdrop-longwear-liquid-blush	OFB8J115	Marygold	98770.00	119000.00	InStock	\N
47727026307316	mop-bloomdrop-longwear-liquid-blush	OFB8J117	Terra	98770.00	119000.00	InStock	\N
47727026340084	mop-bloomdrop-longwear-liquid-blush	OFB8J112	Mulberry	98770.00	119000.00	InStock	\N
47354365673716	mop-c-o-a-center-of-attention-ultra-cover-long-lasting-powder-foundation	OFB8J89	N10 LACE	149310.00	189000.00	InStock	\N
46294945988852	tender-touch-illuminating-finishing-powder	OFB8J13	\N	101910.00	129000.00	InStock	\N
47354365706484	mop-c-o-a-center-of-attention-ultra-cover-long-lasting-powder-foundation	OFB8J89	C10 PEARL	149310.00	189000.00	InStock	\N
47354365739252	mop-c-o-a-center-of-attention-ultra-cover-long-lasting-powder-foundation	OFB8J90	W10 CAMEL	154980.00	189000.00	InStock	\N
47354365772020	mop-c-o-a-center-of-attention-ultra-cover-long-lasting-powder-foundation	OFB8J92	W11 SHELL	154980.00	189000.00	InStock	\N
47354365804788	mop-c-o-a-center-of-attention-ultra-cover-long-lasting-powder-foundation	OFB8J93	N21 ECLAIR	154980.00	189000.00	InStock	\N
47354365837556	mop-c-o-a-center-of-attention-ultra-cover-long-lasting-powder-foundation	OFB8J94	W20 CINNAMON	149310.00	189000.00	InStock	\N
47354365870324	mop-c-o-a-center-of-attention-ultra-cover-long-lasting-powder-foundation	OFB8J95	N30 TUSCAN	154980.00	189000.00	InStock	\N
47354365903092	mop-c-o-a-center-of-attention-ultra-cover-long-lasting-powder-foundation	OFB8J96	W31 CARAMEL	154980.00	189000.00	InStock	\N
46705977295092	mop-cover-age-high-coverage-creamy-concealer	OFB8J70	W10 CAMEL	125300.00	179000.00	InStock	\N
46705977327860	mop-cover-age-high-coverage-creamy-concealer	OFB8J67	N10 LACE	125300.00	179000.00	InStock	\N
46705977360628	mop-cover-age-high-coverage-creamy-concealer	OFB8J65	C10 PEARL	125300.00	179000.00	InStock	\N
46705977393396	mop-cover-age-high-coverage-creamy-concealer	OFB8J71	W11 SHELL	102030.00	179000.00	InStock	\N
46705977426164	mop-cover-age-high-coverage-creamy-concealer	OFB8J72	W20 CINNAMON	125300.00	179000.00	InStock	\N
46705977458932	mop-cover-age-high-coverage-creamy-concealer	OFB8J68	N21 ECLAIR	125300.00	179000.00	InStock	\N
46705977491700	mop-cover-age-high-coverage-creamy-concealer	OFB8J69	N30 TUSCAN	125300.00	179000.00	InStock	\N
46853587665140	mop-multifunctional-brush	OFB8J74	\N	113520.00	129000.00	InStock	\N
46705884070132	mop-picture-perfect-soft-focus-satin-concealer	OFB8J56	N00 SILK	110980.00	179000.00	InStock	\N
46705884102900	mop-picture-perfect-soft-focus-satin-concealer	OFB8J57	N10 LACE	110980.00	179000.00	InStock	\N
46705884135668	mop-picture-perfect-soft-focus-satin-concealer	OFB8J58	C10 PEARL	110980.00	179000.00	InStock	\N
46705884168436	mop-picture-perfect-soft-focus-satin-concealer	OFB8J59	W10 CAMEL	110980.00	179000.00	InStock	\N
46705884201204	mop-picture-perfect-soft-focus-satin-concealer	OFB8J60	W11 SHELL	110980.00	179000.00	InStock	\N
46705884233972	mop-picture-perfect-soft-focus-satin-concealer	OFB8J61	N21 ECLAIR	110980.00	179000.00	InStock	\N
46705884266740	mop-picture-perfect-soft-focus-satin-concealer	OFB8J62	W20 CINNAMON	110980.00	179000.00	InStock	\N
46705884299508	mop-picture-perfect-soft-focus-satin-concealer	OFB8J63	N31 PECAN	110980.00	179000.00	OutOfStock	\N
46705884332276	mop-picture-perfect-soft-focus-satin-concealer	OFB8J64	W31 CARAMEL	110980.00	179000.00	InStock	\N
48774876856564	mop-unbothered-demi-matte-cushion	OFB8J135	Porcelain	170940.00	259000.00	InStock	\N
48774876889332	mop-unbothered-demi-matte-cushion	OFB8J137	Silk	170940.00	259000.00	InStock	\N
48774876922100	mop-unbothered-demi-matte-cushion	OFB8J138	Milk	170940.00	259000.00	InStock	\N
48774876954868	mop-unbothered-demi-matte-cushion	OFB8J128	Oat	170940.00	259000.00	InStock	\N
48774876987636	mop-unbothered-demi-matte-cushion	OFB8J127	Pearl	170940.00	259000.00	InStock	\N
48774877020404	mop-unbothered-demi-matte-cushion	OFB8J126	Cashmere	170940.00	259000.00	InStock	\N
48774877053172	mop-unbothered-demi-matte-cushion	OFB8J134	Chiffon	170940.00	259000.00	InStock	\N
48774877085940	mop-unbothered-demi-matte-cushion	OFB8J129	Lace	170940.00	259000.00	InStock	\N
48774877118708	mop-unbothered-demi-matte-cushion	OFB8J136	Creme	170940.00	259000.00	InStock	\N
48774877151476	mop-unbothered-demi-matte-cushion	OFB8J130	Eclair	170940.00	259000.00	InStock	\N
48774877184244	mop-unbothered-demi-matte-cushion	OFB8J131	Toffee	170940.00	259000.00	InStock	\N
48774877217012	mop-unbothered-demi-matte-cushion	OFB8J132	Soy	170940.00	259000.00	InStock	\N
48774877249780	mop-unbothered-demi-matte-cushion	OFB8J133	Cinnamon	170940.00	259000.00	InStock	\N
48774877282548	mop-unbothered-demi-matte-cushion	OFB8K87	Caramel	170940.00	259000.00	InStock	\N
46284966658292	mother-of-puff-beauty-sponge	OFB8H96	\N	69520.00	79000.00	InStock	\N
46299723890932	my-perfect-nude-lip-cream	OFB8J76	02. Milk Tea	113050.00	119000.00	InStock	\N
46299723923700	my-perfect-nude-lip-cream	OFB8J77	03. Fresh Salmon	113050.00	119000.00	InStock	\N
46299723956468	my-perfect-nude-lip-cream	OFB8J78	04. Sandy Taupe	113050.00	119000.00	InStock	\N
46299723989236	my-perfect-nude-lip-cream	OFB8J79	05. Dusty Blush	113050.00	119000.00	OutOfStock	\N
46299724022004	my-perfect-nude-lip-cream	OFB8J80	06. Rosy Beige	113050.00	119000.00	InStock	\N
46299724054772	my-perfect-nude-lip-cream	OFB8J81	07. Mauve Wood	113050.00	119000.00	InStock	\N
46299724087540	my-perfect-nude-lip-cream	OFB8J82	08. Toffee Latte	113050.00	119000.00	InStock	\N
46299724120308	my-perfect-nude-lip-cream	OFB8J83	09. Desert Coral	113050.00	119000.00	InStock	\N
46299724153076	my-perfect-nude-lip-cream	OFB8J84	10. Burnt Peach	113050.00	119000.00	OutOfStock	\N
46299724185844	my-perfect-nude-lip-cream	OFB8J85	11. Honeycomb	113050.00	119000.00	InStock	\N
46299724218612	my-perfect-nude-lip-cream	OFB8J86	12. Almond Butter	113050.00	119000.00	InStock	\N
46299724251380	my-perfect-nude-lip-cream	OFB8J87	13. Hot Cocoa	113050.00	119000.00	InStock	\N
46476850921716	so-x-tra-hybrid-matte-foundation-peptides-infused-spf-40-pa	OFB8J31	W00 CHIFFON	141290.00	199000.00	InStock	\N
46476850954484	so-x-tra-hybrid-matte-foundation-peptides-infused-spf-40-pa	OFB8J32	N10 LACE	141290.00	199000.00	InStock	\N
46476850987252	so-x-tra-hybrid-matte-foundation-peptides-infused-spf-40-pa	OFB8J33	C10 PEARL	141290.00	199000.00	InStock	\N
46476851020020	so-x-tra-hybrid-matte-foundation-peptides-infused-spf-40-pa	OFB8J34	W11 SHELL	141290.00	199000.00	OutOfStock	\N
46476851052788	so-x-tra-hybrid-matte-foundation-peptides-infused-spf-40-pa	OFB8J35	C20 SAND	141290.00	199000.00	InStock	\N
46476851085556	so-x-tra-hybrid-matte-foundation-peptides-infused-spf-40-pa	OFB8J36	N21 ECLAIR	141290.00	199000.00	OutOfStock	\N
46476851118324	so-x-tra-hybrid-matte-foundation-peptides-infused-spf-40-pa	OFB8J37	W21 LATTE	141290.00	199000.00	OutOfStock	\N
46476851151092	so-x-tra-hybrid-matte-foundation-peptides-infused-spf-40-pa	OFB8J38	W23 DESSERT	141290.00	199000.00	InStock	\N
46476851183860	so-x-tra-hybrid-matte-foundation-peptides-infused-spf-40-pa	OFB8J39	N31 PECAN	141290.00	199000.00	InStock	\N
46294932390132	tender-touch-creamy-butter-bronzer	OFB8J122	\N	103530.00	119000.00	InStock	\N
46294942744820	tender-touch-creamy-butter-contour	OFB8J123	\N	103530.00	119000.00	InStock	\N
44386943697140	tender-touch-soft-ombre-powder-blush	OFB8H74	Mariposa	85140.00	129000.00	InStock	\N
44386943729908	tender-touch-soft-ombre-powder-blush	OFB8H75	Papilon	64500.00	129000.00	InStock	\N
44386943762676	tender-touch-soft-ombre-powder-blush	OFB8H76	Yarra	64500.00	129000.00	InStock	\N
44386943795444	tender-touch-soft-ombre-powder-blush	OFB8H77	Paloma	85140.00	129000.00	InStock	\N
44386943828212	tender-touch-soft-ombre-powder-blush	OFB8H78	Farasha	129000.00	\N	OutOfStock	\N
44259543482612	vantablack-waterproof-precision-liner	OFB8H23	\N	82170.00	99000.00	InStock	NA11221200271
\.


--
-- Data for Name: availability; Type: TABLE DATA; Schema: warehouse; Owner: danesha
--

COPY warehouse.availability (availability_id, status) FROM stdin;
1	OutOfStock
2	InStock
\.


--
-- Data for Name: sales; Type: TABLE DATA; Schema: warehouse; Owner: danesha
--

COPY warehouse.sales (product_id, variant_id, category_id, availability_id, price, compare_at_price, discount_amount, discount_percentage) FROM stdin;
abracadabrow-tinted-brow-laminator-universal-ash	48497983553780	1	2	101150.00	119000.00	17850.00	15.00
abracadabrow-tinted-brow-laminator-universal-ash	48497983586548	1	2	101150.00	119000.00	17850.00	15.00
abracadabrow-tinted-brow-laminator-universal-ash	48497983619316	1	2	101150.00	119000.00	17850.00	15.00
abracadabrow-tinted-brow-laminator-universal-ash	48497983652084	1	2	101150.00	119000.00	17850.00	15.00
am-to-pm-colorfast-hypertint-01-date-night	46618478149876	1	2	89100.00	99000.00	9900.00	10.00
am-to-pm-colorfast-hypertint-01-date-night	46618478182644	1	2	89100.00	99000.00	9900.00	10.00
am-to-pm-colorfast-hypertint-01-date-night	46618478215412	1	2	89100.00	99000.00	9900.00	10.00
am-to-pm-colorfast-hypertint-01-date-night	46618478248180	1	2	89100.00	99000.00	9900.00	10.00
am-to-pm-colorfast-hypertint-01-date-night	46618478280948	1	2	89100.00	99000.00	9900.00	10.00
am-to-pm-colorfast-hypertint-01-date-night	46618478313716	1	2	89100.00	99000.00	9900.00	10.00
am-to-pm-colorfast-hypertint-01-date-night	46618478346484	1	2	89100.00	99000.00	9900.00	10.00
am-to-pm-colorfast-hypertint-01-date-night	46618478379252	1	2	89100.00	99000.00	9900.00	10.00
am-to-pm-colorfast-hypertint-01-date-night	46618478412020	1	2	89100.00	99000.00	9900.00	10.00
am-to-pm-colorfast-hypertint-01-date-night	46618478444788	1	2	89100.00	99000.00	9900.00	10.00
am-to-pm-colorfast-hypertint-01-date-night	46618478477556	1	2	89100.00	99000.00	9900.00	10.00
am-to-pm-colorfast-hypertint-01-date-night	46618478510324	1	2	89100.00	99000.00	9900.00	10.00
anti-cakey-lock-and-smooth-gripping-primer	46292079313140	1	2	173630.00	179000.00	5370.00	3.00
browgraphy-angled-precision-brow-pen-01-dark-brown	44315834712308	2	2	73030.00	109000.00	35970.00	33.00
browgraphy-angled-precision-brow-pen-01-dark-brown	44315834745076	2	1	73030.00	109000.00	35970.00	33.00
browgraphy-angled-precision-brow-pen-01-dark-brown	44315834777844	2	1	73030.00	109000.00	35970.00	33.00
bulletproof-set-and-protect-continous-mist	45387283300596	1	2	77400.00	129000.00	51600.00	40.00
bulletproof-set-and-protect-continous-mist	45387283366132	1	2	77400.00	129000.00	51600.00	40.00
bulletproof-set-and-protect-continous-mist	46308535009524	1	2	139880.00	269000.00	129120.00	48.00
bulletproof-set-and-protect-continous-mist	46308535042292	1	2	134500.00	269000.00	134500.00	50.00
c-m-i-i-w-skin-corrector	46284794102004	1	2	101150.00	119000.00	17850.00	15.00
c-m-i-i-w-skin-corrector	46284794134772	1	2	101150.00	119000.00	17850.00	15.00
g-w-s-gleaming-wonderful-shiny-plump-gloss-01-mlbb	46284845351156	3	2	84150.00	99000.00	14850.00	15.00
g-w-s-gleaming-wonderful-shiny-plump-gloss-01-mlbb	46284849578228	3	2	84150.00	99000.00	14850.00	15.00
g-w-s-gleaming-wonderful-shiny-plump-gloss-01-mlbb	46287092613364	3	2	87120.00	99000.00	11880.00	12.00
g-w-s-gleaming-wonderful-shiny-plump-gloss-01-mlbb	46284853051636	3	2	99000.00	\N	0.00	0.00
g-w-s-gleaming-wonderful-shiny-plump-gloss-01-mlbb	46284836536564	3	2	84150.00	99000.00	14850.00	15.00
g-w-s-gleaming-wonderful-shiny-plump-gloss-01-mlbb	46284834472180	3	2	84150.00	99000.00	14850.00	15.00
g-w-s-gleaming-wonderful-shiny-plump-gloss-01-mlbb	46656554762484	3	2	87120.00	99000.00	11880.00	12.00
invincible-nano-gel-capsule-sunscreen-spf50-pa	46284791644404	5	2	126750.00	169000.00	42250.00	25.00
lip-sculptor	48514059993332	3	1	119000.00	\N	0.00	0.00
lip-sculptor	48514060026100	3	1	119000.00	\N	0.00	0.00
lippy-shield-nourishing-and-protecting-balm-spf-35-pa	46284843712756	5	2	84150.00	99000.00	14850.00	15.00
maxcara-volumizing-lengthening-mascara	46750896685300	2	2	104300.00	149000.00	44700.00	30.00
maxcara-volumizing-lengthening-mascara	48637699916020	2	2	59000.00	149000.00	90000.00	60.40
microblur-translucent-loose-powder	48541955064052	1	2	131970.00	159000.00	27030.00	17.00
microblur-translucent-loose-powder	48541955096820	1	2	131970.00	159000.00	27030.00	17.00
microblur-translucent-loose-powder	48541955129588	1	2	131970.00	159000.00	27030.00	17.00
microblur-translucent-loose-powder	48541955162356	1	2	131970.00	159000.00	27030.00	17.00
microblur-translucent-loose-powder	48541955195124	1	2	200970.00	159000.00	-41970.00	-26.40
microblur-translucent-pressed-powder	48514683273460	1	2	154980.00	189000.00	34020.00	18.00
mop-bloom-maximum-intensity-pigment-blusher	47354368262388	4	2	109480.00	259000.00	149520.00	57.73
mop-bloom-maximum-intensity-pigment-blusher	47354368295156	4	2	109480.00	259000.00	149520.00	57.73
mop-bloom-maximum-intensity-pigment-blusher	47354368327924	4	2	109480.00	259000.00	149520.00	57.73
mop-bloom-maximum-intensity-pigment-blusher	48511801950452	4	1	109480.00	259000.00	149520.00	57.73
mop-bloom-maximum-intensity-pigment-blusher	48511801983220	4	1	109480.00	259000.00	149520.00	57.73
mop-bloom-maximum-intensity-pigment-blusher	48511802015988	4	1	109480.00	259000.00	149520.00	57.73
mop-bloomdrop-longwear-liquid-blush	47354371637492	4	2	98770.00	119000.00	20230.00	17.00
mop-bloomdrop-longwear-liquid-blush	47354371670260	4	2	98770.00	119000.00	20230.00	17.00
mop-bloomdrop-longwear-liquid-blush	47354371703028	4	2	98770.00	119000.00	20230.00	17.00
mop-bloomdrop-longwear-liquid-blush	47354371735796	4	2	98770.00	119000.00	20230.00	17.00
mop-bloomdrop-longwear-liquid-blush	47354371768564	4	2	98770.00	119000.00	20230.00	17.00
mop-bloomdrop-longwear-liquid-blush	47354371801332	4	2	98770.00	119000.00	20230.00	17.00
mop-bloomdrop-longwear-liquid-blush	47727026307316	4	2	98770.00	119000.00	20230.00	17.00
mop-bloomdrop-longwear-liquid-blush	47727026340084	4	2	98770.00	119000.00	20230.00	17.00
mop-c-o-a-center-of-attention-ultra-cover-long-lasting-powder-foundation	47354365673716	1	2	149310.00	189000.00	39690.00	21.00
tender-touch-illuminating-finishing-powder	46294945988852	4	2	101910.00	129000.00	27090.00	21.00
mop-c-o-a-center-of-attention-ultra-cover-long-lasting-powder-foundation	47354365706484	1	2	149310.00	189000.00	39690.00	21.00
mop-c-o-a-center-of-attention-ultra-cover-long-lasting-powder-foundation	47354365739252	1	2	154980.00	189000.00	34020.00	18.00
mop-c-o-a-center-of-attention-ultra-cover-long-lasting-powder-foundation	47354365772020	1	2	154980.00	189000.00	34020.00	18.00
mop-c-o-a-center-of-attention-ultra-cover-long-lasting-powder-foundation	47354365804788	1	2	154980.00	189000.00	34020.00	18.00
mop-c-o-a-center-of-attention-ultra-cover-long-lasting-powder-foundation	47354365837556	1	2	149310.00	189000.00	39690.00	21.00
mop-c-o-a-center-of-attention-ultra-cover-long-lasting-powder-foundation	47354365870324	1	2	154980.00	189000.00	34020.00	18.00
mop-c-o-a-center-of-attention-ultra-cover-long-lasting-powder-foundation	47354365903092	1	2	154980.00	189000.00	34020.00	18.00
mop-cover-age-high-coverage-creamy-concealer	46705977295092	1	2	125300.00	179000.00	53700.00	30.00
mop-cover-age-high-coverage-creamy-concealer	46705977327860	1	2	125300.00	179000.00	53700.00	30.00
mop-cover-age-high-coverage-creamy-concealer	46705977360628	1	2	125300.00	179000.00	53700.00	30.00
mop-cover-age-high-coverage-creamy-concealer	46705977393396	1	2	102030.00	179000.00	76970.00	43.00
mop-cover-age-high-coverage-creamy-concealer	46705977426164	1	2	125300.00	179000.00	53700.00	30.00
mop-cover-age-high-coverage-creamy-concealer	46705977458932	1	2	125300.00	179000.00	53700.00	30.00
mop-cover-age-high-coverage-creamy-concealer	46705977491700	1	2	125300.00	179000.00	53700.00	30.00
mop-multifunctional-brush	46853587665140	6	2	113520.00	129000.00	15480.00	12.00
mop-picture-perfect-soft-focus-satin-concealer	46705884070132	1	2	110980.00	179000.00	68020.00	38.00
mop-picture-perfect-soft-focus-satin-concealer	46705884102900	1	2	110980.00	179000.00	68020.00	38.00
mop-picture-perfect-soft-focus-satin-concealer	46705884135668	1	2	110980.00	179000.00	68020.00	38.00
mop-picture-perfect-soft-focus-satin-concealer	46705884168436	1	2	110980.00	179000.00	68020.00	38.00
mop-picture-perfect-soft-focus-satin-concealer	46705884201204	1	2	110980.00	179000.00	68020.00	38.00
mop-picture-perfect-soft-focus-satin-concealer	46705884233972	1	2	110980.00	179000.00	68020.00	38.00
mop-picture-perfect-soft-focus-satin-concealer	46705884266740	1	2	110980.00	179000.00	68020.00	38.00
mop-picture-perfect-soft-focus-satin-concealer	46705884299508	1	1	110980.00	179000.00	68020.00	38.00
mop-picture-perfect-soft-focus-satin-concealer	46705884332276	1	2	110980.00	179000.00	68020.00	38.00
mop-unbothered-demi-matte-cushion	48774876856564	1	2	170940.00	259000.00	88060.00	34.00
mop-unbothered-demi-matte-cushion	48774876889332	1	2	170940.00	259000.00	88060.00	34.00
mop-unbothered-demi-matte-cushion	48774876922100	1	2	170940.00	259000.00	88060.00	34.00
mop-unbothered-demi-matte-cushion	48774876954868	1	2	170940.00	259000.00	88060.00	34.00
mop-unbothered-demi-matte-cushion	48774876987636	1	2	170940.00	259000.00	88060.00	34.00
mop-unbothered-demi-matte-cushion	48774877020404	1	2	170940.00	259000.00	88060.00	34.00
mop-unbothered-demi-matte-cushion	48774877053172	1	2	170940.00	259000.00	88060.00	34.00
mop-unbothered-demi-matte-cushion	48774877085940	1	2	170940.00	259000.00	88060.00	34.00
mop-unbothered-demi-matte-cushion	48774877118708	1	2	170940.00	259000.00	88060.00	34.00
mop-unbothered-demi-matte-cushion	48774877151476	1	2	170940.00	259000.00	88060.00	34.00
mop-unbothered-demi-matte-cushion	48774877184244	1	2	170940.00	259000.00	88060.00	34.00
mop-unbothered-demi-matte-cushion	48774877217012	1	2	170940.00	259000.00	88060.00	34.00
mop-unbothered-demi-matte-cushion	48774877249780	1	2	170940.00	259000.00	88060.00	34.00
mop-unbothered-demi-matte-cushion	48774877282548	1	2	170940.00	259000.00	88060.00	34.00
mother-of-puff-beauty-sponge	46284966658292	6	2	69520.00	79000.00	9480.00	12.00
my-perfect-nude-lip-cream	46299723890932	3	2	113050.00	119000.00	5950.00	5.00
my-perfect-nude-lip-cream	46299723923700	3	2	113050.00	119000.00	5950.00	5.00
my-perfect-nude-lip-cream	46299723956468	3	2	113050.00	119000.00	5950.00	5.00
my-perfect-nude-lip-cream	46299723989236	3	1	113050.00	119000.00	5950.00	5.00
my-perfect-nude-lip-cream	46299724022004	3	2	113050.00	119000.00	5950.00	5.00
my-perfect-nude-lip-cream	46299724054772	3	2	113050.00	119000.00	5950.00	5.00
my-perfect-nude-lip-cream	46299724087540	3	2	113050.00	119000.00	5950.00	5.00
my-perfect-nude-lip-cream	46299724120308	3	2	113050.00	119000.00	5950.00	5.00
my-perfect-nude-lip-cream	46299724153076	3	1	113050.00	119000.00	5950.00	5.00
my-perfect-nude-lip-cream	46299724185844	3	2	113050.00	119000.00	5950.00	5.00
my-perfect-nude-lip-cream	46299724218612	3	2	113050.00	119000.00	5950.00	5.00
my-perfect-nude-lip-cream	46299724251380	3	2	113050.00	119000.00	5950.00	5.00
so-x-tra-hybrid-matte-foundation-peptides-infused-spf-40-pa	46476850921716	1	2	141290.00	199000.00	57710.00	29.00
so-x-tra-hybrid-matte-foundation-peptides-infused-spf-40-pa	46476850954484	1	2	141290.00	199000.00	57710.00	29.00
so-x-tra-hybrid-matte-foundation-peptides-infused-spf-40-pa	46476850987252	1	2	141290.00	199000.00	57710.00	29.00
so-x-tra-hybrid-matte-foundation-peptides-infused-spf-40-pa	46476851020020	1	1	141290.00	199000.00	57710.00	29.00
so-x-tra-hybrid-matte-foundation-peptides-infused-spf-40-pa	46476851052788	1	2	141290.00	199000.00	57710.00	29.00
so-x-tra-hybrid-matte-foundation-peptides-infused-spf-40-pa	46476851085556	1	1	141290.00	199000.00	57710.00	29.00
so-x-tra-hybrid-matte-foundation-peptides-infused-spf-40-pa	46476851118324	1	1	141290.00	199000.00	57710.00	29.00
so-x-tra-hybrid-matte-foundation-peptides-infused-spf-40-pa	46476851151092	1	2	141290.00	199000.00	57710.00	29.00
so-x-tra-hybrid-matte-foundation-peptides-infused-spf-40-pa	46476851183860	1	2	141290.00	199000.00	57710.00	29.00
tender-touch-creamy-butter-bronzer	46294932390132	4	2	103530.00	119000.00	15470.00	13.00
tender-touch-creamy-butter-contour	46294942744820	4	2	103530.00	119000.00	15470.00	13.00
tender-touch-soft-ombre-powder-blush	44386943697140	4	2	85140.00	129000.00	43860.00	34.00
tender-touch-soft-ombre-powder-blush	44386943729908	4	2	64500.00	129000.00	64500.00	50.00
tender-touch-soft-ombre-powder-blush	44386943762676	4	2	64500.00	129000.00	64500.00	50.00
tender-touch-soft-ombre-powder-blush	44386943795444	4	2	85140.00	129000.00	43860.00	34.00
tender-touch-soft-ombre-powder-blush	44386943828212	4	1	129000.00	\N	0.00	0.00
vantablack-waterproof-precision-liner	44259543482612	2	2	82170.00	99000.00	16830.00	17.00
\.


--
-- Name: cart_items_cart_item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: danesha
--

SELECT pg_catalog.setval('public.cart_items_cart_item_id_seq', 1, false);


--
-- Name: carts_cart_id_seq; Type: SEQUENCE SET; Schema: public; Owner: danesha
--

SELECT pg_catalog.setval('public.carts_cart_id_seq', 1, false);


--
-- Name: categories_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: danesha
--

SELECT pg_catalog.setval('public.categories_category_id_seq', 6, true);


--
-- Name: customer_addresses_address_id_seq; Type: SEQUENCE SET; Schema: public; Owner: danesha
--

SELECT pg_catalog.setval('public.customer_addresses_address_id_seq', 1, false);


--
-- Name: customers_customer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: danesha
--

SELECT pg_catalog.setval('public.customers_customer_id_seq', 1, false);


--
-- Name: order_items_order_item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: danesha
--

SELECT pg_catalog.setval('public.order_items_order_item_id_seq', 1, false);


--
-- Name: orders_order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: danesha
--

SELECT pg_catalog.setval('public.orders_order_id_seq', 1, false);


--
-- Name: payments_payment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: danesha
--

SELECT pg_catalog.setval('public.payments_payment_id_seq', 1, false);


--
-- Name: availability_availability_id_seq; Type: SEQUENCE SET; Schema: warehouse; Owner: danesha
--

SELECT pg_catalog.setval('warehouse.availability_availability_id_seq', 2, true);


--
-- Name: bank_transfer_payments bank_transfer_payments_pkey; Type: CONSTRAINT; Schema: public; Owner: danesha
--

ALTER TABLE ONLY public.bank_transfer_payments
    ADD CONSTRAINT bank_transfer_payments_pkey PRIMARY KEY (payment_id);


--
-- Name: cart_items cart_items_pkey; Type: CONSTRAINT; Schema: public; Owner: danesha
--

ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT cart_items_pkey PRIMARY KEY (cart_item_id);


--
-- Name: carts carts_pkey; Type: CONSTRAINT; Schema: public; Owner: danesha
--

ALTER TABLE ONLY public.carts
    ADD CONSTRAINT carts_pkey PRIMARY KEY (cart_id);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: danesha
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (category_id);


--
-- Name: categories categories_slug_key; Type: CONSTRAINT; Schema: public; Owner: danesha
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_slug_key UNIQUE (slug);


--
-- Name: customer_addresses customer_addresses_pkey; Type: CONSTRAINT; Schema: public; Owner: danesha
--

ALTER TABLE ONLY public.customer_addresses
    ADD CONSTRAINT customer_addresses_pkey PRIMARY KEY (address_id);


--
-- Name: customers customers_email_key; Type: CONSTRAINT; Schema: public; Owner: danesha
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_email_key UNIQUE (email);


--
-- Name: customers customers_pkey; Type: CONSTRAINT; Schema: public; Owner: danesha
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (customer_id);


--
-- Name: ewallet_payments ewallet_payments_pkey; Type: CONSTRAINT; Schema: public; Owner: danesha
--

ALTER TABLE ONLY public.ewallet_payments
    ADD CONSTRAINT ewallet_payments_pkey PRIMARY KEY (payment_id);


--
-- Name: order_items order_items_pkey; Type: CONSTRAINT; Schema: public; Owner: danesha
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_pkey PRIMARY KEY (order_item_id);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: danesha
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (order_id);


--
-- Name: payments payments_pkey; Type: CONSTRAINT; Schema: public; Owner: danesha
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_pkey PRIMARY KEY (payment_id);


--
-- Name: product_categories product_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: danesha
--

ALTER TABLE ONLY public.product_categories
    ADD CONSTRAINT product_categories_pkey PRIMARY KEY (product_id, category_id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: danesha
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (product_id);


--
-- Name: variants variants_pkey; Type: CONSTRAINT; Schema: public; Owner: danesha
--

ALTER TABLE ONLY public.variants
    ADD CONSTRAINT variants_pkey PRIMARY KEY (variant_id);


--
-- Name: availability availability_pkey; Type: CONSTRAINT; Schema: warehouse; Owner: danesha
--

ALTER TABLE ONLY warehouse.availability
    ADD CONSTRAINT availability_pkey PRIMARY KEY (availability_id);


--
-- Name: availability availability_status_key; Type: CONSTRAINT; Schema: warehouse; Owner: danesha
--

ALTER TABLE ONLY warehouse.availability
    ADD CONSTRAINT availability_status_key UNIQUE (status);


--
-- Name: sales sales_pkey; Type: CONSTRAINT; Schema: warehouse; Owner: danesha
--

ALTER TABLE ONLY warehouse.sales
    ADD CONSTRAINT sales_pkey PRIMARY KEY (product_id, variant_id, category_id, availability_id);


--
-- Name: customer_addresses fk_address_customer; Type: FK CONSTRAINT; Schema: public; Owner: danesha
--

ALTER TABLE ONLY public.customer_addresses
    ADD CONSTRAINT fk_address_customer FOREIGN KEY (customer_id) REFERENCES public.customers(customer_id) ON DELETE CASCADE;


--
-- Name: bank_transfer_payments fk_banktransfer_payment; Type: FK CONSTRAINT; Schema: public; Owner: danesha
--

ALTER TABLE ONLY public.bank_transfer_payments
    ADD CONSTRAINT fk_banktransfer_payment FOREIGN KEY (payment_id) REFERENCES public.payments(payment_id) ON DELETE CASCADE;


--
-- Name: carts fk_cart_customer; Type: FK CONSTRAINT; Schema: public; Owner: danesha
--

ALTER TABLE ONLY public.carts
    ADD CONSTRAINT fk_cart_customer FOREIGN KEY (customer_id) REFERENCES public.customers(customer_id) ON DELETE CASCADE;


--
-- Name: cart_items fk_cartitem_cart; Type: FK CONSTRAINT; Schema: public; Owner: danesha
--

ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT fk_cartitem_cart FOREIGN KEY (cart_id) REFERENCES public.carts(cart_id) ON DELETE CASCADE;


--
-- Name: cart_items fk_cartitem_variant; Type: FK CONSTRAINT; Schema: public; Owner: danesha
--

ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT fk_cartitem_variant FOREIGN KEY (variant_id) REFERENCES public.variants(variant_id) ON DELETE RESTRICT;


--
-- Name: ewallet_payments fk_ewallet_payment; Type: FK CONSTRAINT; Schema: public; Owner: danesha
--

ALTER TABLE ONLY public.ewallet_payments
    ADD CONSTRAINT fk_ewallet_payment FOREIGN KEY (payment_id) REFERENCES public.payments(payment_id) ON DELETE CASCADE;


--
-- Name: orders fk_order_address; Type: FK CONSTRAINT; Schema: public; Owner: danesha
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT fk_order_address FOREIGN KEY (shipping_address_id) REFERENCES public.customer_addresses(address_id) ON DELETE RESTRICT;


--
-- Name: orders fk_order_customer; Type: FK CONSTRAINT; Schema: public; Owner: danesha
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT fk_order_customer FOREIGN KEY (customer_id) REFERENCES public.customers(customer_id) ON DELETE RESTRICT;


--
-- Name: order_items fk_orderitem_order; Type: FK CONSTRAINT; Schema: public; Owner: danesha
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT fk_orderitem_order FOREIGN KEY (order_id) REFERENCES public.orders(order_id) ON DELETE CASCADE;


--
-- Name: order_items fk_orderitem_variant; Type: FK CONSTRAINT; Schema: public; Owner: danesha
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT fk_orderitem_variant FOREIGN KEY (variant_id) REFERENCES public.variants(variant_id) ON DELETE RESTRICT;


--
-- Name: payments fk_payment_order; Type: FK CONSTRAINT; Schema: public; Owner: danesha
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT fk_payment_order FOREIGN KEY (order_id) REFERENCES public.orders(order_id) ON DELETE CASCADE;


--
-- Name: product_categories fk_pc_category; Type: FK CONSTRAINT; Schema: public; Owner: danesha
--

ALTER TABLE ONLY public.product_categories
    ADD CONSTRAINT fk_pc_category FOREIGN KEY (category_id) REFERENCES public.categories(category_id) ON DELETE CASCADE;


--
-- Name: product_categories fk_pc_product; Type: FK CONSTRAINT; Schema: public; Owner: danesha
--

ALTER TABLE ONLY public.product_categories
    ADD CONSTRAINT fk_pc_product FOREIGN KEY (product_id) REFERENCES public.products(product_id) ON DELETE CASCADE;


--
-- Name: variants fk_variants_product; Type: FK CONSTRAINT; Schema: public; Owner: danesha
--

ALTER TABLE ONLY public.variants
    ADD CONSTRAINT fk_variants_product FOREIGN KEY (product_id) REFERENCES public.products(product_id) ON DELETE CASCADE;


--
-- Name: sales fk_sales_availability; Type: FK CONSTRAINT; Schema: warehouse; Owner: danesha
--

ALTER TABLE ONLY warehouse.sales
    ADD CONSTRAINT fk_sales_availability FOREIGN KEY (availability_id) REFERENCES warehouse.availability(availability_id);


--
-- Name: sales fk_sales_category; Type: FK CONSTRAINT; Schema: warehouse; Owner: danesha
--

ALTER TABLE ONLY warehouse.sales
    ADD CONSTRAINT fk_sales_category FOREIGN KEY (category_id) REFERENCES public.categories(category_id);


--
-- Name: sales fk_sales_product; Type: FK CONSTRAINT; Schema: warehouse; Owner: danesha
--

ALTER TABLE ONLY warehouse.sales
    ADD CONSTRAINT fk_sales_product FOREIGN KEY (product_id) REFERENCES public.products(product_id);


--
-- Name: sales fk_sales_variant; Type: FK CONSTRAINT; Schema: warehouse; Owner: danesha
--

ALTER TABLE ONLY warehouse.sales
    ADD CONSTRAINT fk_sales_variant FOREIGN KEY (variant_id) REFERENCES public.variants(variant_id);


--
-- PostgreSQL database dump complete
--

\unrestrict GK2gX2HCnuhuKn6JD9lkBYPpC7dZIZT3idykllrbtoyxEIbaOxlPgUH4MQJFkYS

