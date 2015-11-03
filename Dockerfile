FROM octohost/php5

ENV APT_PROXY http://192.168.1.10:3128

RUN echo "\n\
	Acquire::HTTP::Proxy \"$APT_PROXY\";\n\
	Acquire::HTTPS::Proxy \"$APT_PROXY\";\n\
	" > /etc/apt/apt.conf.d/01proxy && \
	apt-get update && \
    apt-get -yq install php5-dev php-pear build-essential && \
    pecl install mongo

ADD ./php.ini /etc/php5/fpm/
ADD ./default /etc/nginx/sites-available/default
ADD ./index.php /srv/www/

EXPOSE 80

CMD service php5-fpm start && nginx