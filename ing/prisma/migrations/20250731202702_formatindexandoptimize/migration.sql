/*
  Warnings:

  - You are about to drop the `CandidateProfile` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Education` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Experience` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Skill` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "Application" DROP CONSTRAINT "Application_candidateId_fkey";

-- DropForeignKey
ALTER TABLE "CandidateProfile" DROP CONSTRAINT "CandidateProfile_userId_fkey";

-- DropForeignKey
ALTER TABLE "Education" DROP CONSTRAINT "Education_profileId_fkey";

-- DropForeignKey
ALTER TABLE "Experience" DROP CONSTRAINT "Experience_profileId_fkey";

-- DropForeignKey
ALTER TABLE "Skill" DROP CONSTRAINT "Skill_profileId_fkey";

-- DropTable
DROP TABLE "CandidateProfile";

-- DropTable
DROP TABLE "Education";

-- DropTable
DROP TABLE "Experience";

-- DropTable
DROP TABLE "Skill";

-- CreateTable
CREATE TABLE "candidate_profiles" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "fullName" VARCHAR(255) NOT NULL,
    "phone" VARCHAR(20),
    "position" VARCHAR(255),
    "location" VARCHAR(255),
    "linkedin" VARCHAR(500),
    "profilePhoto" TEXT,
    "resumeLink" TEXT,
    "summary" TEXT,
    "makePublic" BOOLEAN NOT NULL DEFAULT false,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "profileCompleteness" INTEGER NOT NULL DEFAULT 0,
    "last_updated" TIMESTAMP(3) NOT NULL,
    "jobType" "JobType",
    "preferredLocation" "LocationPref",
    "experienceRange" "ExperienceRange",
    "minimumPay" VARCHAR(50),
    "gender" "Gender",
    "currentLocation" VARCHAR(255),
    "hometown" VARCHAR(255),
    "preferredLocations" TEXT[] DEFAULT ARRAY[]::TEXT[],
    "preferredJobTitles" TEXT[] DEFAULT ARRAY[]::TEXT[],
    "noticePeriod" "NoticePeriod",
    "immediatelyAvailable" BOOLEAN NOT NULL DEFAULT false,
    "lookingfor" "lookingfor",
    "languages" TEXT[] DEFAULT ARRAY[]::TEXT[],

    CONSTRAINT "candidate_profiles_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "educations" (
    "id" TEXT NOT NULL,
    "profile_id" TEXT NOT NULL,
    "degree" VARCHAR(255) NOT NULL,
    "institution" VARCHAR(255) NOT NULL,
    "location" VARCHAR(255),
    "startDate" VARCHAR(20) NOT NULL,
    "endDate" VARCHAR(20),
    "current" BOOLEAN NOT NULL DEFAULT false,
    "grade" VARCHAR(50),
    "description" TEXT,
    "educationLevel" "EducationLevel",

    CONSTRAINT "educations_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "experiences" (
    "id" TEXT NOT NULL,
    "profile_id" TEXT NOT NULL,
    "title" VARCHAR(255) NOT NULL,
    "company" VARCHAR(255) NOT NULL,
    "location" VARCHAR(255),
    "startDate" VARCHAR(20) NOT NULL,
    "endDate" VARCHAR(20),
    "current" BOOLEAN NOT NULL DEFAULT false,
    "description" TEXT,
    "experienceType" "ExperienceType",

    CONSTRAINT "experiences_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "skills" (
    "id" TEXT NOT NULL,
    "profileId" TEXT NOT NULL,
    "name" VARCHAR(100) NOT NULL,
    "level" "SkillLevel" NOT NULL DEFAULT 'INTERMEDIATE',

    CONSTRAINT "skills_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "candidate_profiles_userId_key" ON "candidate_profiles"("userId");

-- CreateIndex
CREATE INDEX "candidate_profiles_jobType_preferredLocation_experienceRang_idx" ON "candidate_profiles"("jobType", "preferredLocation", "experienceRange");

-- CreateIndex
CREATE INDEX "candidate_profiles_lookingfor_immediatelyAvailable_idx" ON "candidate_profiles"("lookingfor", "immediatelyAvailable");

-- CreateIndex
CREATE INDEX "candidate_profiles_minimumPay_experienceRange_idx" ON "candidate_profiles"("minimumPay", "experienceRange");

-- CreateIndex
CREATE INDEX "candidate_profiles_gender_location_idx" ON "candidate_profiles"("gender", "location");

-- CreateIndex
CREATE INDEX "candidate_profiles_fullName_idx" ON "candidate_profiles"("fullName");

-- CreateIndex
CREATE INDEX "candidate_profiles_position_idx" ON "candidate_profiles"("position");

-- CreateIndex
CREATE INDEX "educations_profile_id_idx" ON "educations"("profile_id");

-- CreateIndex
CREATE INDEX "educations_profile_id_current_idx" ON "educations"("profile_id", "current");

-- CreateIndex
CREATE INDEX "educations_educationLevel_idx" ON "educations"("educationLevel");

-- CreateIndex
CREATE INDEX "educations_institution_idx" ON "educations"("institution");

-- CreateIndex
CREATE INDEX "experiences_profile_id_idx" ON "experiences"("profile_id");

-- CreateIndex
CREATE INDEX "experiences_profile_id_current_idx" ON "experiences"("profile_id", "current");

-- CreateIndex
CREATE INDEX "experiences_company_idx" ON "experiences"("company");

-- CreateIndex
CREATE INDEX "experiences_title_idx" ON "experiences"("title");

-- CreateIndex
CREATE INDEX "experiences_experienceType_idx" ON "experiences"("experienceType");

-- CreateIndex
CREATE INDEX "skills_profileId_idx" ON "skills"("profileId");

-- CreateIndex
CREATE INDEX "skills_name_idx" ON "skills"("name");

-- CreateIndex
CREATE INDEX "skills_name_level_idx" ON "skills"("name", "level");

-- CreateIndex
CREATE INDEX "skills_level_idx" ON "skills"("level");

-- CreateIndex
CREATE UNIQUE INDEX "skills_profileId_name_key" ON "skills"("profileId", "name");

-- CreateIndex
CREATE INDEX "accounts_user_id_idx" ON "accounts"("user_id");

-- CreateIndex
CREATE INDEX "accounts_provider_idx" ON "accounts"("provider");

-- CreateIndex
CREATE INDEX "sessions_user_id_idx" ON "sessions"("user_id");

-- CreateIndex
CREATE INDEX "sessions_expires_idx" ON "sessions"("expires");

-- CreateIndex
CREATE INDEX "sessions_user_id_expires_idx" ON "sessions"("user_id", "expires");

-- CreateIndex
CREATE INDEX "users_email_idx" ON "users"("email");

-- CreateIndex
CREATE INDEX "users_role_idx" ON "users"("role");

-- CreateIndex
CREATE INDEX "users_created_at_idx" ON "users"("created_at");

-- CreateIndex
CREATE INDEX "verificationtokens_expires_idx" ON "verificationtokens"("expires");

-- CreateIndex
CREATE INDEX "verificationtokens_identifier_idx" ON "verificationtokens"("identifier");

-- AddForeignKey
ALTER TABLE "candidate_profiles" ADD CONSTRAINT "candidate_profiles_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "educations" ADD CONSTRAINT "educations_profile_id_fkey" FOREIGN KEY ("profile_id") REFERENCES "candidate_profiles"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "experiences" ADD CONSTRAINT "experiences_profile_id_fkey" FOREIGN KEY ("profile_id") REFERENCES "candidate_profiles"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "skills" ADD CONSTRAINT "skills_profileId_fkey" FOREIGN KEY ("profileId") REFERENCES "candidate_profiles"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Application" ADD CONSTRAINT "Application_candidateId_fkey" FOREIGN KEY ("candidateId") REFERENCES "candidate_profiles"("id") ON DELETE CASCADE ON UPDATE CASCADE;
