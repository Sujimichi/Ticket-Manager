class Comment < ActiveRecord::Base
  belongs_to :ticket
  named_scope :in_tickets, lambda {|ids| {:conditions => ["ticket_id IN (?)", ids]}}
end
