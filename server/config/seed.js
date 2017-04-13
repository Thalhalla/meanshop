/**
 * Populate DB with sample data on server start
 * to disable, edit config/environment/index.js, and set `seedDB: false`
 */

'use strict';

var User = require('../api/user/user.model');
var Product = require('../api/product/product.model');
var Catalog = require('../api/catalog/catalog.model');
var mainCatalog, home, books, clothing;

User.find({}).removeAsync()
  .then(function() {
    User.createAsync({
      provider: 'local',
      name: 'Test User',
      email: 'test@test.com',
      password: 'test'
    }, {
      provider: 'local',
      role: 'admin',
      name: 'Admin',
      email: 'admin@admin.com',
      password: process.env.ADMIN_PASSWORD || 'admin'
    })
    .then(function() {
      console.log('finished populating users');
    });
  });

Catalog
  .find({})
  .remove()
  .then(function () {
    return Catalog.create({ name: 'All'});
  })
  .then(function (catalog) {
    mainCatalog = catalog;
    return mainCatalog.addChild({name: 'Home'});
  })
  .then(function (category) {
    home = category._id;
    return mainCatalog.addChild({name: 'Books'});
  })
  .then(function (category) {
    books = category._id;
    return mainCatalog.addChild({name: 'Clothing'});
  })
  .then(function (category) {
    clothing = category._id;
    return Product.find({}).remove({});
  })
  .then(function() {
    return Product.create({
      title: 'CS:GO',
      imageUrl: '/assets/images/csgo.png',
      price: 15,
      stock: 999,
      categories: [home],
      description: 'Counter Strike : Global Offense'
    }, {
      title: 'Team Fortress 2',
      imageUrl: '/assets/images/tf2.png',
      price: 8,
      stock: 999,
      categories: [books],
      description: 'Team Fortress 2 - the classic FPS'
    }, {
      title: 'Arma3',
      imageUrl: '/assets/images/arma3.png',
      price: 16,
      stock: 999,
      categories: [clothing],
      description: 'Arma3 the military simulator'
    }, {
      title: '7 days to die',
      imageUrl: '/assets/images/7dtd.png',
      price: 18,
      stock: 999,
      categories: [home],
      description: '7 days to die the survival horror game that defined the genre'
    });
  })
  .then(function () {
    console.log('Finished populating Products with categories');
  })
  .then(null, function (err) {
    console.error('Error populating Products & categories: ', err);
  });
