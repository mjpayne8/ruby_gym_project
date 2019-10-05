require_relative('../db/sql_runner')
require_relative('./member')
require_relative('./booking')

class GymClass

  attr_accessor(:class_name, :class_date, :class_time)
  attr_reader(:id)

  def initialize( options )
    @id = options['id'] if options['id']
    @class_name = options['class_name']
    @class_date = options['class_date']
    @class_time = options['class_time']
  end

  def save()
    sql = "INSERT INTO gym_classes
    (class_name, class_date, class_time)
    VALUES
    ($1,$2,$3) RETURNING id"
    values = [@class_name, @class_date, @class_time]
    @id = SqlRunner.run(sql, values)[0]['id']
  end

  def update()
    sql = "UPDATE gym_classes
    SET (class_name, class_date, class_time) = ($1,$2,$3)
    WHERE id = $4"
    values = [@class_name, @class_date, @class_time, @id]
    SqlRunner.run(sql,values)
  end

  def delete()
    sql = "DELETE FROM gym_classes
    WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def members()
    sql = "SELECT members.* FROM members
    INNER JOIN bookings
    ON members.id = bookings.member_id
    WHERE bookings.gym_class_id = $1"
    values = [@id]
    return SqlRunner.run(sql, values).map { |member| Member.new(member) }
  end

  def bookings()
    sql = "SELECT * FROM bookings
    WHERE gym_class_id = $1"
    values = [@id]
    return SqlRunner.run(sql, values).map { |booking| Booking.new(booking) }
  end

  def cascade_delete()
    bookings = bookings()
    bookings.each { |booking| booking.delete() }
    delete()
  end

  def self.all()
    sql = "SELECT * FROM gym_classes"
    return SqlRunner.run(sql).map{ |gym_class| GymClass.new(gym_class) }
  end

  def self.delete_all()
    sql = "DELETE FROM gym_classes"
    SqlRunner.run(sql)
  end

  def self.find(id)
    sql = "SELECT * FROM gym_classes
    WHERE id = $1"
    values = [id]
    return GymClass.new(SqlRunner.run(sql, values)[0])
  end

end
