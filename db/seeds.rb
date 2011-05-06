AtMachine.destroy_all
Person.destroy_all

AtMachine.create!(:cash => 10000)

people = [{:name => "Steve", :pin => "1234"},
          {:name => "Adam", :pin => "2345"},
          {:name => "Mike", :pin => "3456"},
          {:name => "Stacy", :pin => "4567"},
          {:name => "Alice", :pin => "5678"},
          {:name => "Marcy", :pin => "6789"},
          {:name => "John", :pin => "7890"},
         ]
         
people.each do |p| 
  person = Person.create!(p)
  person.accounts.each do |a| 
    a.balance = rand(1000)
    a.save
  end
end

