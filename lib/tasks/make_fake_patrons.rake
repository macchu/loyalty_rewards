desc "Create patrons and check ins."
task :make_fake_patrons => :environment do
  Store.all.each do |s|
    ap "Making patrons for #{s.name}..."
    (1..rand(9..25)).each do |i|
      ap "Making patron ##{i}"
      p = Patron.create(first_name: Faker::Name.first_name, 
                  last_name: Faker::Name.last_name,
                  phone_number: Faker::PhoneNumber.cell_phone,
                  pending: false)
      PatronStore.create(patron: p, store: s)
      (0..rand(0..20)).reverse_each do |j|
        ap "Making check in ##{j.days.ago}"
        CheckIn.create( patron: p, 
                        store: s, 
                        phone_number: p.digit_only_phone_number, 
                        created_at: Faker::Date.backward(30)
                      )
      end
    end
  end
end
