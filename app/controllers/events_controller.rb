class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  # GET /events
  # GET /events.json
  def index
    @events = Event.where(start: params[:start]..params[:end])
  end

   def show
  end

  def new
    @event = Event.new
  end

  def edit
  end

  def create
    @event = Event.new(event_params)
    @result = true
    # if Event.in_daterange(event_params[:start], event_params[:end]).blank?
      @event.save
    # else
    #   @result = false
    # end
  end

  def update
    @event.update(event_params)
  end

  def destroy
    @event.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:title, :date_range, :start, :end, :description, :phone_number, :license_no, :email)
    end
end
