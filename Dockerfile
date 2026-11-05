# ==========================================================
# TAHAP 1: build  (boleh besar, tidak akan ikut ke image akhir)
# ==========================================================
FROM composer:2.11.1 AS composer_bin

FROM php:8.4.27-cli-alpine3.24 AS build

ENV COMPOSER_ALLOW_SUPERUSER=1

# Alat build: hanya ada di tahap ini
RUN apk add --no-cache git unzip

COPY --from=composer_bin /usr/bin/composer /usr/bin/composer

WORKDIR /app

# Cache: dependensi dulu, kode belakangan (sama seperti Tugas 4)
COPY composer.json composer.lock ./
RUN composer install --no-dev --no-interaction --prefer-dist --no-scripts --no-autoloader

COPY . .

RUN mkdir -p bootstrap/cache storage/framework/cache/data storage/framework/sessions \
             storage/framework/views storage/logs database \
    && composer dump-autoload --no-dev --optimize


# ==========================================================
# TAHAP 2: runtime  (hanya yang dibutuhkan saat melayani)
# ==========================================================
FROM php:8.4.27-cli-alpine3.24 AS runtime

WORKDIR /var/www/html

# Hanya hasil build yang dipindahkan. Composer, git, unzip TIDAK ikut.
COPY --from=build /app ./

EXPOSE 8000

CMD ["sh", "-c", "touch database/database.sqlite && php artisan migrate --force && php artisan db:seed --class=BudgetPresetSeeder --force && php artisan serve --host=0.0.0.0 --port=8000"]