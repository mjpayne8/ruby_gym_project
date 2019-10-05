require_relative('../db/sql_runner')

class Booking

  attr_accessor(:member_id, :gym_class_id)
  attr_reader(:id)

  def initialize( options )
    @id = options['id'] if options['id']
    @member_id = options['member_id']
    @gym_class_id = options['gym_class_id']
  end

  def exists?()
    sql = "SELECT * FROM Bookings
    WHERE member_id = $1 and gym_class_id = $2"
    values = [@member_id, @gym_class_id]
    return SqlRunner.run(sql, values).map { |booking| booking }.empty?
  end

  def save()
    if exists?()
      sql = "INSERT INTO bookings
      (member_id, gym_class_id)
      VALUES
      ($1,$2) RETURNING id"
      values = [@member_id, @gym_class_id]
      @id = SqlRunner.run(sql, values)[0]['id']
    end
  end

  def update()
    sql = "UPDATE bookings
    SET (@member_id, @gym_class) = ($1,$2)
    WHERE id = $3"
    values = [@member_id, @gym_class_id, @id]
    SqlRunner(sql, values)
  end

  def delete()
    sql = "DELETE FROM bookings
    WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM bookings
    ORDER BY id"
    return SqlRunner.run(sql).map { |booking| Booking.new(booking) }
  end

  def self.delete_all()
    sql = "DELETE FROM bookings"
    SqlRunner.run(sql)
  end

end
