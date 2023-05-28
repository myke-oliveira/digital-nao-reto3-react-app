# stage 1

FROM node as build
WORKDIR /app
COPY . .
RUN npm ci
RUN npm run build

# stage 2
FROM nginx as production
ENV NODE_ENV production
COPY --from=build /app/build /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD [ "nginx", "-g", "daemon off;" ]
