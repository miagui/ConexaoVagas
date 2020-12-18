export function toDate(date: Date) {

    var dia = date.getDate();
    var mes = date.getMonth() + 1;
    var diaFormatado = dia > 9 ? dia : '0' + dia
    var mesFormatado = mes > 9 ? mes : '0' + mes

    return `${diaFormatado}/${mesFormatado}/${date.getFullYear()}`
}

export function toHour(date: Date) {

    var min = date.getMinutes() > 9 ? date.getMinutes() : '0' + date.getMinutes()

    return `${date.getHours()}:${min}`
}
