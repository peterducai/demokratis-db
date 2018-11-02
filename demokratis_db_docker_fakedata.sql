--- CREATE USER docker;
CREATE DATABASE demokratis;
GRANT ALL PRIVILEGES ON DATABASE demokratis TO docker;

CREATE SCHEMA demokratis;

-- SELECT create_hypertable('new_table', 'time');

CREATE TYPE demokratis.vote AS ENUM ('Yes',
    'No',
    'DontCare'
);

CREATE TABLE demokratis.users (
    id INTEGER PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY, 
    time       TIMESTAMPTZ         NOT NULL,
    usertoken TEXT,
    country TEXT,
    city TEXT
    );


CREATE TABLE demokratis.questions (
    id INTEGER PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY, 
    time        TIMESTAMPTZ         NOT NULL,
    title TEXT,
    creator  INTEGER REFERENCES demokratis.users (id),
    description TEXT,
    incubator BOOLEAN DEFAULT TRUE,
    yes_count INTEGER DEFAULT 0,
    no_count INTEGER DEFAULT 0,
    dontcare_count INTEGER DEFAULT 0,
    starting_date DATE,
    expire_in_days INT DEFAULT 1
    );

---
--- TRANSLATION
---
CREATE TABLE demokratis.translations (
    id INTEGER PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY, 
    time        TIMESTAMPTZ         NOT NULL,
    translated_string TEXT,
    question INTEGER REFERENCES demokratis.questions (id)
    );


CREATE TABLE demokratis.votes (
    id INTEGER PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY, 
    time        TIMESTAMPTZ         NOT NULL,
    question INTEGER REFERENCES demokratis.questions (id),
    userid INTEGER REFERENCES demokratis.users (id),
    voted demokratis.vote
    );

CREATE TABLE demokratis.tags (
    id INTEGER PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY, 
    time        TIMESTAMPTZ         NOT NULL,
    question INTEGER REFERENCES demokratis.questions (id),
    tag_text TEXT
    );

--- TODO: trigger for expiration

--- select row_to_json(words) from words;

INSERT INTO demokratis.users (time, usertoken, country, city) VALUES (NOW(),'aesr0fdjd0vsafluroid','Czechia', 'Prague');
INSERT INTO demokratis.questions (time, title, creator, description, starting_date, expire_in_days) VALUES (NOW(),
    'my question 1', (SELECT id FROM demokratis.users WHERE demokratis.users.usertoken = 'aesr0fdjd0vsafluroid'),
    'just a question',
    NOW(),
    1);
INSERT INTO demokratis.votes (time, question, userid, voted) VALUES (NOW(), 
    (SELECT id FROM demokratis.questions WHERE demokratis.questions.title = 'my question 1'),
    (SELECT id FROM demokratis.users WHERE demokratis.users.usertoken = 'aesr0fdjd0vsafluroid'),
    'Yes');
    --- TODO: trigger for counter
