CREATE SCHEMA IF NOT EXISTS company;

CREATE TABLE IF NOT EXISTS company.organization(
    ogrnip bigserial primary key UNIQUE NOT NULL,
    org_name varchar,
    type_activity varchar,
    address text
);

CREATE TABLE IF NOT EXISTS company.clients
(
    passport bigserial primary key UNIQUE NOT NULL,
    phone varchar NOT NULL,
    ogrnip bigserial references company.organization(ogrnip) NOT NULL,
    "name" varchar,
    email varchar
);

CREATE TABLE IF NOT EXISTS company.employees (
    passport bigserial UNIQUE NOT NULL,
    username varchar NOT NULL,
    "role" employee_role NOT NULL,
    phone varchar NOT NULL,
    email varchar,
    PRIMARY KEY (passport, "role")
);

CREATE TABLE IF NOT EXISTS company.task (
    task_id bigserial primary key UNIQUE                               NOT NULL,
    customer_passport bigserial references company.clients(passport)  NOT NULL,
    author_passport bigserial references company.employees(passport)   NOT NULL,
    executor_passport bigserial references company.employees(passport) NOT NULL,
    create_date timestamp without time zone                            NOT NULL,
    deadline_date timestamp without time zone,
    completion_date timestamp without time zone,
    priority priority                                                  NOT NULL,
    descriptions text
);

CREATE TABLE IF NOT EXISTS company.contract (
    contract_id bigserial primary key UNIQUE NOT NULL,
    task_id bigserial references company.task(task_id) NOT NULL,
    details jsonb
);

CREATE TABLE IF NOT EXISTS company.current_client() INHERITS(company.clients);

CREATE TABLE IF NOT EXISTS company.potential_client () INHERITS(company.clients);


