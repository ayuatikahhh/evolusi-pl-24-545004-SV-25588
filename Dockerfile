# 1) Image dasar: PHP 8.4 versi CLI (sama dengan versi PHP di CI kita)
FROM php:8.4-cli

# Composer dijalankan sebagai root di dalam container, izinkan tanpa peringatan
ENV COMPOSER_ALLOW_SUPERUSER=1

# 2) Paket sistem yang dibutuhkan Composer untuk mengunduh dan membuka paket
RUN apt-get update \
    && apt-get install -y --no-install-recommends git unzip \
    && rm -rf /var/lib/apt/lists/*

# 3) Ambil binary Composer dari image resmi composer (multi-stage COPY)
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# 4) Folder kerja di dalam container
WORKDIR /var/www/html

# 5) CACHE: salin HANYA file dependensi lebih dulu
COPY composer.json composer.lock ./

# 6) Pasang dependensi produksi. Layer ini mahal, jadi hanya diulang
#    kalau composer.json / composer.lock berubah.
RUN composer install --no-dev --no-interaction --prefer-dist --no-scripts --no-autoloader

# 7) Baru sekarang salin seluruh kode aplikasi (sering berubah)
COPY . .

# 8) Siapkan folder yang dibutuhkan Laravel, lalu bangun autoloader + discovery package
RUN mkdir -p bootstrap/cache storage/framework/cache/data storage/framework/sessions \
             storage/framework/views storage/logs database \
    && chmod -R 775 bootstrap/cache storage \
    && composer dump-autoload --no-dev --optimize

# 9) Dokumentasi: aplikasi mendengarkan di port 8000 di dalam container
EXPOSE 8000

# 10) Perintah saat container start: siapkan DB, migrasi, isi data, jalankan server
CMD ["sh", "-c", "touch database/database.sqlite && php artisan migrate --force && php artisan db:seed --class=BudgetPresetSeeder --force && php artisan serve --host=0.0.0.0 --port=8000"]