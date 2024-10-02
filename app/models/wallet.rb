class Wallet < Entity
  belongs_to :entity, polymorphic: true
end