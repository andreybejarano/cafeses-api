create table "public"."users_has_products" (
    "users_id" bigint not null,
    "products_id" bigint not null
);

alter table "public"."users_has_products" enable row level security;

alter table "public"."users_has_products" add constraint "users_has_products_products_id_fkey" FOREIGN KEY (products_id) REFERENCES products(id) ON DELETE CASCADE not valid;

alter table "public"."users_has_products" validate constraint "users_has_products_products_id_fkey";

alter table "public"."users_has_products" add constraint "users_has_products_users_id_fkey" FOREIGN KEY (users_id) REFERENCES users(id) ON DELETE CASCADE not valid;

alter table "public"."users_has_products" validate constraint "users_has_products_users_id_fkey";