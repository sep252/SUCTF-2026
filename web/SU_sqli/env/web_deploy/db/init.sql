CREATE TABLE posts (
  id SERIAL PRIMARY KEY,
  title TEXT NOT NULL,
  status TEXT NOT NULL DEFAULT 'public',
  meta JSONB NOT NULL DEFAULT '{}'::jsonb
);

CREATE TABLE secrets (
  id SERIAL PRIMARY KEY,
  flag TEXT NOT NULL
);

INSERT INTO posts (title, status, meta) VALUES
  ('Welcome to SU Query', 'public', '{"tag":"intro"}'),
  ('Patch notes 0x01', 'public', '{"tag":"log"}'),
  ('Service status', 'public', '{"tag":"status"}'),
  ('Internal memo', 'hidden', '{"tag":"internal"}');

INSERT INTO secrets (flag) VALUES
  ('SUCTF{P9s9L_!Nject!On_IS_3@$Y_RiGht}');
