const usuario = {
username: 'usuario',
password: '1234',
}
function checkLogin (req,res,next) {
    if  (usuario.username == req.body.username && usuario.password == req.body.password){
        next()
    } else {
        res.send('gracias profe por las clases')
    }
    
}

module.exports = checkLogin; 