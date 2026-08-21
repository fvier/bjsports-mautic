-- Script de Inicialização do Banco de Dados PostgreSQL - Laboratório BJ Sports
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pg_trgm";

-- Schema de teste para o laboratório
CREATE SCHEMA IF NOT EXISTS lab_schema;

-- Tabela de demonstração para validação da infraestrutura
CREATE TABLE IF NOT EXISTS lab_schema.health_check (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    service_name VARCHAR(50) NOT NULL,
    status VARCHAR(20) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO lab_schema.health_check (service_name, status)
VALUES ('PostgreSQL Terraform Lab', 'HEALTHY')
ON CONFLICT DO NOTHING;
