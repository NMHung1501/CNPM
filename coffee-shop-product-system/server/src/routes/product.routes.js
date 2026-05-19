import express from 'express';
import { listProducts, getProductById } from '../controllers/product.controller.js';

const router = express.Router();

// Customer showcase
router.get('/', listProducts);
router.get('/:id', getProductById);

export default router;

