class StepsController < ApplicationController
  before_action :set_step, only: %i[show update destroy]

  # GET /steps
  def index
    @steps = current_user.steps
    json_response(@steps)
  end

  # POST /steps
  def create
    @step = current_user.steps.create!(step_params)
    json_response(@step, :created)
  end

  # GET /steps/:id
  def show
    json_response(@step)
  end

  # PUT /steps/:id
  def update
    @step.update(step_params)
    head :no_content
  end

  # DELETE /steps/:id
  def destroy
    @step.destroy
    head :no_content
  end

  private

  def step_params
    # whitelist params
    params.permit(:title, :day_recorded, :steps_recorded)
  end

  def set_step
    @step = Step.find(params[:id])
  end
end
