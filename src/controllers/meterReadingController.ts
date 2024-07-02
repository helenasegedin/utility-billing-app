import {Request, Response} from 'express';
import {PrismaClient} from '@prisma/client';

const prisma = new PrismaClient();

export const createMeterReading = async (req: Request, res: Response) => {
    try {
        const { date, dayReading, nightReading, totalReading, consumerId, utility } = req.body;

        const meterReading = await prisma.meterReading.create({
            data: {
                date: new Date(date),
                dayReading,
                nightReading,
                totalReading,
                consumerId,
                utility,
            },
        });

        res.status(201).json(meterReading);
    } catch (error: any) {
        res.status(500).json({ error: error.message });
    }
};
