-- CreateEnum
CREATE TYPE "PlacementStatus" AS ENUM ('PLACED', 'INTERVIEWING', 'NOT_PLACED');

-- AlterEnum
ALTER TYPE "Role" ADD VALUE 'COLLEGE';

-- AlterTable
ALTER TABLE "candidate_profiles" ADD COLUMN     "batch" TEXT,
ADD COLUMN     "branch" VARCHAR(255),
ADD COLUMN     "collegeId" TEXT,
ADD COLUMN     "placementStatus" "PlacementStatus";

-- CreateTable
CREATE TABLE "college_profiles" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "college_profiles_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "college_profiles_userId_key" ON "college_profiles"("userId");

-- CreateIndex
CREATE INDEX "college_profiles_userId_idx" ON "college_profiles"("userId");

-- CreateIndex
CREATE INDEX "candidate_profiles_collegeId_idx" ON "candidate_profiles"("collegeId");

-- AddForeignKey
ALTER TABLE "candidate_profiles" ADD CONSTRAINT "candidate_profiles_collegeId_fkey" FOREIGN KEY ("collegeId") REFERENCES "college_profiles"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "college_profiles" ADD CONSTRAINT "college_profiles_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;
