### Requirements

- Node
- IRMA server

### Run

1. Start IRMA server
- By running [this one](https://gitlab.com/stanguldemond/irma_server_container) you get a matching public key

2. `npm install`
3. `node app.js`
- Auth method `publickey` is enabled, the (not so) private key is present and matches the public key in [this IRMA server setup](https://gitlab.com/stanguldemond/irma_server_container)