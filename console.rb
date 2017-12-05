require ("pry-byebug")
require_relative("./model/bounty.rb")

Bounty.delete_all()

bounty1 = Bounty.new({
  'name' => 'Red',
  'bounty_value' => '250',
  'favourite_weapon' => 'ray gun',
  'collected_by' => 'Dread Pirate Roberts'
  })

bounty2 = Bounty.new({
  'name' => 'Purple',
  'bounty_value' => '150',
  'favourite_weapon' => 'phazer',
  'collected_by' => 'Princess Leia'
  })

  bounty1.save()
  bounty2.save()

  # bounty1.name='Blue'
  # bounty1.update()

  # bounty1.delete()
  found = Bounty.find_by_id(bounty1.id())

  binding.pry
  nil
