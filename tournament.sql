-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.

DROP DATABASE IF EXISTS tournament;
CREATE DATABASE tournament;

-- players table sql

CREATE TABLE players(
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL
);

-- matches table sql

CREATE TABLE matches(
    id SERIAL PRIMARY KEY,
    winner INT REFERENCES players(id) ON DELETE CASCADE,
    looser INT REFERENCES players(id) ON DELETE CASCADE,
    CHECK (winner <> looser)
);

-- standing view

CREATE VIEW standing AS 
    SELECT id, 
           name,
           (SELECT COUNT(id) FROM matches m WHERE m.winner = p.id) as wins,
           (SELECT COUNT(id) FROM matches m WHERE m.winner = p.id OR m.looser = p.id) as matches
        FROM players p
        ORDER BY wins desc;