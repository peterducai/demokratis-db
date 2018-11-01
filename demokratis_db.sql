CREATE SCHEMA demokratis;

-- SELECT create_hypertable('new_table', 'time');

CREATE TYPE demokratis.vote AS ENUM ('Yes',
    'No',
    'DontCare'
);

CREATE TABLE demokratis.questions (
    id INTEGER PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY, 
    time        TIMESTAMPTZ         NOT NULL,
    title TEXT,
    description TEXT,
    incubator BOOLEAN,
    yes_count INTEGER,
    no_count INTEGER,
    dontcare_count INTEGER,
    starting_date DATE,
    expire_in_days INT
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

CREATE TABLE demokratis.users (
    id INTEGER PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY, 
    time        TIMESTAMPTZ         NOT NULL,
    usertoken TEXT,
    country TEXT,
    city TEXT
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
