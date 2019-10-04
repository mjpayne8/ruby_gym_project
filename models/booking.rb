require_relative('../db/sql_runner')

class Booking

  attr_accessor(:member_id, :gym_class_id)
  attr_reader(:id)

  def initialize( options )
    @id = options['id'] if options['id']
    @member_id = options['member_id']
    @gym_class_id = options['gym_class_id']
  end

end
