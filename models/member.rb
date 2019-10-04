class Member

  attr_accessor(:first_name,:last_name,:address)
  attr_reader(:id)

  def initialize( options )
    @id = options['id'] if options['id']
    @first_name = options['first_name']
    @last_name = options['last_name']
    @address = options['address']
  end



end
