# Running locally

```
docker-compose pull
docker-compose build
docker-compose run app bundle install
docker-compose run app yarn install
docker-compose run app bin/rails db:migrate
docker-compose up
```
