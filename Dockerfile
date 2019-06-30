# Se tagea esta fase como builder
FROM node:alpine as builder

WORKDIR  '/app'

COPY package.json ./

RUN npm install

COPY ./ ./

CMD ["npm","run","build"]

############################

FROM nginx 
# Indicamos que vamos a copiar algo de otra fase, la anterior y el nombre de la fase
COPY --from=builder /app/build /usr/share/nginx/html

# No hace falta poner el CMD para arrancar nginx porque la imagen de nginx ya lo hace por defecto.