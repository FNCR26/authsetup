#!/bin/bash
cd "$(dirname "$0")/.."
docker compose up -d
echo "Keycloak startet... warte kurz."
sleep 5
echo "Admin-UI: http://localhost:8080/admin  |  User: admin  |  Pass: admin"
