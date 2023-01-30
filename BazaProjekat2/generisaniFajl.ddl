-- Generated by Oracle SQL Developer Data Modeler 22.2.0.165.1149
--   at:        2023-01-24 13:14:52 CET
--   site:      Oracle Database 11g
--   type:      Oracle Database 11g



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE arh_kompanija (
    idk               INTEGER NOT NULL,
    imek              VARCHAR2(10 CHAR),
    adrk              VARCHAR2(20 CHAR),
    arh_kompanija_idk INTEGER
);

ALTER TABLE arh_kompanija ADD CONSTRAINT arh_kompanija_pk PRIMARY KEY ( idk );

CREATE TABLE clan (
    mbr  INTEGER NOT NULL,
    imec VARCHAR2(20 CHAR),
    przc VARCHAR2(20),
    godc INTEGER
);

ALTER TABLE clan ADD CONSTRAINT clan_pk PRIMARY KEY ( mbr );

CREATE TABLE drzava (
    iddr  INTEGER NOT NULL,
    ozndr VARCHAR2(6 CHAR)
);

ALTER TABLE drzava ADD CONSTRAINT drzava_pk PRIMARY KEY ( iddr );

CREATE TABLE gradjevine (
    ida  INTEGER NOT NULL,
    idg  INTEGER NOT NULL,
    visg FLOAT(12),
    sirg FLOAT(12),
    duzg FLOAT(12)
);

ALTER TABLE gradjevine ADD CONSTRAINT gradjevine_pk PRIMARY KEY ( ida );

ALTER TABLE gradjevine ADD CONSTRAINT gradjevine_pkv1 UNIQUE ( idg );

CREATE TABLE iskopavanje (
    idi              INTEGER NOT NULL,
    ist_artefakt_ida INTEGER NOT NULL
);

ALTER TABLE iskopavanje ADD CONSTRAINT iskopavanje_pk PRIMARY KEY ( idi,
                                                                    ist_artefakt_ida );

CREATE TABLE ist_artefakt (
    ida    INTEGER NOT NULL,
    naza   VARCHAR2(20 CHAR),
    mestoa VARCHAR2(20 CHAR),
    tipa   VARCHAR2(20 CHAR)
);

ALTER TABLE ist_artefakt
    ADD CHECK ( tipa IN ( 'Gradjevine', 'Predmeti', 'Spisi' ) );

ALTER TABLE ist_artefakt ADD CONSTRAINT ist_artefakt_pk PRIMARY KEY ( ida );

CREATE TABLE materijali (
    idm  INTEGER NOT NULL,
    imem VARCHAR2(20 CHAR)
);

ALTER TABLE materijali ADD CONSTRAINT materijali_pk PRIMARY KEY ( idm );

CREATE TABLE muzej (
    idm         INTEGER NOT NULL,
    nazm        VARCHAR2(15 CHAR),
    adrm        VARCHAR2(25 CHAR),
    drzava_iddr INTEGER NOT NULL
);

ALTER TABLE muzej ADD CONSTRAINT muzej_pk PRIMARY KEY ( idm );

CREATE TABLE odnosi (
    riznica_idr INTEGER NOT NULL,
    riznica_idm INTEGER NOT NULL,
    spisi_ida   INTEGER NOT NULL
);

ALTER TABLE odnosi
    ADD CONSTRAINT odnosi_pk PRIMARY KEY ( riznica_idr,
                                           riznica_idm,
                                           spisi_ida );

CREATE TABLE poseduje (
    muzej_idm    INTEGER NOT NULL,
    predmeti_ida INTEGER NOT NULL
);

ALTER TABLE poseduje ADD CONSTRAINT poseduje_pk PRIMARY KEY ( muzej_idm,
                                                              predmeti_ida );

CREATE TABLE predmeti (
    ida INTEGER NOT NULL,
    idp INTEGER NOT NULL
);

ALTER TABLE predmeti ADD CONSTRAINT predmeti_pk PRIMARY KEY ( ida );

ALTER TABLE predmeti ADD CONSTRAINT predmeti_pkv1 UNIQUE ( idp );

