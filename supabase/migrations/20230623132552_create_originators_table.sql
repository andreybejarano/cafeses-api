create table "public"."originators" (
    "id" bigint generated by default as identity not null,
    "name" text not null,
    "regions_id" bigint
);

alter table "public"."originators" enable row level security;

CREATE UNIQUE INDEX originators_pkey ON public.originators USING btree (id);

alter table "public"."originators" add constraint "originators_pkey" PRIMARY KEY using index "originators_pkey";

alter table "public"."originators" add constraint "originators_regions_id_fkey" FOREIGN KEY (regions_id) REFERENCES regions(id) not valid;

alter table "public"."originators" validate constraint "originators_regions_id_fkey";