require_relative('../db/sql_runner')
require_relative('./gym_class')
require_relative('./member')

class Booking

  attr_accessor(:member_id, :gym_class_id)
  attr_reader(:id)

  def initialize( options )
    @id = options['id'] if options['id']
    @member_id = options['member_id'].to_i
    @gym_class_id = options['gym_class_id'].to_i
  end

  def does_not_exist?()
    sql = "SELECT * FROM Bookings
    WHERE member_id = $1 and gym_class_id = $2"
    values = [@member_id, @gym_class_id]
    return SqlRunner.run(sql, values).map { |booking| booking }.empty?
  end

  def save()
    return "Class is oustide Membership hours - Booking Failed" if !within_membership_time?()
    return "No More Spaces - Booking Failed"  if !spaces
    return "Booking Already Exists" if !does_not_exist?()
    sql = "INSERT INTO bookings
    (member_id, gym_class_id)
    VALUES
    ($1,$2) RETURNING id"
    values = [@member_id, @gym_class_id]
    @id = SqlRunner.run(sql, values)[0]['id']
    return "Booking Successful"
  end

  def within_membership_time?()
    after_start = gym_class.class_time > member.membership.start_time
    before_end = gym_class.class_time < member.membership.end_time
    return after_start && before_end
  end

  def spaces?
    return gym_class.spaces_remaining() > 0
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

  def gym_class()
    sql = "SELECT * FROM gym_classes
    WHERE id = $1"
    values = [@gym_class_id]
    return GymClass.new(SqlRunner.run(sql,values)[0])
  end

  def member()
    sql = "SELECT * FROM members
    WHERE id = $1"
    values = [@member_id]
    return Member.new(SqlRunner.run(sql,values)[0])
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

  def self.find_by_foreign_keys(member_id, gym_class_id)
    sql = "SELECT * FROM bookings
    WHERE member_id = $1 AND gym_class_id = $2"
    values = [member_id, gym_class_id]
    return Booking.new(SqlRunner.run(sql,values)[0])
  end

  def self.find(id)
    sql = "SELECT * FROM bookings
    WHERE id = $1"
    values = [id]
    return Booking.new(SqlRunner.run(sql,values)[0])
  end

end
