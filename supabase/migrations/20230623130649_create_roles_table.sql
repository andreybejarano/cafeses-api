create table "public"."roles" (
    "id" bigint generated by default as identity not null,
    "name" text not null,
    "slug" text not null
);

CREATE UNIQUE INDEX roles_pkey ON public.roles USING btree (id);

alter table "public"."roles" add constraint "roles_pkey" PRIMARY KEY using index "roles_pkey";
alter table "public"."roles" enable row level security;