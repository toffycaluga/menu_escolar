import moment from "moment";
export default function formatDate(orders) {
    for (let i = 0; i < orders.length; i++) {
        const dateFormat = moment(orders[i].date).format('LLL');
        orders[i].date = `${dateFormat} `
    }

}