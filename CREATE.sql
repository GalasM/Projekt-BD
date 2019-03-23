CREATE TABLE PRACOWNICY
(
    id_pracownika NUMBER NOT NULL constraint id_pracownika_pk primary key,
    imie                VARCHAR2(20),
    nazwisko            VARCHAR2(20),
    data_urodzenia      DATE,
    pensja              NUMBER NOT NULL,
    miasto              VARCHAR2(20),
    ulica               VARCHAR2(20),
    numer_domu          NUMBER NOT NULL,
    numer_telefonu      VARCHAR2(9)
);

CREATE TABLE PRZEWOZENIE
(
    id_przewozu     NUMBER NOT NULL constraint id_przewozu_pk primary key,
    aktualne_miasto VARCHAR2(30),
    ulica           VARCHAR2(30),
    nr_budynku      NUMBER NOT NULL,
    --id_etapu    NUMBER NOT NULL constraint id_przewozu_fk_etap references etap(id_etapu),
    id_pracownika NUMBER NOT NULL constraint id_przewozu_fk_pracownicy references pracownicy(id_pracownika)
);

CREATE TABLE PAKOWANIE
(
    id_pakowania    NUMBER NOT NULL constraint id_pakowania_pk primary key,
    rodzaj_opakowania VARCHAR2(30),
    --id_etapu    NUMBER NOT NULL constraint id_pakowania_fk_etap references etap(id_etapu),
    id_pracownika NUMBER NOT NULL constraint id_pakowania_fk_pracownicy references pracownicy(id_pracownika)
);

CREATE TABLE ETAP
(
    id_etapu            NUMBER NOT NULL constraint id_etapu_pk primary key,
    dlugosc_oczekiwania NUMBER NOT NULL,
    status              VARCHAR(30),
    czy_dostarczona     VARCHAR(3) CONSTRAINT CZY_DOSTARCZONA_CHECK 
    CHECK (CZY_DOSTARCZONA IN ('TAK','NIE')),
    id_przewozu         NUMBER  CONSTRAINT ETAP_PRZEWOZENIE_FK REFERENCES PRZEWOZENIE(ID_PRZEWOZU),
    id_pakowania        NUMBER  CONSTRAINT ETAP_PAKOWANIE_FK REFERENCES PAKOWANIE(ID_PAKOWANIA)
);



CREATE TABLE SAMOCHODY
(
    id_samochodu        NUMBER NOT NULL constraint id_samochodu_pk primary key,
    marka               VARCHAR2(20),
    model_samochodu     VARCHAR2(20),
    rok_produkcji       NUMBER(4),
    NR_REJESTRACYJNY    VARCHAR2(10) CONSTRAINT REJESTRACJA_UNIQUE UNIQUE    
);
 
CREATE TABLE SAMOCHOD_DOSTAWCY
(
    id_samochodu_dostawcy       NUMBER NOT NULL constraint id_samochodu_dostawcy_pk primary key,
    id_samochodu NUMBER NOT NULL constraint samochod_dostawcy_fk_samochody references samochody(id_samochodu),
    id_pracownika NUMBER NOT NULL constraint samochod_dostawcy_fk_pracownik references pracownicy(id_pracownika)   
   
);

CREATE TABLE KLIENCI
(
    id_klienta              NUMBER NOT NULL constraint id_klienta_pk primary key,
    imie                    VARCHAR2(20),
    nazwisko                VARCHAR2(20),
    miasto                  VARCHAR2(20),
    ulica                   VARCHAR2(20),
    numer_domu              NUMBER NOT NULL,
    kod_pocztowy            VARCHAR2(6),    
    numer_telefonu          VARCHAR2(9) 
);

CREATE TABLE PACZKI
(
    id_paczki                   NUMBER NOT NULL constraint id_paczki_pk primary key,
    rodzaj_paczki               VARCHAR(30),
    cena                        NUMBER,
    waga_paczki                 NUMBER NOT NULL,
    dlugosc_paczki              NUMBER NOT NULL,
    szerokosc_paczki            NUMBER NOT NULL,
    wysokosc_paczki             NUMBER NOT NULL,
    id_etapu                    NUMBER constraint paczki_id_etapu_fk references etap(id_etapu),
    id_klienta               NUMBER NOT NULL constraint paczki_id_klienci references klienci(id_klienta)
);

CREATE TABLE LISTY_PRZEWOZOWE
(
    id_listu    NUMBER NOT NULL,
    miejscowosc_nadania VARCHAR2(30),
    ulica_nadania   VARCHAR2(30),
    numer_nadanie   NUMBER NOT NULL,
    miejscowosc_doreczenia VARCHAR2(30),
    ulica_doreczenia   VARCHAR2(30),
    numer_doreczenia   NUMBER NOT NULL ,
    id_paczki   NUMBER NOT NULL constraint list_id_paczki references paczki(id_paczki)
);


CREATE TABLE FAKTURY
(
    id_faktury              NUMBER NOT NULL constraint id_faktury_pk primary key,
    data_wystawienia        DATE,
    id_pracownika           NUMBER NOT NULL constraint faktury_fk_pracownicy REFERENCES PRACOWNICY(id_pracownika),
    id_klienta              NUMBER NOT NULL constraint faktury_fk_klienci references klienci(id_klienta)
);
 
CREATE TABLE POZYCJA_FAKTURY
(
    id_pozycji_faktury      NUMBER NOT NULL constraint id_pozycji_faktury_pk primary key,
    id_paczki               NUMBER NOT NULL constraint pozycja_faktury_fk_paczki references paczki(id_paczki),
    id_faktury              NUMBER NOT NULL constraint pozycja_faktury_fk_faktury references faktury(id_faktury)
   
);
