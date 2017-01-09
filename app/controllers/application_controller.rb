class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception
  before_filter :authenticate_user!

	def citizen_only
		unless current_user.citizen?
			redirect_to :back, :alert => "Access denied."
		end
	end

	def alderman_only
		unless current_user.alderman?
			redirect_to :back, :alert => "Access denied."
		end
	end

	def assembly_president_only
		unless current_user.assembly_president?
			redirect_to :back, :alert => "Access denied."
		end
	end
end
