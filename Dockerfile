# FROM node:20
# # this creates /app and move there
#     WORKDIR /app
#     COPY package.json .
#     COPY *.js .
#     RUN npm install
#     ENV MONGO="true" \
#          MONGO_URL="mongodb://mongodb:27017/catalogue"
#     CMD ["node", "server.js"]     

# 1.minimal base os

# FROM node:20.20.2-alpine3.23
# # this creates /app and move there
#     WORKDIR /app
#     COPY package.json .
#     COPY *.js .
#     RUN npm install
#     ENV MONGO="true" \
#          MONGO_URL="mongodb://mongodb:27017/catalogue"
#     CMD ["node", "server.js"]   

# 2.multi-stage files

# FROM node:20.20.2-alpine3.23 AS builder
# # this creates /app and move there
# WORKDIR /app
# COPY package.json .
# COPY *.js .
# RUN npm install


# FROM node:20.20.2-alpine3.23 
# # this creates /app and move there
# WORKDIR /app
# EXPOSE 8080
# COPY --from=builder /app /app
# ENV MONGO="true" \
#           MONGO_URL="mongodb://mongodb:27017/catalogue"
# CMD ["node", "server.js"]   

# 3.don't run as a root

# FROM node:20.20.2-alpine3.23 AS builder
# # this creates /app and move there
# WORKDIR /app
# COPY package.json .
# COPY *.js .
# RUN npm install


# FROM node:20.20.2-alpine3.23 
# # this creates /app and move there
# WORKDIR /app
# EXPOSE 8080
# COPY --from=builder /app /app
# ENV MONGO="true" \
#           MONGO_URL="mongodb://mongodb:27017/catalogue"

# RUN addgroup -S roboshop && adduser -S roboshop -G roboshop
# RUN chown -R roboshop:roboshop /app
# USER roboshop
# CMD ["node", "server.js"] 

# 11. entrypoint + cmd

FROM node:20.19-alpine3.22 AS builder
# this creates /app and move there
WORKDIR /app
COPY package.json .
COPY *.js .
RUN npm install


FROM node:20.19-alpine3.22
# this creates /app and move there
WORKDIR /app
EXPOSE 8080
COPY --from=builder /app /app
ENV MONGO="true" \
          MONGO_URL="mongodb://mongodb:27017/catalogue"

RUN addgroup -S roboshop && adduser -S roboshop -G roboshop
RUN chown -R roboshop:roboshop /app
USER roboshop
CMD ["server.js"]
ENTRYPOINT ["node"] 