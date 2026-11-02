-- AlterTable
ALTER TABLE "Job" ADD COLUMN     "externalLink" TEXT,
ADD COLUMN     "quickApply" BOOLEAN NOT NULL DEFAULT true;
