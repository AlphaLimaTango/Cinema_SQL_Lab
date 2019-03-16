require_relative("../db/sql_runner")


class Customer
  attr_reader :id
  attr_accessor :name, :funds

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds'].to_i
  end

  def save()
    sql = 'INSERT INTO customers (name, funds) VALUES ($1, $2) RETURNING id'
    values = [@name, @funds]
    customer = SqlRunner.run(sql, values).first
    @id = customer['id'].to_i
  end

  def self.show_all
    sql = 'SELECT * FROM customers'
    data = SqlRunner(sql)
    return data.map { |hash| Customer.new(hash) }
  end

  def update
    sql = 'UPDATE customers SET (name, funds) = ($1, $2) WHERE id = $3'
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end
end