CREATE DATABASE "shortly";
CREATE TABLE "users"(
    "id" SERIAL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "email" TEXT UNIQUE NOT NULL,
    "password" TEXT NOT NULL,
    "createdAt" DATE DEFAULT NOW()
);

CREATE TABLE "sessions"(
    "id" SERIAL PRIMARY KEY,
    "userId" INTEGER NOT NULL REFERENCES "users"("id"),
    "sessionToken" TEXT NOT NULL,
    "sessionKey" TEXT NOT NULL,
    "createdAt" DATE DEFAULT NOW()
);

CREATE TABLE "urls"(
    "id" SERIAL PRIMARY KEY,
    "userId" INTEGER NOT NULL REFERENCES "users"("id"),
    "fullUrl" TEXT NOT NULL,
    "shortUrl" TEXT NOT NULL UNIQUE,
    "visitCount" INTEGER DEFAULT 0,
    "createdAt" DATE DEFAULT NOW()
);
