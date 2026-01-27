-- ========================================
-- MSSV: xxxxx705
-- CREATE DATABASE pcm705database;
\c pcm734database;
\c pcm705database;
-- ========================================

DROP TABLE IF EXISTS "705_Notifications" CASCADE;
DROP TABLE IF EXISTS "705_Matches" CASCADE;
DROP TABLE IF EXISTS "705_TournamentParticipants" CASCADE;
DROP TABLE IF EXISTS "705_Tournaments" CASCADE;
DROP TABLE IF EXISTS "705_Bookings" CASCADE;
DROP TABLE IF EXISTS "705_Courts" CASCADE;
DROP TABLE IF EXISTS "705_WalletTransactions" CASCADE;
DROP TABLE IF EXISTS "705_News" CASCADE;
DROP TABLE IF EXISTS "705_Members" CASCADE;

-- Drop Identity tables
DROP TABLE IF EXISTS "AspNetUserTokens" CASCADE;
DROP TABLE IF EXISTS "AspNetUserRoles" CASCADE;
DROP TABLE IF EXISTS "AspNetUserLogins" CASCADE;
DROP TABLE IF EXISTS "AspNetUserClaims" CASCADE;

-- ========================================
-- Create Identity Tables
-- ========================================

CREATE TABLE "AspNetRoles" (
    "Id" TEXT NOT NULL PRIMARY KEY,
    "Name" VARCHAR(256),
    "NormalizedName" VARCHAR(256),
    "ConcurrencyStamp" TEXT
);

CREATE TABLE "AspNetUsers" (
    "Id" TEXT NOT NULL PRIMARY KEY,
    "UserName" VARCHAR(256),
    "NormalizedUserName" VARCHAR(256),
    "Email" VARCHAR(256),
    "NormalizedEmail" VARCHAR(256),
    "EmailConfirmed" BOOLEAN NOT NULL,
    "PasswordHash" TEXT,
    "SecurityStamp" TEXT,
    "ConcurrencyStamp" TEXT,
    "PhoneNumber" TEXT,
    "PhoneNumberConfirmed" BOOLEAN NOT NULL,
    "TwoFactorEnabled" BOOLEAN NOT NULL,
    "LockoutEnd" TIMESTAMPTZ,
    "LockoutEnabled" BOOLEAN NOT NULL,
    "AccessFailedCount" INTEGER NOT NULL
);

CREATE TABLE "AspNetUserRoles" (
    "UserId" TEXT NOT NULL,
    "RoleId" TEXT NOT NULL,
    PRIMARY KEY ("UserId", "RoleId"),
    FOREIGN KEY ("UserId") REFERENCES "AspNetUsers"("Id") ON DELETE CASCADE,
    FOREIGN KEY ("RoleId") REFERENCES "AspNetRoles"("Id") ON DELETE CASCADE
);

CREATE TABLE "AspNetUserClaims" (
    "Id" SERIAL PRIMARY KEY,
    "UserId" TEXT NOT NULL,
    "ClaimType" TEXT,
    "ClaimValue" TEXT,
    FOREIGN KEY ("UserId") REFERENCES "AspNetUsers"("Id") ON DELETE CASCADE
);

CREATE TABLE "AspNetUserLogins" (
    "LoginProvider" TEXT NOT NULL,
    "ProviderKey" TEXT NOT NULL,
    "ProviderDisplayName" TEXT,
    "UserId" TEXT NOT NULL,
    PRIMARY KEY ("LoginProvider", "ProviderKey"),
    FOREIGN KEY ("UserId") REFERENCES "AspNetUsers"("Id") ON DELETE CASCADE
);

