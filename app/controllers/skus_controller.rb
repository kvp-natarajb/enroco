class SkusController < ApplicationController

  layout "dashboard"

  before_action :authenticate_user!
  before_action :set_sku, only: [:show, :edit, :update, :destroy]

  # GET /skus
  # GET /skus.json
  def index
    @skus = current_user.skus.paginate(:page => params[:page], :per_page => 30)
  end

  def import
   @job_id = FileWorker.perform_async(params[:sku][:file].path, params[:sku][:denomination], current_user.id)
    # Sku.import(params[:sku][:file].path)
    respond_to do |format|
      format.js
    end
  end

  def percentage_done
    job_id = params[:job_id] # grabbing the job_id from params
    # Using the sidekiq_status gem to query the background job for progress information.
    container = SidekiqStatus::Container.load(job_id)
    # I'm asking the background job how far along it is in the process
    @pct_complete = container.pct_complete
    p "====================================="
    p @pct_complete
    p "====================================="
    respond_to do |format|
      format.json { 
        render :json => {
          :percentage_done => @pct_complete, # responding with json with the percent complete data
        }
      }
    end
  end

  # GET /skus/new
  def new
    @sku = Sku.new
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sku
      @sku = Sku.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sku_params
      params.require(:sku).permit(:denomination, :combination)
    end
end
