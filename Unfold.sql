PGDMP     (    -                z            Unfold    14.0    14.0 B    ;           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            <           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            =           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            >           1262    16573    Unfold    DATABASE     l   CREATE DATABASE "Unfold" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'English_United States.1252';
    DROP DATABASE "Unfold";
                postgres    false            �            1259    16662    articles    TABLE     )  CREATE TABLE public.articles (
    article_id integer NOT NULL,
    description character varying(256),
    image character varying,
    purchase_price double precision,
    times_worn integer NOT NULL,
    sell_price double precision,
    id integer NOT NULL,
    category_id integer NOT NULL
);
    DROP TABLE public.articles;
       public         heap    postgres    false            �            1259    16661    articles_article_id_seq    SEQUENCE     �   CREATE SEQUENCE public.articles_article_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.articles_article_id_seq;
       public          postgres    false    215            ?           0    0    articles_article_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.articles_article_id_seq OWNED BY public.articles.article_id;
          public          postgres    false    214            �            1259    24933    articles_outfits    TABLE     �   CREATE TABLE public.articles_outfits (
    article_outfit_id integer NOT NULL,
    article_id integer NOT NULL,
    outfit_id integer NOT NULL
);
 $   DROP TABLE public.articles_outfits;
       public         heap    postgres    false            �            1259    24932 &   articles_outfits_article_outfit_id_seq    SEQUENCE     �   CREATE SEQUENCE public.articles_outfits_article_outfit_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 =   DROP SEQUENCE public.articles_outfits_article_outfit_id_seq;
       public          postgres    false    221            @           0    0 &   articles_outfits_article_outfit_id_seq    SEQUENCE OWNED BY     q   ALTER SEQUENCE public.articles_outfits_article_outfit_id_seq OWNED BY public.articles_outfits.article_outfit_id;
          public          postgres    false    220            �            1259    16592    base_categories    TABLE     �   CREATE TABLE public.base_categories (
    base_category_id character varying NOT NULL,
    name character varying(64) NOT NULL,
    description character varying(256) NOT NULL
);
 #   DROP TABLE public.base_categories;
       public         heap    postgres    false            �            1259    16626 
   categories    TABLE     �   CREATE TABLE public.categories (
    category_id integer NOT NULL,
    name character varying(64) NOT NULL,
    description character varying(256),
    id integer NOT NULL,
    base_category_id character varying(10) NOT NULL
);
    DROP TABLE public.categories;
       public         heap    postgres    false            �            1259    16625    categories_category_id_seq    SEQUENCE     �   CREATE SEQUENCE public.categories_category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public.categories_category_id_seq;
       public          postgres    false    213            A           0    0    categories_category_id_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public.categories_category_id_seq OWNED BY public.categories.category_id;
          public          postgres    false    212            �            1259    24921    outfits    TABLE     �   CREATE TABLE public.outfits (
    outfit_id integer NOT NULL,
    name character varying(64),
    description character varying(256),
    times_worn integer NOT NULL,
    id integer NOT NULL
);
    DROP TABLE public.outfits;
       public         heap    postgres    false            �            1259    24920    outfits_outfit_id_seq    SEQUENCE     �   CREATE SEQUENCE public.outfits_outfit_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.outfits_outfit_id_seq;
       public          postgres    false    219            B           0    0    outfits_outfit_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.outfits_outfit_id_seq OWNED BY public.outfits.outfit_id;
          public          postgres    false    218            �            1259    16702    tags    TABLE     |   CREATE TABLE public.tags (
    tag_id integer NOT NULL,
    name character varying(32) NOT NULL,
    id integer NOT NULL
);
    DROP TABLE public.tags;
       public         heap    postgres    false            �            1259    16701    tags_tag_id_seq    SEQUENCE     �   CREATE SEQUENCE public.tags_tag_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.tags_tag_id_seq;
       public          postgres    false    217            C           0    0    tags_tag_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.tags_tag_id_seq OWNED BY public.tags.tag_id;
          public          postgres    false    216            �            1259    16575    users    TABLE     �   CREATE TABLE public.users (
    id integer NOT NULL,
    fullname character varying(100) NOT NULL,
    username character varying(50) NOT NULL,
    password character varying(255) NOT NULL,
    email character varying(50) NOT NULL
);
    DROP TABLE public.users;
       public         heap    postgres    false            �            1259    16574    users_id_seq    SEQUENCE     �   CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.users_id_seq;
       public          postgres    false    210            D           0    0    users_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;
          public          postgres    false    209            �            1259    24950    wear_events    TABLE     D  CREATE TABLE public.wear_events (
    wear_event_id integer NOT NULL,
    name character varying(128) NOT NULL,
    description character varying(256),
    date timestamp without time zone NOT NULL,
    temperature double precision,
    weather_cond character varying(128),
    id integer NOT NULL,
    outfit_id integer
);
    DROP TABLE public.wear_events;
       public         heap    postgres    false            �            1259    24949    wear_events_wear_event_id_seq    SEQUENCE     �   CREATE SEQUENCE public.wear_events_wear_event_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE public.wear_events_wear_event_id_seq;
       public          postgres    false    223            E           0    0    wear_events_wear_event_id_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE public.wear_events_wear_event_id_seq OWNED BY public.wear_events.wear_event_id;
          public          postgres    false    222            �           2604    16665    articles article_id    DEFAULT     z   ALTER TABLE ONLY public.articles ALTER COLUMN article_id SET DEFAULT nextval('public.articles_article_id_seq'::regclass);
 B   ALTER TABLE public.articles ALTER COLUMN article_id DROP DEFAULT;
       public          postgres    false    215    214    215            �           2604    24936 "   articles_outfits article_outfit_id    DEFAULT     �   ALTER TABLE ONLY public.articles_outfits ALTER COLUMN article_outfit_id SET DEFAULT nextval('public.articles_outfits_article_outfit_id_seq'::regclass);
 Q   ALTER TABLE public.articles_outfits ALTER COLUMN article_outfit_id DROP DEFAULT;
       public          postgres    false    220    221    221                       2604    16629    categories category_id    DEFAULT     �   ALTER TABLE ONLY public.categories ALTER COLUMN category_id SET DEFAULT nextval('public.categories_category_id_seq'::regclass);
 E   ALTER TABLE public.categories ALTER COLUMN category_id DROP DEFAULT;
       public          postgres    false    213    212    213            �           2604    24924    outfits outfit_id    DEFAULT     v   ALTER TABLE ONLY public.outfits ALTER COLUMN outfit_id SET DEFAULT nextval('public.outfits_outfit_id_seq'::regclass);
 @   ALTER TABLE public.outfits ALTER COLUMN outfit_id DROP DEFAULT;
       public          postgres    false    219    218    219            �           2604    16705    tags tag_id    DEFAULT     j   ALTER TABLE ONLY public.tags ALTER COLUMN tag_id SET DEFAULT nextval('public.tags_tag_id_seq'::regclass);
 :   ALTER TABLE public.tags ALTER COLUMN tag_id DROP DEFAULT;
       public          postgres    false    216    217    217            ~           2604    16578    users id    DEFAULT     d   ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);
 7   ALTER TABLE public.users ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    209    210    210            �           2604    24953    wear_events wear_event_id    DEFAULT     �   ALTER TABLE ONLY public.wear_events ALTER COLUMN wear_event_id SET DEFAULT nextval('public.wear_events_wear_event_id_seq'::regclass);
 H   ALTER TABLE public.wear_events ALTER COLUMN wear_event_id DROP DEFAULT;
       public          postgres    false    223    222    223            0          0    16662    articles 
   TABLE DATA           {   COPY public.articles (article_id, description, image, purchase_price, times_worn, sell_price, id, category_id) FROM stdin;
    public          postgres    false    215   �O       6          0    24933    articles_outfits 
   TABLE DATA           T   COPY public.articles_outfits (article_outfit_id, article_id, outfit_id) FROM stdin;
    public          postgres    false    221   NT       ,          0    16592    base_categories 
   TABLE DATA           N   COPY public.base_categories (base_category_id, name, description) FROM stdin;
    public          postgres    false    211   kT       .          0    16626 
   categories 
   TABLE DATA           Z   COPY public.categories (category_id, name, description, id, base_category_id) FROM stdin;
    public          postgres    false    213   9U       4          0    24921    outfits 
   TABLE DATA           O   COPY public.outfits (outfit_id, name, description, times_worn, id) FROM stdin;
    public          postgres    false    219   �V       2          0    16702    tags 
   TABLE DATA           0   COPY public.tags (tag_id, name, id) FROM stdin;
    public          postgres    false    217   �V       +          0    16575    users 
   TABLE DATA           H   COPY public.users (id, fullname, username, password, email) FROM stdin;
    public          postgres    false    210   �W       8          0    24950    wear_events 
   TABLE DATA           w   COPY public.wear_events (wear_event_id, name, description, date, temperature, weather_cond, id, outfit_id) FROM stdin;
    public          postgres    false    223   >X       F           0    0    articles_article_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.articles_article_id_seq', 133, true);
          public          postgres    false    214            G           0    0 &   articles_outfits_article_outfit_id_seq    SEQUENCE SET     U   SELECT pg_catalog.setval('public.articles_outfits_article_outfit_id_seq', 1, false);
          public          postgres    false    220            H           0    0    categories_category_id_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public.categories_category_id_seq', 43, true);
          public          postgres    false    212            I           0    0    outfits_outfit_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.outfits_outfit_id_seq', 8, true);
          public          postgres    false    218            J           0    0    tags_tag_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.tags_tag_id_seq', 49, true);
          public          postgres    false    216            K           0    0    users_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.users_id_seq', 1, true);
          public          postgres    false    209            L           0    0    wear_events_wear_event_id_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public.wear_events_wear_event_id_seq', 4, true);
          public          postgres    false    222            �           2606    24938 &   articles_outfits articles_outfits_pkey 
   CONSTRAINT     s   ALTER TABLE ONLY public.articles_outfits
    ADD CONSTRAINT articles_outfits_pkey PRIMARY KEY (article_outfit_id);
 P   ALTER TABLE ONLY public.articles_outfits DROP CONSTRAINT articles_outfits_pkey;
       public            postgres    false    221            �           2606    16669    articles articles_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.articles
    ADD CONSTRAINT articles_pkey PRIMARY KEY (article_id);
 @   ALTER TABLE ONLY public.articles DROP CONSTRAINT articles_pkey;
       public            postgres    false    215            �           2606    16598 $   base_categories base_categories_pkey 
   CONSTRAINT     p   ALTER TABLE ONLY public.base_categories
    ADD CONSTRAINT base_categories_pkey PRIMARY KEY (base_category_id);
 N   ALTER TABLE ONLY public.base_categories DROP CONSTRAINT base_categories_pkey;
       public            postgres    false    211            �           2606    16631    categories categories_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (category_id);
 D   ALTER TABLE ONLY public.categories DROP CONSTRAINT categories_pkey;
       public            postgres    false    213            �           2606    24926    outfits outfits_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY public.outfits
    ADD CONSTRAINT outfits_pkey PRIMARY KEY (outfit_id);
 >   ALTER TABLE ONLY public.outfits DROP CONSTRAINT outfits_pkey;
       public            postgres    false    219            �           2606    16707    tags tags_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (tag_id);
 8   ALTER TABLE ONLY public.tags DROP CONSTRAINT tags_pkey;
       public            postgres    false    217            �           2606    16580    users users_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            postgres    false    210            �           2606    24957    wear_events wear_events_pkey 
   CONSTRAINT     e   ALTER TABLE ONLY public.wear_events
    ADD CONSTRAINT wear_events_pkey PRIMARY KEY (wear_event_id);
 F   ALTER TABLE ONLY public.wear_events DROP CONSTRAINT wear_events_pkey;
       public            postgres    false    223            �           2606    16670 "   articles articles_category_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.articles
    ADD CONSTRAINT articles_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.categories(category_id);
 L   ALTER TABLE ONLY public.articles DROP CONSTRAINT articles_category_id_fkey;
       public          postgres    false    213    3210    215            �           2606    16675    articles articles_id_fkey    FK CONSTRAINT     s   ALTER TABLE ONLY public.articles
    ADD CONSTRAINT articles_id_fkey FOREIGN KEY (id) REFERENCES public.users(id);
 C   ALTER TABLE ONLY public.articles DROP CONSTRAINT articles_id_fkey;
       public          postgres    false    210    3206    215            �           2606    24939 1   articles_outfits articles_outfits_article_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.articles_outfits
    ADD CONSTRAINT articles_outfits_article_id_fkey FOREIGN KEY (article_id) REFERENCES public.articles(article_id);
 [   ALTER TABLE ONLY public.articles_outfits DROP CONSTRAINT articles_outfits_article_id_fkey;
       public          postgres    false    3212    221    215            �           2606    24944 0   articles_outfits articles_outfits_outfit_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.articles_outfits
    ADD CONSTRAINT articles_outfits_outfit_id_fkey FOREIGN KEY (outfit_id) REFERENCES public.outfits(outfit_id);
 Z   ALTER TABLE ONLY public.articles_outfits DROP CONSTRAINT articles_outfits_outfit_id_fkey;
       public          postgres    false    3216    219    221            �           2606    16632 +   categories categories_base_category_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_base_category_id_fkey FOREIGN KEY (base_category_id) REFERENCES public.base_categories(base_category_id);
 U   ALTER TABLE ONLY public.categories DROP CONSTRAINT categories_base_category_id_fkey;
       public          postgres    false    3208    213    211            �           2606    16637 "   categories categories_user_id_fkey    FK CONSTRAINT     |   ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_user_id_fkey FOREIGN KEY (id) REFERENCES public.users(id);
 L   ALTER TABLE ONLY public.categories DROP CONSTRAINT categories_user_id_fkey;
       public          postgres    false    210    213    3206            �           2606    24927    outfits outfits_id_fkey    FK CONSTRAINT     q   ALTER TABLE ONLY public.outfits
    ADD CONSTRAINT outfits_id_fkey FOREIGN KEY (id) REFERENCES public.users(id);
 A   ALTER TABLE ONLY public.outfits DROP CONSTRAINT outfits_id_fkey;
       public          postgres    false    3206    219    210            �           2606    16708    tags tags_id_fkey    FK CONSTRAINT     k   ALTER TABLE ONLY public.tags
    ADD CONSTRAINT tags_id_fkey FOREIGN KEY (id) REFERENCES public.users(id);
 ;   ALTER TABLE ONLY public.tags DROP CONSTRAINT tags_id_fkey;
       public          postgres    false    3206    210    217            �           2606    24958 &   wear_events wear_events_outfit_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.wear_events
    ADD CONSTRAINT wear_events_outfit_id_fkey FOREIGN KEY (outfit_id) REFERENCES public.outfits(outfit_id);
 P   ALTER TABLE ONLY public.wear_events DROP CONSTRAINT wear_events_outfit_id_fkey;
       public          postgres    false    219    223    3216            �           2606    24963 $   wear_events wear_events_user_id_fkey    FK CONSTRAINT     ~   ALTER TABLE ONLY public.wear_events
    ADD CONSTRAINT wear_events_user_id_fkey FOREIGN KEY (id) REFERENCES public.users(id);
 N   ALTER TABLE ONLY public.wear_events DROP CONSTRAINT wear_events_user_id_fkey;
       public          postgres    false    210    223    3206            0   J  x�uVM��6=S�B�޴�KǴ@�@�I�4@� ��ؒ-�
)�u}��R��ɜ1�|3�FEN$4���a�+�j.�c����>R3\�a��eqLb�����A�#����p�0�mX>�4��/�:+KhѤu�6MS䜥-Nӑ/�$qPd�6�����i�||���z�k��b���)��Kw�V��F��O�j�p��jn�z �1��c$�������\���>?g�Un"����<�ڀ���^�t{�أh��5����јdA����4T= ύ;��m7#)b��
}Ue�:�Q>IP�kB:�Ƀ�{�({�${��A�9H3�z�_s����Z����6d��v>*4k��=R��k��b8�B[f+H[=X��5����V�Y�+�Xf��ۏܗD�9R�s'�u�^�?��&�(1����+��
h��CkOe<��`x%Gɧ���`�D�U�RD0����Z��X�Jv�*�qbw���<���'��XR\ǰn�>cb-Q�鳖g>k4�l��#��a&5��!�x��h�D{��Hv�\�7�e��/4��Kp� �r���:֎���R ���.��]q��+S���shÝG����8c����V���aƣL'��gL�����;�hZ����r���bP��ҍ����a5��U�
A)֌�'�zY��+�@ť�D�N-�Q�*�����:~��H��m�pki�Bӯ�M�R�Z�I���ف�m���fa���~��UBp���f�Rq9�˭�/7#�e�T�E�wcy���cU�d[��h�=���ָ����t%Ғ`�F�MN�]:���~��,���O��y��[�n���7����Yf1����������7V5�d�R`N8��I��U�S]�I�n+i���Q��� ѧ��vя|��|�v��aQ3���Z^��.^J���!�u���L��[��en�c�X�1�m� e9�d7������Ռ���v����m�Ǫmq.8q�z]�:�
�dKW�Y�k�.|V��#�j=WY�!4�F��>�no�'��Э�'���b��n�t��>����6��c>{����/;?VB��z����]       6      x������ � �      ,   �   x�m��r!Dk�
���3�2ER��Aw���-���7q����H���^�}y�"�3�lZ�j%h5�����ğЋ��O�;'q��e�gז��׮K��a��#��4>�HZ(��[�s�\�%�q?V1󶫘�8t~Tw��A���ac0��9|�������H!�����ք�J���^���{�����      .   @  x��Q�N�0<o�b Ip-=��R�\�t�8v�u��l�PJ$�<vfvg&/`c}����]�l��t�C fCY��!�g�6��w�B����azf�v�Ö�i�\b�}����
�&��U>�CDn����~�!r����TC��Iq�,��-ES�Oz�g"�pT��@mj=Cw�SUC�)�]�Г
�H���R���{�"(U��Z����rE�u3ecă��X�&j��}\�/PI�ŝ�����޵'�x���Z��C�X�3U�%�b��é���~9��`㈮�+��?����E��W�n�,�iQ��      4   =   x�3�,�/�
e�I����\f���%�E)��
IE�y��ɉť�9
婉E`1z\\\ =0�      2   �   x�-�Kn�0D��S�A����=E7�D�B%ˠ��}D��7�p�;��D
�a�B��U�X�7�/���I��y�fSqHZ9g��V0N0����R�#Ii�+��,[�\�p��\��|<�D�Y+�n:�s�F��e�{Q����(�mS����i	Z>]�$�JW��Ja�S}����	>�Č�S��ߧ��^�N�      +   �   x�-��
�0 ��w�\��&=�����Mw������
�aN��H��o8�������A�<h�|�A-�)���з�!k�ʙ��)��&�
T LV���R���L�E�y������h�����(iZ��q�_A�+      8   L   x�3�t**�K��L���KW�/-QH�/RH*�g�d(�e��s� ������q����!�W� �Z     