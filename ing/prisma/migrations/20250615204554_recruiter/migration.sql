-- AlterTable
ALTER TABLE "Application" ADD COLUMN     "extraAnswers" JSONB;

-- AlterTable
ALTER TABLE "Job" ADD COLUMN     "department" TEXT,
ADD COLUMN     "experienceLevel" TEXT,
ADD COLUMN     "expiresAt" TIMESTAMP(3),
ADD COLUMN     "extraQuestions" TEXT[] DEFAULT ARRAY[]::TEXT[],
ADD COLUMN     "jobType" TEXT,
ADD COLUMN     "salaryRangeMax" INTEGER,
ADD COLUMN     "salaryRangeMin" INTEGER,
ADD COLUMN     "workplaceType" TEXT;
