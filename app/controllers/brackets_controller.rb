class BracketsController < ApplicationController
  before_action :set_bracket, only: %i[ show edit update destroy ]

  # GET /brackets or /brackets.json
  def index
    @brackets = Bracket.all
  end

  # GET /brackets/1 or /brackets/1.json
  def show
  end

  # GET /brackets/new
  def new
    @bracket = Bracket.new
  end

  # GET /brackets/1/edit
  def edit
  end

  # POST /brackets or /brackets.json
  def create
    @bracket = Bracket.new(bracket_params)

    respond_to do |format|
      if @bracket.save
        format.html { redirect_to @bracket, notice: "Bracket was successfully created." }
        format.json { render :show, status: :created, location: @bracket }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @bracket.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /brackets/1 or /brackets/1.json
  def update
    respond_to do |format|
      if @bracket.update(bracket_params)
        format.html { redirect_to @bracket, notice: "Bracket was successfully updated." }
        format.json { render :show, status: :ok, location: @bracket }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @bracket.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /brackets/1 or /brackets/1.json
  def destroy
    @bracket.destroy
    respond_to do |format|
      format.html { redirect_to brackets_url, notice: "Bracket was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bracket
      @bracket = Bracket.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def bracket_params
      params.require(:bracket).permit(:number_of_entries, :status)
    end
end
