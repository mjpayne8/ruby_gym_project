require_relative('../models/gym_class')
require_relative('../models/member')
require_relative('../models/booking')
require_relative('../models/membership')

Booking.delete_all()
GymClass.delete_all()
Member.delete_all()
Membership.delete_all()

gym_class1 = GymClass.new({'class_name'=>'yoga',
  'class_date'=>'2019-10-12',
  'class_time'=>'20:00',
  'duration'=>60,
  'spaces'=>6})
gym_class2 = GymClass.new({'class_name'=>'spin',
  'class_date'=>'2019-10-13',
  'class_time'=>'10:00',
  'duration'=>30,
  'spaces'=>6})
gym_class3 = GymClass.new({'class_name'=>'body pump',
  'class_date'=>'2019-10-14',
  'class_time'=>'11:00',
  'duration'=>60,
  'spaces'=>6})
gym_class4 = GymClass.new({'class_name'=>'aerobics',
  'class_date'=>'2019-10-15',
  'class_time'=>'14:00',
  'duration'=>30,
  'spaces'=>6})
gym_class5 = GymClass.new({'class_name'=>'insanity',
  'class_date'=>'2019-10-16',
  'class_time'=>'16:00',
  'duration'=>60,
  'spaces'=>1})
gym_class1.save()
gym_class2.save()
gym_class3.save()
gym_class4.save()
gym_class5.save()

membership1 = Membership.new({'type' => 'Premium', 'start_time' => '00:00', 'end_time' => '23:59'})
membership2 = Membership.new({'type' => 'Off-Peak', 'start_time' => '10:00', 'end_time' => '16:00'})
membership1.save()
membership2.save()

member1 = Member.new('first_name'=>'Arnie', 'last_name'=>'Swartz', 'address'=>'24 Main Street', 'membership_id' => membership1.id)
member2 = Member.new('first_name'=>'Sylvia', 'last_name'=>'Stallone', 'address'=>'22 Second Street', 'membership_id' => membership1.id)
member3 = Member.new('first_name'=>'Wayne', 'last_name'=>'Johnson', 'address'=>'4 Third Street', 'membership_id' => membership2.id)
member1.save()
member2.save()
member3.save()

booking1 = Booking.new('gym_class_id' => gym_class1.id, 'member_id' => member1.id)
booking2 = Booking.new('gym_class_id' => gym_class2.id, 'member_id' => member1.id)
booking3 = Booking.new('gym_class_id' => gym_class3.id, 'member_id' => member2.id)
booking4 = Booking.new('gym_class_id' => gym_class4.id, 'member_id' => member2.id)
booking5 = Booking.new('gym_class_id' => gym_class5.id, 'member_id' => member3.id)
booking6 = Booking.new('gym_class_id' => gym_class1.id, 'member_id' => member3.id)
booking7 = Booking.new('gym_class_id' => gym_class2.id, 'member_id' => member3.id)
booking8 = Booking.new('gym_class_id' => gym_class3.id, 'member_id' => member1.id)
booking9 = Booking.new('gym_class_id' => gym_class4.id, 'member_id' => member1.id)
booking1.save()
booking2.save()
booking3.save()
booking4.save()
booking5.save()
booking6.save()
booking7.save()
booking8.save()
booking9.save()
