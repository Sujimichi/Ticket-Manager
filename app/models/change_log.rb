class ChangeLog < ActiveRecord::Base
  belongs_to :ticket
  

  def self.make user, ticket, change = nil, message = nil
   unless message
     message = "changed #{change}"
   end

   log = "#{Time.now} - #{user_link(user)} #{message} of #{ticket_link(ticket)}"
   ticket.change_logs.create!(:log => log)
  end


  def self.log_comment user, comment
    log = "#{Time.now} - #{user_link(user)} wrote a #{comment_ticket_link(comment)} on #{ticket_link(comment.ticket)}"
    comment.ticket.change_logs.create!(:log => log)
  end

  
  def self.user_link user
    "<a href='/users/#{user.id}'>#{user.username}</a>"
  end
  def self.ticket_link ticket
    "<a href='/tickets/#{ticket.id}'>ticket #{ticket.id}</a>"
  end
  def self.comment_ticket_link comment
    "<a href='/tickets/#{comment.ticket.id}'>comment</a>"
  end


end
