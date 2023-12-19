# Create Users
20.times do
  User.create!(
    username: Faker::Internet.username,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    birth_date:,
    gender: sample_genders
  )
end

# Create Offers
20.times do
  criteria = {}
  Targetable.target_types.each do |klass|
    characteristics = klass.new.characteristics
    characs_indices = characteristics.map.with_index(1) { |element, index| index }

    cs = characteristics.sample(characs_indices.sample).each do |characteristic|
      criteria[characteristic] = if characteristic.inquiry.age?
        sample_age_from_users
      elsif characteristic.inquiry.gender?
        sample_genders
      end
    end

    Offer.create!(
      title: Faker::Company.bs,
      target_type: klass.to_s,
      criteria: criteria
    )
  end
end

# Methods
def birth_date
  Faker::Date.birthday(min_age: 18, max_age: 65)
end

def genders
  User::GENDERS
end

def gender_indices
  genders.map.with_index(1) { |element, index| index }
end

def sample_genders
  genders.sample(gender_indices.sample)
end

def age_from_users
  User.all.select("birth_date").map(&:birth_date).map(&method(:to_age))
end

def age_from_users_indices
  age_from_users.map.with_index(1) { |element, index| index }
end

def sample_age_from_users
  age_from_users.sample(age_from_users_indices.sample)
end

def to_age(birth_date)
  ((Time.zone.now - birth_date.to_time) / 1.year.seconds).floor
end
