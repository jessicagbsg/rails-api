class ContactSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :birthdate
  
  belongs_to :kind
  has_many :phones
  has_one :address

  def attributes(*args)
    h = super(*args)
    h[:birthdate] = object.birthdate.to_time.iso8601 unless object.birthdate.blank?
    h
  end
end
