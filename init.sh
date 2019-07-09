#!/bin/sh
cat <<EOF >> /config/genconfig.json
{
    "url": "$BASE_URL",
    "no_auth": false,
    "requestors": {
        "openstad_voting_token": {
            "auth_method": "token",
            "key": "thiscanbeanything",
            "issue_perms": []
        },
        "openstad_voting_hmac": {
            "auth_method": "hmac",
            "key": "dGhpc2NhbmJlYW55dGhpbmc="
        },
        "openstad_voting_pk": {
            "auth_method": "publickey",
            "key_file": "/config/di.vote.public.pem"
        },
        "mijn.ams": {
            "auth_method": "publickey",
            "key_file": "/config/mijn.a.public.pem"
        }
    }
}
EOF
irma server -vv --config /config/genconfig.json
