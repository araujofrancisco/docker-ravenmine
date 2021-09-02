FROM node:16-alpine AS base

ARG WALLET_ADDRESS
ENV WALLET_ADDRESS=${WALLET_ADDRESS}

FROM alpine/git AS intermediate
WORKDIR /src
RUN git clone https://github.com/qbm5/RavenmineData.git .

FROM base AS final
COPY --from=intermediate /src/* .
RUN npm install

CMD [ "sh", "-c", "node main.js --u ${WALLET_ADDRESS}" ]
