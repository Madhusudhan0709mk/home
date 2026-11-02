-- CreateTable
CREATE TABLE "ApplicationGroup" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "recruiterId" TEXT NOT NULL,
    "applicationIds" TEXT[],
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "ApplicationGroup_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "ApplicationGroup" ADD CONSTRAINT "ApplicationGroup_recruiterId_fkey" FOREIGN KEY ("recruiterId") REFERENCES "RecruiterProfile"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