CREATE TABLE riznica (
    idr       INTEGER NOT NULL,
    oznr      VARCHAR2(20 CHAR),
    muzej_idm INTEGER NOT NULL
);

ALTER TABLE riznica ADD CONSTRAINT riznica_pk PRIMARY KEY ( idr,
                                                            muzej_idm );

CREATE TABLE sacinjen (
    predmeti_ida   INTEGER NOT NULL,
    materijali_idm INTEGER NOT NULL
);

ALTER TABLE sacinjen ADD CONSTRAINT sacinjen_pk PRIMARY KEY ( predmeti_ida,
                                                              materijali_idm );

CREATE TABLE sastoji (
    tim_idt  INTEGER NOT NULL,
    clan_mbr INTEGER NOT NULL
);

ALTER TABLE sastoji ADD CONSTRAINT sastoji_pk PRIMARY KEY ( tim_idt,
                                                            clan_mbr );

CREATE TABLE spisi (
    ida   INTEGER NOT NULL,
    ids   INTEGER NOT NULL,
    temas VARCHAR2(20 CHAR)
);

ALTER TABLE spisi ADD CONSTRAINT spisi_pk PRIMARY KEY ( ida );

ALTER TABLE spisi ADD CONSTRAINT spisi_pkv1 UNIQUE ( ids );

CREATE TABLE teren (
    idter   INTEGER NOT NULL,
    imete   VARCHAR2(20 CHAR),
    mestote VARCHAR2(20 CHAR)
);

ALTER TABLE teren ADD CONSTRAINT teren_pk PRIMARY KEY ( idter );

CREATE TABLE tim (
    idt               INTEGER NOT NULL,
    imet              VARCHAR2(10 CHAR),
    arh_kompanija_idk INTEGER NOT NULL
);

ALTER TABLE tim ADD CONSTRAINT tim_pk PRIMARY KEY ( idt );

CREATE TABLE vrsi_se (
    teren_idter                  INTEGER NOT NULL,
    iskopavanje_idi              INTEGER NOT NULL,
    tim_idt                      INTEGER NOT NULL,
    iskopavanje_ist_artefakt_ida INTEGER NOT NULL
);

ALTER TABLE vrsi_se
    ADD CONSTRAINT vrsi_se_pk PRIMARY KEY ( teren_idter,
                                            iskopavanje_idi,
                                            iskopavanje_ist_artefakt_ida );

ALTER TABLE arh_kompanija
    ADD CONSTRAINT arh_kompanija_arh_kompanija_fk FOREIGN KEY ( arh_kompanija_idk )
        REFERENCES arh_kompanija ( idk );

ALTER TABLE gradjevine
    ADD CONSTRAINT gradjevine_ist_artefakt_fk FOREIGN KEY ( ida )
        REFERENCES ist_artefakt ( ida );

ALTER TABLE iskopavanje
    ADD CONSTRAINT iskopavanje_ist_artefakt_fk FOREIGN KEY ( ist_artefakt_ida )
        REFERENCES ist_artefakt ( ida );

ALTER TABLE muzej
    ADD CONSTRAINT muzej_drzava_fk FOREIGN KEY ( drzava_iddr )
        REFERENCES drzava ( iddr );

ALTER TABLE odnosi
    ADD CONSTRAINT odnosi_riznica_fk FOREIGN KEY ( riznica_idr,
                                                   riznica_idm )
        REFERENCES riznica ( idr,
                             muzej_idm );

ALTER TABLE odnosi
    ADD CONSTRAINT odnosi_spisi_fk FOREIGN KEY ( spisi_ida )
        REFERENCES spisi ( ida );

ALTER TABLE poseduje
    ADD CONSTRAINT poseduje_muzej_fk FOREIGN KEY ( muzej_idm )
        REFERENCES muzej ( idm );

ALTER TABLE poseduje
    ADD CONSTRAINT poseduje_predmeti_fk FOREIGN KEY ( predmeti_ida )
        REFERENCES predmeti ( ida );

ALTER TABLE predmeti
    ADD CONSTRAINT predmeti_ist_artefakt_fk FOREIGN KEY ( ida )
        REFERENCES ist_artefakt ( ida );

