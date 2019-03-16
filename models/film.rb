require_relative("../db/sql_runner")

class Film
  attr_reader :id
  attr_accessor :title, :price

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price']
  end

#C
  def save()
    sql = 'INSERT INTO films (title, price) VALUES ($1, $2) RETURNING id'
    values = [@title, @price]
    film = SqlRunner.run(sql, values).first
    @id = film['id'].to_i
  end

#R
  def self.show_all
    sql = 'SELECT * FROM films'
    data = SqlRunner.run(sql)
    return data.map { |hash| Film.new(hash) }
  end

#U
  def update
    sql = 'UPDATE films SET (title, price) = ($1, 2) WHERE id = $3'
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)
  end

#D
  def delete
    sql = 'DELETE * FROM films WHERE id = $1'
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all
    sql = 'DELETE FROM films'
    SqlRunner.run(sql)
  end

#display customer data for film
  def customer
    sql = 'SELECT customers.* FROM customers INNER JOIN tickets ON customers.id = tickets.customer_id WHERE film_id = $1'
    values = [@id]
    customer_data = SqlRunner.run(sql, values)
    return customer_data.map { |hash| Customer.new(hash)  }
  end 
end
