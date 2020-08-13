class MeasurementsController < ApplicationController
    before_action :set_step
    before_action :set_step_measurement, only: [:show, :update, :destroy]
  
    # GET /steps/:step_id/measurements
    def index
      json_response(@step.measurements)
    end
  
    # GET /steps/:step_id/measurements/:id
    def show
      json_response(@measurement)
    end
  
    # POST /steps/:step_id/measurements
    def create
      @step.measurements.create!(measurement_params)
      json_response(@step, :created)
    end
  
    # PUT /steps/:step_id/measurements/:id
    def update
      @measurement.update(measurement_params)
      head :no_content
    end
  
    # DELETE /steps/:step_id/measurements/:id
    def destroy
      @measurement.destroy
      head :no_content
    end
  
    private
  
    def measurement_params
      params.permit(:steps_recorded,)
    end
  
    def set_step
      @step = Step.find(params[:step_id])
    end
  
    def set_step_measurement
      @measurement = @step.measurements.find_by!(id: params[:id]) if @step
    end
end