ALTER TABLE riznica
    ADD CONSTRAINT riznica_muzej_fk FOREIGN KEY ( muzej_idm )
        REFERENCES muzej ( idm );

ALTER TABLE sacinjen
    ADD CONSTRAINT sacinjen_materijali_fk FOREIGN KEY ( materijali_idm )
        REFERENCES materijali ( idm );

ALTER TABLE sacinjen
    ADD CONSTRAINT sacinjen_predmeti_fk FOREIGN KEY ( predmeti_ida )
        REFERENCES predmeti ( ida );

ALTER TABLE sastoji
    ADD CONSTRAINT sastoji_clan_fk FOREIGN KEY ( clan_mbr )
        REFERENCES clan ( mbr );

ALTER TABLE sastoji
    ADD CONSTRAINT sastoji_tim_fk FOREIGN KEY ( tim_idt )
        REFERENCES tim ( idt );

ALTER TABLE spisi
    ADD CONSTRAINT spisi_ist_artefakt_fk FOREIGN KEY ( ida )
        REFERENCES ist_artefakt ( ida );

ALTER TABLE tim
    ADD CONSTRAINT tim_arh_kompanija_fk FOREIGN KEY ( arh_kompanija_idk )
        REFERENCES arh_kompanija ( idk );

ALTER TABLE vrsi_se
    ADD CONSTRAINT vrsi_se_iskopavanje_fk FOREIGN KEY ( iskopavanje_idi,
                                                        iskopavanje_ist_artefakt_ida )
        REFERENCES iskopavanje ( idi,
                                 ist_artefakt_ida );

ALTER TABLE vrsi_se
    ADD CONSTRAINT vrsi_se_teren_fk FOREIGN KEY ( teren_idter )
        REFERENCES teren ( idter );

ALTER TABLE vrsi_se
    ADD CONSTRAINT vrsi_se_tim_fk FOREIGN KEY ( tim_idt )
        REFERENCES tim ( idt );

CREATE OR REPLACE TRIGGER arc_fkarc_1_predmeti BEFORE
    INSERT OR UPDATE OF ida ON predmeti
    FOR EACH ROW
DECLARE
    d VARCHAR2(20 CHAR);
BEGIN
    SELECT
        a.tipa
    INTO d
    FROM
        ist_artefakt a
    WHERE
        a.ida = :new.ida;

    IF ( d IS NULL OR d <> 'Predmeti' ) THEN
        raise_application_error(-20223, 'FK Predmeti_Ist_Artefakt_FK in Table Predmeti violates Arc constraint on Table Ist_Artefakt - discriminator column TipA doesn''t have value ''Predmeti'''
        );
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/

CREATE OR REPLACE TRIGGER arc_fkarc_1_gradjevine BEFORE
    INSERT OR UPDATE OF ida ON gradjevine
    FOR EACH ROW
DECLARE
    d VARCHAR2(20 CHAR);
BEGIN
    SELECT
        a.tipa
    INTO d
    FROM
        ist_artefakt a
    WHERE
        a.ida = :new.ida;

    IF ( d IS NULL OR d <> 'Gradjevine' ) THEN
        raise_application_error(-20223, 'FK Gradjevine_Ist_Artefakt_FK in Table Gradjevine violates Arc constraint on Table Ist_Artefakt - discriminator column TipA doesn''t have value ''Gradjevine'''
        );
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/

CREATE OR REPLACE TRIGGER arc_fkarc_1_spisi BEFORE
    INSERT OR UPDATE OF ida ON spisi
    FOR EACH ROW
DECLARE
    d VARCHAR2(20 CHAR);
BEGIN
    SELECT
        a.tipa
    INTO d
    FROM
        ist_artefakt a
    WHERE
        a.ida = :new.ida;

    IF ( d IS NULL OR d <> 'Spisi' ) THEN
        raise_application_error(-20223, 'FK Spisi_Ist_Artefakt_FK in Table Spisi violates Arc constraint on Table Ist_Artefakt - discriminator column TipA doesn''t have value ''Spisi'''
        );
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/



-- Oracle SQL Developer Data Modeler Summary Report: 
-- 
-- CREATE TABLE                            18
-- CREATE INDEX                             0
-- ALTER TABLE                             41
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           3
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
