require_relative('../db/sql_runner')

class GymClass

  def initialize( options )
    @id = options['id'] if options['id']
    @class_name = options['class_name']
    @class_date = options['class_date']
    @class_time = options['class_time']
  end

end
