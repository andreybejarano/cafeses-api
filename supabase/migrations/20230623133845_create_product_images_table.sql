create table "public"."product_images" (
    "id" bigint generated by default as identity not null,
    "url" text default 'default.jpg'::text,
    "products_id" bigint not null
);

alter table "public"."product_images" enable row level security;

CREATE UNIQUE INDEX product_images_pkey ON public.product_images USING btree (id);

alter table "public"."product_images" add constraint "product_images_pkey" PRIMARY KEY using index "product_images_pkey";

alter table "public"."product_images" add constraint "product_images_products_id_fkey" FOREIGN KEY (products_id) REFERENCES products(id) ON DELETE CASCADE not valid;

alter table "public"."product_images" validate constraint "product_images_products_id_fkey";