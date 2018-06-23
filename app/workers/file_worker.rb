require 'csv'
require 'sidekiq'
require 'uri'
# require 'sidekiq/testing/inline'
include Sidekiq::Worker
include SidekiqStatus::Worker
class FileWorker
  sidekiq_options :retry => false

  def perform(file_path, denomination, user_id)
  	@user  = User.find_by_id(user_id)
  	res    = true

    CSV.foreach(URI.parse(file_path), headers: true) do |row|
    	hash = row.to_h
      @inpu_array = Array.new(hash.length){Array.new} if res

      hash.keys.each_with_index do |key, index|
        @inpu_array[index] << hash[key] if hash[key].present?
      end

    	res = false
	  end

  	generate_combination(@inpu_array)
  	create_new_record(denomination.to_i)
  end

  def generate_combination(input_array)
  	first, *rest = input_array.map{|a| [*a]}
	  @final = first.product(*rest).map{|a| a.compact.join(",")} - [""]
  end

  def create_new_record(denomination)
    @results    = []
    self.total  = @final.length

  	@final.each_with_index do |value, index|
      denomination += 1
      @results << @user.skus.create(denomination: denomination, combination: value)
      at index
  	end

  	UserMailer.task_completion_email(@user, @results).deliver_now
  end
end


# Rails.application.config.action_controller.default_url_options = { host: 'localhost', port: 3000 }
# view = html = ActionView::Base.new(Rails.root.join('app/views'))
# view.class.include ApplicationHelper
# view.class.include Rails.application.routes.url_helpers
# view.render(:template => "skus/index", locals:  { :@skus => @results }, :location => Rails.application.routes.url_helpers.skus_url(only_path: true))
# view.render(
#   js: "skus/display",
#   locals:  { :@skus => @results }
# )