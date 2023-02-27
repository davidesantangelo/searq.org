SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: feeds; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.feeds (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    title character varying,
    description text,
    image jsonb,
    url character varying,
    language character varying,
    items_count integer DEFAULT 0,
    metadata jsonb DEFAULT '{}'::jsonb,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: items; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.items (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    feed_id uuid NOT NULL,
    title character varying,
    body text,
    url character varying,
    external_id character varying,
    categories character varying[] DEFAULT '{}'::character varying[],
    published_at timestamp(6) without time zone,
    metadata jsonb DEFAULT '{}'::jsonb,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: tasks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tasks (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    feed_id uuid NOT NULL,
    status character varying DEFAULT 'enqueued'::character varying NOT NULL,
    task_type character varying NOT NULL,
    started_at timestamp(6) without time zone,
    finished_at timestamp(6) without time zone,
    enqueued_at timestamp(6) without time zone,
    metadata jsonb DEFAULT '{}'::jsonb,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: tokens; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tokens (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    key character varying,
    expires_at timestamp(6) without time zone,
    active boolean DEFAULT true,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: feeds feeds_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.feeds
    ADD CONSTRAINT feeds_pkey PRIMARY KEY (id);


--
-- Name: items items_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.items
    ADD CONSTRAINT items_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: tasks tasks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_pkey PRIMARY KEY (id);


--
-- Name: tokens tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tokens
    ADD CONSTRAINT tokens_pkey PRIMARY KEY (id);


--
-- Name: index_feeds_on_language; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_feeds_on_language ON public.feeds USING btree (language);


--
-- Name: index_feeds_on_metadata; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_feeds_on_metadata ON public.feeds USING gin (metadata);


--
-- Name: index_feeds_on_url; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_feeds_on_url ON public.feeds USING btree (url);


--
-- Name: index_items_on_categories; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_items_on_categories ON public.items USING gin (categories);


--
-- Name: index_items_on_external_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_items_on_external_id ON public.items USING btree (external_id);


--
-- Name: index_items_on_feed_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_items_on_feed_id ON public.items USING btree (feed_id);


--
-- Name: index_items_on_feed_id_and_external_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_items_on_feed_id_and_external_id ON public.items USING btree (feed_id, external_id);


--
-- Name: index_items_on_feed_id_and_published_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_items_on_feed_id_and_published_at ON public.items USING btree (feed_id, published_at);


--
-- Name: index_items_on_metadata; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_items_on_metadata ON public.items USING gin (metadata);


--
-- Name: index_items_on_url; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_items_on_url ON public.items USING btree (url);


--
-- Name: index_tasks_on_enqueued_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_tasks_on_enqueued_at ON public.tasks USING btree (enqueued_at);


--
-- Name: index_tasks_on_feed_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_tasks_on_feed_id ON public.tasks USING btree (feed_id);


--
-- Name: index_tasks_on_finished_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_tasks_on_finished_at ON public.tasks USING btree (finished_at);


--
-- Name: index_tasks_on_metadata; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_tasks_on_metadata ON public.tasks USING gin (metadata);


--
-- Name: index_tasks_on_started_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_tasks_on_started_at ON public.tasks USING btree (started_at);


--
-- Name: index_tasks_on_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_tasks_on_status ON public.tasks USING btree (status);


--
-- Name: index_tasks_on_task_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_tasks_on_task_type ON public.tasks USING btree (task_type);


--
-- Name: index_tokens_on_expires_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_tokens_on_expires_at ON public.tokens USING btree (expires_at);


--
-- Name: index_tokens_on_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_tokens_on_key ON public.tokens USING btree (key);


--
-- Name: tasks fk_rails_3b0f83b210; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT fk_rails_3b0f83b210 FOREIGN KEY (feed_id) REFERENCES public.feeds(id);


--
-- Name: items fk_rails_7e424238f4; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.items
    ADD CONSTRAINT fk_rails_7e424238f4 FOREIGN KEY (feed_id) REFERENCES public.feeds(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20230120141959'),
('20230218094151'),
('20230218094346'),
('20230219174535'),
('20230222105024');


