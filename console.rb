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

ticket1 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film1.id})
ticket2 = Ticket.new({'customer_id' => customer2.id, 'film_id' => film1.id})
ticket3 = Ticket.new({'customer_id' => customer3.id, 'film_id' => film1.id})
ticket4 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film2.id})
ticket5 = Ticket.new({'customer_id' => customer2.id, 'film_id' => film2.id})
ticket6 = Ticket.new({'customer_id' => customer3.id, 'film_id' => film2.id})
ticket7 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film3.id})
ticket8 = Ticket.new({'customer_id' => customer2.id, 'film_id' => film3.id})
ticket9 = Ticket.new({'customer_id' => customer3.id, 'film_id' => film3.id})

ticket1.save
ticket2.save
ticket3.save
ticket4.save
ticket5.save
ticket6.save
ticket7.save
ticket8.save
ticket9.save

# binding.pry
# nil
