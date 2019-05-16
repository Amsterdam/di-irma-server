### Requirements

- Docker
- docker-compose
- Node (for testing)

Dockerfile to run the IRMA go server

[IRMA server library documentation](https://irma.app/docs/irma-server/)

### Run

```
docker-compose up -d
```

### Test

```
cd node_test
npm install
node app.js
```

### Config

According to: [irma/docs/configuration-files](https://irma.app/docs/irma-server/#configuration-files)

### Authentication

Setup with all types (token, hmac, publickey)

According to: [irma/docs/requestor-authentication](https://irma.app/docs/irma-server/#requestor-authentication)