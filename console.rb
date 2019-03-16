require_relative('models/customer')
require_relative('models/film')
require_relative('models/ticket')

# require('pry-byebug')

Ticket.delete_all
Customer.delete_all
Film.delete_all

customer1 = Customer.new({
  'name' => 'Harold',
  'funds' => 50
  })
customer1.save

customer2 = Customer.new({
    'name' => 'Fred',
    'funds' => 30
  })
customer2.save

customer3 = Customer.new({
  'name' => 'Enrique',
  'funds' => 100
  })
customer3.save

film1 = Film.new({
  'title' => 'Lion King',
  'price' => 10
  })
film1.save

film2 = Film.new({
  'title' => 'Toy Story 5',
  'price' => 5
  })
film2.save

film3 = Film.new({
  'title' => 'Avengers',
  'price' => 15
  })
film3.save

ticket1 = Ticket.new({
  ''
  })
# binding.pry
# nil
