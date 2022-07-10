import express from 'express';
import { create_order, get_order, get_order_with_id, get_user_by_id, rectify_order } from '../db.js'
import formatDate from '../utils/formatDate.js';


const router = express.Router();

function protected_route(req, res, next) {
    if (!req.session.user) {
        return res.redirect('/login')
    }
    next()
}


router.get('/', protected_route, async (req, res) => {
    const user = req.session.user;
    const mensaje = req.flash('mensaje')
    if (user.es_admin == true) {
        const orders = await get_order();
        orders.forEach(async (o) => {
            const school_data = await get_user_by_id(o.school_id);
            o.school_name = school_data.name
            console.log(o);
        })
        formatDate(orders)
        res.render('index.html', { mensaje, orders, user })
    } else {
        const orders = await get_order(user.id);
        formatDate(orders)
        res.render('index.html', { mensaje, orders, user })
    }
});
router.get('/orders/new', protected_route, (req, res) => {
    res.render('newOrder.html')
})
router.post('/orders/new', async (req, res) => {
    console.log(req.body);
    const id_school = req.session.user.id
    const order_data = req.body;
    create_order(id_school, order_data.vegetarian, order_data.celiaco, order_data.estandar, order_data.caloricos, order_data.autoctonos, order_data.fecha)
    req.flash('mensaje', 'pedido creado con exito!')

    res.redirect('/')
})
router.get('/orders/:id_pedido/rectify', async (req, res) => {
    const id_pedido = req.params.id_pedido;
    const order = await get_order_with_id(id_pedido)
    formatDate(order)
    res.render('rectify.html', { order, id_pedido })
})
router.post('/orders/:id_pedido/rectify', async (req, res) => {
    const id_order = req.params.id_pedido;
    const order_rectify = req.body
    await rectify_order(id_order,
        order_rectify.vegetarian, order_rectify.celiaco, order_rectify.estandar, order_rectify.caloricos, order_rectify.autoctonos, order_rectify.observaciones)
    res.redirect('/')
})
router.get('/orders/:id_pedido', async (req, res) => {
    const id_order = req.params.id_pedido;
    const order = await get_order_with_id(id_order)
    formatDate(order)
    res.render('orderDetail.html', { order, id_order })
})

export default router;