class Person < ActiveRecord::Base
  
  attr_accessible :name
  attr_protected :pin_salt, :pin_hash
  
  has_many :accounts, :dependent => :destroy
  
  validates_presence_of :name
  validates_presence_of :pin_salt, :pin_hash

  validates_uniqueness_of :name    
  validates_length_of :name, :minimum => 3, :maximum => 30
    
  after_create :setup_accounts
  
  # Returns the Person, if given valid Name and PIN
  def self.authenticate(name, pin)
    person = Person.where(:name => name).first
    person if person and person.valid_pin?(pin)
  end
  
  # PIN setter, restricted to a 4 number string from 0000 - 9999
  def pin=(pin)
    if pin.match(/\d{4}/)
      self.pin_salt = Digest::SHA1.hexdigest([Time.now, rand].join)
      self.pin_hash = encrypt_pin(pin)
    end
  end
  
  def valid_pin?(pin)
    self.pin_hash == encrypt_pin(pin)
  end
  
protected

  def encrypt_pin(pin)
    Digest::SHA1.hexdigest([pin, self.pin_salt].join)
  end
  
private
  
  # Default to a Checking and Savings account for every user
  def setup_accounts
    self.accounts.create({:name => "Checking"})
    self.accounts.create({:name => "Savings"})
  end
  
end
