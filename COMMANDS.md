# Keycloak – Wichtige Befehle

## Starten / Stoppen

```bash
# Starten (detached)
docker compose up -d

# Stoppen
docker compose down

# Stoppen + Volumes löschen (Reset)
docker compose down -v

# Neu bauen und starten
docker compose up -d --build
```

## Logs

```bash
# Live-Logs Keycloak
docker compose logs -f keycloak

# Live-Logs Postgres
docker compose logs -f postgres

# Letzte 100 Zeilen
docker compose logs --tail=100 keycloak
```

## Status

```bash
# Container-Status
docker compose ps

# Ressourcenverbrauch
docker stats keycloak keycloak-postgres
```

## Shell / Debugging

```bash
# Shell im Keycloak-Container
docker exec -it keycloak bash

# Shell im Postgres-Container
docker exec -it keycloak-postgres psql -U keycloak -d keycloak
```

## Keycloak Admin CLI (kcadm)

```bash
# Login
docker exec -it keycloak /opt/keycloak/bin/kcadm.sh \
  config credentials \
  --server http://localhost:8080 \
  --realm master \
  --user admin \
  --password admin

# Realms auflisten
docker exec -it keycloak /opt/keycloak/bin/kcadm.sh get realms

# Neuen Realm erstellen
docker exec -it keycloak /opt/keycloak/bin/kcadm.sh create realms \
  -s realm=myrealm \
  -s enabled=true

# User erstellen
docker exec -it keycloak /opt/keycloak/bin/kcadm.sh create users \
  -r myrealm \
  -s username=testuser \
  -s enabled=true

# Passwort setzen
docker exec -it keycloak /opt/keycloak/bin/kcadm.sh set-password \
  -r myrealm \
  --username testuser \
  --new-password test1234
```

## Import / Export

```bash
# Realm exportieren (Datei landet in keycloak/import/)
docker exec -it keycloak /opt/keycloak/bin/kc.sh export \
  --dir /opt/keycloak/data/import \
  --realm myrealm

# Beim Start automatisch importieren: Datei in keycloak/import/ legen,
# dann in docker-compose.yml den command auf start-dev --import-realm ändern
```

## Adressen

| Dienst            | URL                                      |
|-------------------|------------------------------------------|
| Keycloak Admin    | http://localhost:8180/admin              |
| Keycloak Account  | http://localhost:8180/realms/master/account |
| OIDC Discovery    | http://localhost:8180/realms/master/.well-known/openid-configuration |

Admin-Login: `admin` / `admin`
