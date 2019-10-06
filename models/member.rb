require_relative('../db/sql_runner')
require_relative('./gym_class')
require_relative('./booking')

class Member

  attr_accessor(:first_name,:last_name,:address)
  attr_reader(:id)

  def initialize( options )
    @id = options['id'] if options['id']
    @first_name = options['first_name']
    @last_name = options['last_name']
    @address = options['address']
    @membership_id = options['membership_id']
  end

  def save()
    sql = "INSERT INTO members
    (first_name,last_name,address,membership_id)
    values
    ($1,$2,$3,$4) RETURNING id"
    values = [@first_name,@last_name,@address,@membership_id]
    @id = SqlRunner.run(sql,values)[0]['id']
  end

  def update()
    sql = "UPDATE members
    SET (first_name,last_name,address,@membership_id) = ($1,$2,$3)
    WHERE id = $4"
    values = [@first_name, @last_name, @address, @membership_id, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM members
    WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def gym_classes()
    sql = "SELECT gym_classes.* FROM gym_classes
    INNER JOIN bookings
    ON gym_classes.id = bookings.gym_class_id
    WHERE bookings.member_id = $1"
    values = [@id]
    return SqlRunner.run(sql, values).map { |gym_class| GymClass.new(gym_class) }
  end

  def bookings()
    sql = "SELECT * from bookings
    WHERE bookings.member_id = $1"
    values = [@id]
    return SqlRunner.run(sql, values).map { |booking| Booking.new(booking) }
  end

  def cascade_delete()
    bookings = bookings()
    bookings.each { |booking| booking.delete() }
    delete()
  end

  def membership()
    sql = "SELECT * FROM membership
    WHERE id = $1"
    values = [@membership_id]
    return Membership.new(SqlRunner.run(sql,values)[0])
  end

  def self.all()
    sql = "SELECT * FROM members
    ORDER BY id DESC"
    return SqlRunner.run(sql).map { |member| Member.new(member) }
  end

  def self.delete_all()
    sql = "DELETE FROM members"
    SqlRunner.run(sql)
  end

  def self.find(id)
    sql = "SELECT * FROM members
    WHERE id = $1"
    values = [id]
    return Member.new(SqlRunner.run(sql, values)[0])
  end

end
