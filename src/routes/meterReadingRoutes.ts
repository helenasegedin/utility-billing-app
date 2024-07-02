import { Router } from 'express';
import { createMeterReading } from '../controllers/meterReadingController';

const router = Router();

router.post('/', createMeterReading);

export default router;