CREATE TABLE jspBlogDesign
(
    banner text,
    userid text primary key not null
)

CREATE TABLE jspBlogUsers
(
    id text primary key not null,
    name text,
    email text,
    password text,
    framework text,
    newsletter text
)

CREATE TABLE jspBlog
(
    id INT4 default nextval('jspBlog_id_seq'::regclass) not null,
    title text,
    userid text,
    datetime timestamp not null,
    content text
)