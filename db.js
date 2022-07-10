import pg from 'pg';

const pool = new pg.Pool({
    user: 'postgres',
    host: 'localhost',
    database: 'menu_escolar',
    password: '1234',
    max: 12,
    min: 2,
    idleTimeoutMillis: 3000,
    connectionTimeoutMillis: 2000
})


export async function get_user(email) {
    const client = await pool.connect()
    if (!email) {
        const { rows } = await client.query({
            text: 'select * from schools ',

        })
        client.release()
        // console.log('qui toy');
        return rows
    } else {
        const { rows } = await client.query({
            text: 'select * from schools where email=$1',
            values: [email]
        })
        client.release()
        return rows[0]
    }
}
export async function create_user(name, email, password) {
    const client = await pool.connect()
    const user = await get_user();
    if (user.length == 0) {

        await client.query({
            text: `insert into schools (name, email, password,es_admin) values ($1, $2, $3,'true')`,
            values: [name, email, password]
        })

        client.release()
    } else {

        await client.query({
            text: 'insert into schools (name, email, password) values ($1, $2, $3)',
            values: [name, email, password]
        })

        client.release()
    }
}

export async function create_order(id_school, vegetariano, celiaco, estandar, caloricos, autoctonos, fecha) {

    const client = await pool.connect();
    await client.query({
        text: 'insert into orders (date,school_id,vegetarian,celiac,standart,caloric,ethnic) values ($1, $2, $3, $4, $5, $6, $7)',
        values: [fecha, id_school, vegetariano, celiaco, estandar, caloricos, autoctonos],
        name: 'insert-new-order'

    })
    client.release()
}
export async function get_order(id_school) {
    const client = await pool.connect();
    if (id_school) {
        const { rows } = await client.query({
            text: 'select * from orders where school_id=$1',
            values: [id_school],
            name: 'select-order-which-id-school'

        })
        client.release()
        return rows
    } else {
        const { rows } = await client.query({
            text: 'select * from orders ',
            name: 'select-all-orders'
        })
        client.release();
        return rows;
    }
}
export async function get_order_with_id(id_order) {
    const client = await pool.connect();
    const { rows } = await client.query({
        text: 'select * from orders where id=$1',
        values: [id_order],
        name: 'select-order-which-id-school'

    })
    client.release()
    return rows[0]
}
export async function rectify_order(id_order, vegetariano, celiaco, estandar, caloricos, autoctonos, observations) {

    const client = await pool.connect();
    await client.query({
        text: `update  orders
         set vegetarian_real=$1,
          celiac_real=$2,
           standar_real=$3,
           caloric_real=$4,
           ethnic_real=$5,
           is_rectified=true,
           observations=$6
            where id=$7`,
        values: [vegetariano, celiaco, estandar, caloricos, autoctonos, observations, id_order],
        name: 'update-order-rectify'

    })
    client.release()
}
export async function get_user_by_id(id_school) {
    const client = await pool.connect()

    const { rows } = await client.query({
        text: 'select name from schools where id=$1',
        values: [id_school]
    })
    client.release()
    return rows[0]

}