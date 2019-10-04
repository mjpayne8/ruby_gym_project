require_relative('../db/sql_runner')

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
    (class_name, class_date, class_date)
    VALUES
    ($1,$2,$3,$4) RETURNING id"
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

  def self.all()
    sql = "SELECT * FROM gym_classes"
    return SqlRunner.run(sql).map{ |gym_class| GymClass.new(gym_class) }
  end

  def self.delete_all()
    sql = "DELETE FROM gym_classes"
    SqlRunner.run(sql)
  end

end
