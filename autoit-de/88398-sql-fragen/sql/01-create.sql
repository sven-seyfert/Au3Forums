/* Meine Datenbank ist Firebird SQL 1.5
Ich hoffe, die Unterschiede sind nicht zu gravierend.
Hier die Tabellen, aus denen ich aktuell Daten abrufen muss mit den wichtigsten Feldern */
CREATE TABLE kunden (
    kundennr        INT,
    adressgrp       CHAR(6),
    name            CHAR(40),
    strasse         CHAR(40),
    plz             CHAR(9),
    ort             CHAR(30),
    nm_beat         CHAR(20),
    nm_krank_kass   CHAR(2),
    nm_kvnr         CHAR(20),
    nm_gebdat       DATE,
    nm_status       CHAR(5)
);

CREATE TABLE beleg (
    belegtyp    CHAR(1),
    belegart    CHAR(5),
    belegnr     INT,
    belegdat    DATE,
    adressnr    INT,
    name        CHAR(40),
    strasse     CHAR(40),
    plz         CHAR(9),
    ort         CHAR(30),
    netto       FLOAT,
    brutto      FLOAT
);

CREATE TABLE belegpos (
    belegtyp        CHAR(1),
    belegart        CHAR(5),
    belegnr         INT,
    adressnr        INT,
    artikelnr       CHAR(30),
    arttext         TEXT,
    gesamt          FLOAT,
    nm_hilfsnr      CHAR(30),
    nm_hmkz         CHAR(2),
    nm_hmverszeit   CHAR(2),
    nm_verszeit_von DATE,
    nm_verszeit_bis DATE
);

CREATE TABLE serien (
    herstsernr  CHAR(20),
    text1       CHAR(40),
    kundennr    INT,
    artikelnr   CHAR(30),
    lilidat     DATE,
    kennung     CHAR(20)
);

CREATE TABLE artikel (
    artikelnr   CHAR(30),
    wgr         CHAR(6),
    arttext     CHAR(255),
    nm_himinr   CHAR(139)
);
