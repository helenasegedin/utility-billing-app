const express = require('express');
const prisma = require('@prisma/client');
const bodyParser = require('body-parser');

const { PrismaClient } = prisma;
const prismaClient = new PrismaClient();

const app = express();
app.use(bodyParser.json());

// Endpoint to add meter readings
app.post('/meter-readings', async (req, res) => {
    const { date, dayReading, nightReading, totalReading, consumerId, utility } = req.body;
    const reading = await prismaClient.meterReading.create({
        data: { date, dayReading, nightReading, totalReading, consumerId, utility },
    });
    res.json(reading);
});

// Endpoint to add provider rates
app.post('/rates', async (req, res) => {
    const { name, utility, startDate, endDate, appliesToDay, appliesToNight, appliesToTotal, amount, frequency } = req.body;
    const rate = await prismaClient.providerRate.create({
        data: { name, utility, startDate, endDate, appliesToDay, appliesToNight, appliesToTotal, amount, frequency },
    });
    res.json(rate);
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
});
