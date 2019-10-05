require_relative('../db/sql_runner')

class Membership

  attr_accessor(:type, :start_time, :end_time)
  attr_reader(:id)

  def initialize( options )
    @id = options['id'] if options['id']
    @type = options['type']
    @start_time = options['start_time']
    @end_time = options['end_time']
  end

  def save()
    sql = "INSERT INTO memberships
    (type, start_time, end_time)
    VALUES ($1,$2,$3)
    RETURNING id"
    values = [@type, @start_time, @end_time]
    @id = SqlRunner.run(sql, values)[0]['id']
  end

end
