-- CreateEnum
CREATE TYPE "Utility" AS ENUM ('ELECTRICITY', 'WATER', 'SEWERAGE', 'WASTE');

-- CreateEnum
CREATE TYPE "BillingComponent" AS ENUM ('ELECTRICITY_TOTAL', 'ELECTRICITY_DAY', 'ELECTRICITY_NIGHT', 'ELECTRICITY_DISTRIBUTION', 'MONTHLY_CHARGE', 'CAPACITY_CHARGE', 'RENEWABLES_CHARGE', 'EXCISE_DUTY', 'VAT', 'WATER', 'SEWERAGE', 'WASTE');

-- CreateEnum
CREATE TYPE "PaymentStatus" AS ENUM ('NOT_SENT', 'SENT', 'PAID');

-- CreateTable
CREATE TABLE "MeterReading" (
    "id" SERIAL NOT NULL,
    "date" TIMESTAMP(3) NOT NULL,
    "dayReading" DOUBLE PRECISION,
    "nightReading" DOUBLE PRECISION,
    "totalReading" DOUBLE PRECISION,
    "consumerId" INTEGER NOT NULL,
    "utility" "Utility" NOT NULL,

    CONSTRAINT "MeterReading_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Consumer" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "totalShare" DOUBLE PRECISION,

    CONSTRAINT "Consumer_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Rate" (
    "id" SERIAL NOT NULL,
    "name" "BillingComponent" NOT NULL,
    "utility" "Utility" NOT NULL,
    "startDate" TIMESTAMP(3) NOT NULL,
    "endDate" TIMESTAMP(3) NOT NULL,
    "appliesToDay" BOOLEAN NOT NULL DEFAULT false,
    "appliesToNight" BOOLEAN NOT NULL DEFAULT false,
    "appliesToTotal" BOOLEAN NOT NULL DEFAULT true,
    "amount" DOUBLE PRECISION NOT NULL,
    "frequency" INTEGER,

    CONSTRAINT "Rate_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Bill" (
    "id" SERIAL NOT NULL,
    "startDate" TIMESTAMP(3) NOT NULL,
    "endDate" TIMESTAMP(3) NOT NULL,
    "status" "PaymentStatus" NOT NULL DEFAULT 'NOT_SENT',
    "paymentDate" TIMESTAMP(3),
    "consumerId" INTEGER NOT NULL,

    CONSTRAINT "Bill_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PaymentCalculation" (
    "id" SERIAL NOT NULL,
    "billId" INTEGER NOT NULL,
    "utilityId" INTEGER NOT NULL,
    "rateId" INTEGER NOT NULL,
    "billingPeriodStart" TIMESTAMP(3) NOT NULL,
    "billingPeriodEnd" TIMESTAMP(3) NOT NULL,
    "calculationDate" TIMESTAMP(3) NOT NULL,
    "amount" DOUBLE PRECISION NOT NULL,
    "utility" "Utility" NOT NULL,

    CONSTRAINT "PaymentCalculation_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_MeterReadingToPaymentCalculation" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "_MeterReadingToPaymentCalculation_AB_unique" ON "_MeterReadingToPaymentCalculation"("A", "B");

-- CreateIndex
CREATE INDEX "_MeterReadingToPaymentCalculation_B_index" ON "_MeterReadingToPaymentCalculation"("B");

-- AddForeignKey
ALTER TABLE "MeterReading" ADD CONSTRAINT "MeterReading_consumerId_fkey" FOREIGN KEY ("consumerId") REFERENCES "Consumer"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Bill" ADD CONSTRAINT "Bill_consumerId_fkey" FOREIGN KEY ("consumerId") REFERENCES "Consumer"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PaymentCalculation" ADD CONSTRAINT "PaymentCalculation_billId_fkey" FOREIGN KEY ("billId") REFERENCES "Bill"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PaymentCalculation" ADD CONSTRAINT "PaymentCalculation_rateId_fkey" FOREIGN KEY ("rateId") REFERENCES "Rate"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_MeterReadingToPaymentCalculation" ADD CONSTRAINT "_MeterReadingToPaymentCalculation_A_fkey" FOREIGN KEY ("A") REFERENCES "MeterReading"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_MeterReadingToPaymentCalculation" ADD CONSTRAINT "_MeterReadingToPaymentCalculation_B_fkey" FOREIGN KEY ("B") REFERENCES "PaymentCalculation"("id") ON DELETE CASCADE ON UPDATE CASCADE;
