create table "public"."regions" (
    "id" bigint generated by default as identity not null,
    "name" text not null,
    "countries_id" bigint not null
);

alter table "public"."regions" enable row level security;

CREATE UNIQUE INDEX regions_pkey ON public.regions USING btree (id);

alter table "public"."regions" add constraint "regions_pkey" PRIMARY KEY using index "regions_pkey";

alter table "public"."regions" add constraint "regions_countries_id_fkey" FOREIGN KEY (countries_id) REFERENCES countries(id) ON DELETE CASCADE not valid;

alter table "public"."regions" validate constraint "regions_countries_id_fkey";