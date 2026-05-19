import express from 'express';
import {
  adminListProducts,
  createProduct,
  updateProduct,
  deleteProduct
} from '../controllers/admin.product.controller.js';

const router = express.Router();

router.get('/products', adminListProducts);
router.post('/products', createProduct);
router.put('/products/:id', updateProduct);
router.delete('/products/:id', deleteProduct);


export default router;

