class CreatorsController < ApplicationController
  before_action :set_creator, only: [:show, :update, :destroy]

  # GET /creators
  def index
    @creators = Creator.all

    render json: @creators
  end

  # GET /creators/1
  def show
    render json: @creator
  end

  # POST /creators
  # POST /works/:id/creators
  def create
    @creator = Creator.new(creator_params)
    assign_work

    if @creator.save
      render json: @creator, status: :created, location: @creator
    else
      render json: @creator.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /creators/1
  def update
    if @creator.update(creator_params)
      render json: @creator
    else
      render json: @creator.errors, status: :unprocessable_entity
    end
  end

  # DELETE /creators/1
  def destroy
    @creator.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_creator
    @creator = Creator.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def creator_params
    params.require(:creator).permit(:name)
  end

  def assign_work
    work_id = params[:work_id]
    return unless work_id

    @creator.works << Work.find(work_id)
  end
end
