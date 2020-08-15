class StepsController < ApplicationController
  before_action :set_step, only: %i[show update destroy]

  # GET /todos
  def index
    @steps = current_user.steps
    json_response(@steps)
  end

  # POST /todos
  def create
    @step = current_user.steps.create!(step_params)
    json_response(@step, :created)
  end

  # GET /todos/:id
  def show
    json_response(@step)
  end

  # PUT /todos/:id
  def update
    @step.update(step_params)
    head :no_content
  end

  # DELETE /todos/:id
  def destroy
    @step.destroy
    head :no_content
  end

  private

  def step_params
    # whitelist params
    params.permit(:title, :day_recorded)
  end

  def set_step
    @step = Step.find(params[:id])
  end
end
