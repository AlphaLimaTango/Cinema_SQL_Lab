require_relative("../db/sql_runner")

class Film
  attr_reader :id
  attr_accessor :title, :price

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price']
  end

  def save()
    sql = 'INSERT INTO films (title, price) VALUES ($1, $2) RETURNING id'
    values = [@title, @price]
    film = SqlRunner.run(sql, values).first
    @id = film['id'].to_i
  end

  def self.show_all
    sql = 'SELECT * FROM films'
    data = SqlRunner.run(sql)
    return data.map { |hash| Film.new(hash) }
  end

  def update
    sql = 'UPDATE films SET (title, price) = ($1, 2) WHERE id = $3'
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)
  end
end
