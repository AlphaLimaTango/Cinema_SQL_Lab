require_relative("../db/sql_runner")


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

#1 Check how many tickets were bought by a customer
  def ticket_count
    sql = 'SELECT films.* FROM films INNER JOIN tickets ON films.id = tickets.film_id WHERE customer_id = $1'
    values = [@id]
    film_data = SqlRunner.run(sql, values).count
    return film_data
  end

  # def buy_ticket(film)
  #   sql = 'UPDATE customers SET funds = $1 WHERE id = $2'
  #   remaining_funds = @funds - film['price']
  #   values = [remaining_funds, @id]
  #   SqlRunner.run(sql, values)
  # end
  #
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

end
