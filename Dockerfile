# Se tagea esta fase como builder
FROM node:alpine as builder

WORKDIR  '/app'

COPY package.json ./

RUN npm install

COPY ./ ./

CMD ["npm","run","build"]

############################

FROM nginx

# Este contenedor va a necesitar exponer este puerto. Es un comando diseñado para desarrolladores, y que sean conscientes de que es necesario exponerlo.
# Este comando no hace nada de forma automática
# Elastic beanstalk si que va a leer este atributo y si que va a exponer hacia afuera este puerto, que es el del nginx que está sirviendo nuestra app de producción
EXPOSE 80

# Indicamos que vamos a copiar algo de otra fase, la anterior y el nombre de la fase
COPY --from=builder /app/build /usr/share/nginx/html

# No hace falta poner el CMD para arrancar nginx porque la imagen de nginx ya lo hace por defecto.