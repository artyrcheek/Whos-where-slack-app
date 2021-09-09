class SlackLocationStatementsController < ApplicationController
  require 'chronic'

  def index
    puts "INDEX"
    def slash_command(string)
      work_statement = LocationStatement.new(string)
      puts work_statement
    end

    slash_command("/im Remote tomorrow")
    slash_command("/im in the office tomorrow")
    slash_command("/im going to be remote on friday")
    slash_command("/im not going to be helpful on tuesday")
    slash_command("/im probs feeling like ill go to the office on friday")
    slash_command("/im working from home on wednesday, gotta take the kids to work")
    slash_command("/im not gonna be in this thursday, gotta take the kids to school")
    slash_command("/im gonna come in to the office today")
    slash_command("/im in the office today")
    slash_command("/im off on monday, kid duty.")
    slash_command("/ill be remote tomorrow morning")
    slash_command("/ill be remote tomorrow evening")
    slash_command("/im in the office")
    render json: {test: "hi"}
  end
  def create
    puts params
    location_statement = LocationStatement.new(params[:text])
    render json: "Sorry I didnt understand, please try again" and return unless location_statement.valid?

    confirmation_message = "#{location_statement.location.emoji} <@#{params[:user_id]}> is *#{location_statement.location}* on *#{location_statement.time.strftime("%A #{location_statement.time.day.ordinalize}")}*"
    extra_message = location_statement.message ? "\n\n💬 #{location_statement.message}" : nil
    return_message = {
      blocks: [
    		{
    			type: 'section',
    			text: {
    				type: 'mrkdwn',
    				text: "#{confirmation_message} #{extra_message}"
    			}
    		}
    	]
    }
    render json: return_message
  end
end
