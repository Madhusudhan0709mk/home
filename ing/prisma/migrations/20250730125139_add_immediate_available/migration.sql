-- CreateEnum
CREATE TYPE "EducationLevel" AS ENUM ('HIGH_SCHOOL', 'DIPLOMA', 'BACHELORS', 'MASTERS', 'PHD');

-- CreateEnum
CREATE TYPE "Gender" AS ENUM ('MALE', 'FEMALE', 'OTHER');

-- CreateEnum
CREATE TYPE "ShiftType" AS ENUM ('DAY', 'NIGHT', 'ROTATIONAL');

-- CreateEnum
CREATE TYPE "lookingfor" AS ENUM ('LOOKING_FOR_JOBS', 'LOOKING_FOR_INTERNSHIPS', 'NOT_SEARCHING');

-- CreateEnum
CREATE TYPE "NoticePeriod" AS ENUM ('WITHIN_15_DAYS', 'ONE_MONTH', 'TWO_MONTHS', 'THREE_MONTHS');

-- CreateEnum
CREATE TYPE "ExperienceType" AS ENUM ('INTERNSHIP', 'FULL_TIME', 'CONTRACT', 'FREELANCE');

-- AlterTable
ALTER TABLE "CandidateProfile" ADD COLUMN     "currentLocation" TEXT,
ADD COLUMN     "educationLevel" "EducationLevel",
ADD COLUMN     "gender" "Gender",
ADD COLUMN     "hometown" TEXT,
ADD COLUMN     "immediatelyAvailable" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "languages" TEXT[],
ADD COLUMN     "lookingfor" "lookingfor",
ADD COLUMN     "noticePeriod" "NoticePeriod",
ADD COLUMN     "preferredJobTitles" TEXT[],
ADD COLUMN     "preferredLocations" TEXT[];

-- AlterTable
ALTER TABLE "Experience" ADD COLUMN     "experienceType" "ExperienceType"[];
