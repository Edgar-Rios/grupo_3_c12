let router = require('express').Router()
let controller = require('../controllers/userController')
let uploadFile = require ('../middlewares/uploadAvatar')
let registerValidator = require('../validations/registerValidator')
let loginValidator = require ('../validations/loginValidator')
let profileValidator = require ('../validations/profileValidator')
let usercheckLogin = require('../middlewares/usercheckLogin');
const onlyLoguedUsers = require('../middlewares/onlyLoguedUsers');


router.get('/login', usercheckLogin, controller.loginPage)
router.get('/register', usercheckLogin, controller.registerPage)
router.get('/carrousel', controller.registerPage)
router.get('/carrito', onlyLoguedUsers, controller.carrito)
router.get('/profile/:id'/*, usercheckLogin*/, controller.profile);

router.post('/register', uploadFile.single('avatarimage'),registerValidator, controller.processRegister)
router.put('/profile/:id', uploadFile.single('avatarimage'),profileValidator, controller.editar)
router.post('/login', loginValidator ,controller.login)
router.get('/logout', controller.logout)
/*router.post('/creacionPeliculas', uploadFile.single('imageCreate'),registerValidator, controller.processCreate)*/
module.exports = router