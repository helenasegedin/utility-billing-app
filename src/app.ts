import express from 'express'
import prisma from '@prisma/client'
import bodyParser from 'body-parser'
import meterReadingRoutes from './routes/meterReadingRoutes'

const { PrismaClient } = prisma;
const prismaClient = new PrismaClient();

const app = express();

// Middleware
app.use(bodyParser.json());

// Routes
app.use('/meter-readings', meterReadingRoutes);

// Endpoint to add meter readings
app.post('/meter-readings', async (req: { body: { date: any; dayReading: any; nightReading: any; totalReading: any; consumerId: any; utility: any; }; }, res: { json: (arg0: any) => void; }) => {
    const { date, dayReading, nightReading, totalReading, consumerId, utility } = req.body;
    const reading = await prismaClient.meterReading.create({
        data: { date, dayReading, nightReading, totalReading, consumerId, utility },
    });
    res.json(reading);
});

// Endpoint to add provider rates
app.post('/rates', async (req, res) => {
    const { name, utility, startDate, endDate, appliesToDay, appliesToNight, appliesToTotal, amount, frequency } = req.body;
    const rate = await prismaClient.rate.create({
        data: { name, utility, startDate, endDate, appliesToDay, appliesToNight, appliesToTotal, amount, frequency },
    });
    res.json(rate);
});

export default app