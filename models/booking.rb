require_relative('../db/sql_runner')

class Booking

  attr_accessor(:member_id, :gym_class_id)
  attr_reader(:id)

  def initialize( options )
    @id = options['id'] if options['id']
    @member_id = options['member_id']
    @gym_class_id = options['gym_class_id']
  end

  def save()
    sql = "INSERT INTO bookings
    (member_id, gym_class_id)
    VALUES
    ($1,$2) RETURNING id"
    values = [@member_id, @gym_class_id]
    @id = SqlRunner.run(sql, values)[0]['id']
  end

  def update()
    sql = "UPDATE bookings
    SET (@member_id, @gym_class) = ($1,$2)
    WHERE id = $3"
    values = [@member_id, @gym_class_id, @id]
    SqlRunner(sql, values)
  end

end
