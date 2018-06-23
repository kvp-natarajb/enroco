class UserMailer < ApplicationMailer

	default from: 'notifications@example.com'

	def task_completion_email(user, records)
	    @user = user
	    @records = records
	    mail(to: @user.email, subject: 'Upload of file completed successfully')
	  end
end