CREATE TABLE "AspNetUserTokens" (
    "UserId" TEXT NOT NULL,
    "LoginProvider" TEXT NOT NULL,
    "Name" TEXT NOT NULL,
    "Value" TEXT,
CREATE TABLE "AspNetRoleClaims" (
    "Id" SERIAL PRIMARY KEY,
    "RoleId" TEXT NOT NULL,
    "ClaimType" TEXT,
    "ClaimValue" TEXT,
    FOREIGN KEY ("RoleId") REFERENCES "AspNetRoles"("Id") ON DELETE CASCADE
);

-- ========================================
-- Create Application Tables
-- ========================================

-- Members Table
CREATE TABLE "705_Members" (
    "Id" SERIAL PRIMARY KEY,
    "FullName" VARCHAR(100) NOT NULL,
    "DateOfBirth" TIMESTAMPTZ NOT NULL,
    "Gender" INTEGER NOT NULL,
    "Phone" VARCHAR(20),
    "WalletBalance" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "Tier" INTEGER NOT NULL DEFAULT 0,
    "RankLevel" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "TotalSpent" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "AvatarUrl" VARCHAR(500),
    "JoinDate" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY ("IdentityUserId") REFERENCES "AspNetUsers"("Id") ON DELETE CASCADE
);

CREATE TABLE "705_WalletTransactions" (
    "Id" SERIAL PRIMARY KEY,
    "MemberId" INTEGER NOT NULL,
    "Amount" DOUBLE PRECISION NOT NULL,
    "Type" INTEGER NOT NULL,
    "Status" INTEGER NOT NULL DEFAULT 0,
    "Description" VARCHAR(500),
    "ProofImageUrl" VARCHAR(500),
    "ProcessedDate" TIMESTAMPTZ,
    "ProcessedBy" TEXT,
    FOREIGN KEY ("MemberId") REFERENCES "705_Members"("Id") ON DELETE CASCADE
);

-- Courts Table  
CREATE TABLE "705_Courts" (
    "Id" SERIAL PRIMARY KEY,
    "Name" VARCHAR(100) NOT NULL,
    "Description" VARCHAR(500),
    "IsIndoor" BOOLEAN NOT NULL DEFAULT FALSE,
    "PricePerHour" DOUBLE PRECISION NOT NULL,
    "IsAvailable" BOOLEAN NOT NULL DEFAULT TRUE
);
-- Bookings Table
CREATE TABLE "705_Bookings" (
    "Id" SERIAL PRIMARY KEY,
    "MemberId" INTEGER NOT NULL,
    "CourtId" INTEGER NOT NULL,
    "StartTime" TIMESTAMPTZ NOT NULL,
    "EndTime" TIMESTAMPTZ NOT NULL,
    "TotalPrice" DOUBLE PRECISION NOT NULL,
    "Status" INTEGER NOT NULL DEFAULT 0,
    "IsRecurring" BOOLEAN NOT NULL DEFAULT FALSE,
    "RecurringUntil" TIMESTAMPTZ,
    "CreatedDate" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY ("MemberId") REFERENCES "705_Members"("Id") ON DELETE CASCADE,
);

-- Tournaments Table
CREATE TABLE "705_Tournaments" (
    "Id" SERIAL PRIMARY KEY,
    "Name" VARCHAR(100) NOT NULL,
    "Description" VARCHAR(500),
    "StartDate" TIMESTAMPTZ NOT NULL,
    "EndDate" TIMESTAMPTZ NOT NULL,
    "Format" INTEGER NOT NULL,
    "EntryFee" DOUBLE PRECISION NOT NULL,
    "PrizePool" DOUBLE PRECISION NOT NULL,
    "Status" INTEGER NOT NULL DEFAULT 0,
    "CurrentParticipants" INTEGER NOT NULL DEFAULT 0
);

-- Tournament Participants Table
CREATE TABLE "705_TournamentParticipants" (
    "Id" SERIAL PRIMARY KEY,
    "TournamentId" INTEGER NOT NULL,
    "MemberId" INTEGER NOT NULL,
    "PartnerId" INTEGER,
    "TeamName" VARCHAR(100),
    "Seed" INTEGER,
    "IsPaid" BOOLEAN NOT NULL DEFAULT FALSE,
    "JoinedDate" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY ("TournamentId") REFERENCES "705_Tournaments"("Id") ON DELETE CASCADE,
    FOREIGN KEY ("MemberId") REFERENCES "705_Members"("Id") ON DELETE CASCADE,
    FOREIGN KEY ("PartnerId") REFERENCES "705_Members"("Id") ON DELETE SET NULL
);

-- Matches Table
CREATE TABLE "705_Matches" (
    "Id" SERIAL PRIMARY KEY,
    "TournamentId" INTEGER,
    "Team1Player1Id" INTEGER NOT NULL,
    "Team1Player2Id" INTEGER,
    "Team2Player1Id" INTEGER NOT NULL,
    "Team2Player2Id" INTEGER,
    "CourtId" INTEGER,
    "Status" INTEGER NOT NULL DEFAULT 0,
    "Team1Set1Score" INTEGER,
    "Team1Set2Score" INTEGER,
    "Team1Set3Score" INTEGER,
    "Team2Set1Score" INTEGER,
    "Team2Set2Score" INTEGER,
    "Team2Set3Score" INTEGER,
    "WinningSide" INTEGER,
    "Round" VARCHAR(50),
    FOREIGN KEY ("TournamentId") REFERENCES "705_Tournaments"("Id") ON DELETE SET NULL,
    FOREIGN KEY ("Team1Player1Id") REFERENCES "705_Members"("Id") ON DELETE RESTRICT,
    FOREIGN KEY ("Team1Player2Id") REFERENCES "705_Members"("Id") ON DELETE SET NULL,
    FOREIGN KEY ("Team2Player1Id") REFERENCES "705_Members"("Id") ON DELETE RESTRICT,
    FOREIGN KEY ("Team2Player2Id") REFERENCES "705_Members"("Id") ON DELETE SET NULL,
    FOREIGN KEY ("CourtId") REFERENCES "705_Courts"("Id") ON DELETE SET NULL
);

-- News Table
CREATE TABLE "705_News" (
    "Id" SERIAL PRIMARY KEY,
    "Title" VARCHAR(200) NOT NULL,
    "IsPinned" BOOLEAN NOT NULL DEFAULT FALSE,
    "CreatedDate" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY ("AuthorId") REFERENCES "AspNetUsers"("Id") ON DELETE RESTRICT
);

-- Notifications Table
CREATE TABLE "705_Notifications" (
    "Id" SERIAL PRIMARY KEY,
    "MemberId" INTEGER NOT NULL,
CREATE INDEX "IX_705_Members_IdentityUserId" ON "705_Members"("IdentityUserId");
CREATE INDEX "IX_705_WalletTransactions_MemberId" ON "705_WalletTransactions"("MemberId");
CREATE INDEX "IX_705_Bookings_MemberId" ON "705_Bookings"("MemberId");
CREATE INDEX "IX_705_Bookings_CourtId" ON "705_Bookings"("CourtId");
CREATE INDEX "IX_705_Bookings_StartTime" ON "705_Bookings"("StartTime");
CREATE INDEX "IX_705_TournamentParticipants_TournamentId" ON "705_TournamentParticipants"("TournamentId");
CREATE INDEX "IX_705_TournamentParticipants_MemberId" ON "705_TournamentParticipants"("MemberId");
CREATE INDEX "IX_705_Matches_TournamentId" ON "705_Matches"("TournamentId");
CREATE INDEX "IX_705_Notifications_MemberId" ON "705_Notifications"("MemberId");
    "Title" VARCHAR(200) NOT NULL,
    "Message" TEXT NOT NULL,
    "Type" INTEGER NOT NULL,
    "RelatedId" INTEGER,
    "IsRead" BOOLEAN NOT NULL DEFAULT FALSE,
    "DeepLink" VARCHAR(200),
    "CreatedDate" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY ("MemberId") REFERENCES "705_Members"("Id") ON DELETE CASCADE
);

-- ========================================
-- Create Indexes
-- ========================================

CREATE INDEX "IX_705_Members_IdentityUserId" ON "705_Members"("IdentityUserId");
CREATE INDEX "IX_705_WalletTransactions_MemberId" ON "705_WalletTransactions"("MemberId");
CREATE INDEX "IX_705_Bookings_MemberId" ON "705_Bookings"("MemberId");
CREATE INDEX "IX_705_Bookings_CourtId" ON "705_Bookings"("CourtId");
CREATE INDEX "IX_705_Bookings_StartTime" ON "705_Bookings"("StartTime");
CREATE INDEX "IX_705_TournamentParticipants_TournamentId" ON "705_TournamentParticipants"("TournamentId");
CREATE INDEX "IX_705_TournamentParticipants_MemberId" ON "705_TournamentParticipants"("MemberId");
CREATE INDEX "IX_705_Matches_TournamentId" ON "705_Matches"("TournamentId");
CREATE INDEX "IX_705_Notifications_MemberId" ON "705_Notifications"("MemberId");
CREATE INDEX "IX_AspNetUserRoles_RoleId" ON "AspNetUserRoles"("RoleId");

-- ========================================
-- Seed Data will be in Part 2
-- ========================================

COMMIT;
