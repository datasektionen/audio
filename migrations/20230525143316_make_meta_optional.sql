-- Add migration script here
ALTER TABLE songs ALTER COLUMN meta DROP NOT NULL;
