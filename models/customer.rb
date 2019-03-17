require_relative("../db/sql_runner")
require_relative('film')
require_relative('ticket')


class Customer
  attr_reader :id
  attr_accessor :name, :funds

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds'].to_i
  end

#C
  def save()
    sql = 'INSERT INTO customers (name, funds) VALUES ($1, $2) RETURNING id'
    values = [@name, @funds]
    customer = SqlRunner.run(sql, values).first
    @id = customer['id'].to_i
  end

#R
  def self.show_all
    sql = 'SELECT * FROM customers'
    data = SqlRunner(sql)
    return data.map { |hash| Customer.new(hash) }
  end

#U
  def update
    sql = 'UPDATE customers SET (name, funds) = ($1, $2) WHERE id = $3'
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end

#D
  def delete
    sql = 'DELETE * FROM customers WHERE id = $1'
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all
    sql = 'DELETE FROM customers'
    SqlRunner.run(sql)
  end

#Display film data for customer
  def films
    sql = 'SELECT films.* FROM films INNER JOIN tickets ON films.id = tickets.film_id WHERE customer_id = $1'
    values = [@id]
    film_data = SqlRunner.run(sql, values)
    return film_data.map { |hash| Film.new(hash)  }
  end

#.map function
  def map_item(data)
    result = data.map { |customer| Customer.new(customer)  }
    return result
  end

#basic extensions

#2 Check how many tickets were bought by a customer
  def ticket_count
    sql = 'SELECT films.* FROM films INNER JOIN tickets ON films.id = tickets.film_id WHERE customer_id = $1'
    values = [@id]
    film_data = SqlRunner.run(sql, values).count
    return film_data
  end

#1 Buying tickets should decrease the funds of the customer by the price

  def buy_ticket(film)
    sql = 'UPDATE customers SET funds = $1 WHERE id = $2'
    change_funds(film)
    values = [change_funds(film), @id]
    ticket_bought = SqlRunner.run(sql, values)
    # return ticket_bought.map { |hash| Ticket.new(hash)  }
    p ticket_bought
    sql1 = 'INSERT INTO tickets (customer_id, film_id) VALUES ($1, $2) RETURNING id'
    values = [@id, film.id]
    ticket = SqlRunner.run(sql1, values).first
    @id = ticket['id'].to_i
  end

  #but I don't know how to go about actually creating a ticket for my ticket table :(
  #omg i might have done it?????^^

  def show_funds
    return "I have #{@funds} bucks"
  end

  def change_funds(film)
    return @funds - film.get_film_price
  end

#######################Katharina's Code
  # def buy_ticket(film)
  #   price = film.price
  #   if @funds >= price
  #     sql1 = ‘UPDATE customers SET funds = $1 WHERE id = $2;’
  #     values1 = [(@funds - price)]
  #     SqlRunner.run(sql1, values)
  #
  #     sql2 = ‘INSERT INTO tickets (customer_id, film_id) VALUES ($1, $2);’
  #     values2 = [@id, film.id]
  #     SqlRunner.run(sql2, values2)
  #   end
  # end
#################################

end
