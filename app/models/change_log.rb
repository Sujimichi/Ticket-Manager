class ChangeLog < ActiveRecord::Base
  belongs_to :ticket
  

  def self.make user, ticket, change = nil, message = nil
   u = "<a href='/users/#{user.id}'>#{user.username}</a>"
   t = "<a href='/tickets/#{ticket.id}'>ticket #{ticket.id}</a>"
   unless message
     message = "changed #{change}"
   end

   log = "#{Time.now} - #{u} #{message} of #{t}"
   ticket.change_logs.create!(:log => log)
  end
end
