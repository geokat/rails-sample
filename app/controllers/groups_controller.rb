class GroupsController < ApplicationController
  before_action :set_group, only: [:edit, :update, :destroy]
  after_action :handle_jsonp, only: :show
  around_action :catch_errors_for_jsonp, only: :show

  # GET /groups
  # GET /groups.json
  def index
    @groups = Group.all
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
    # We call set_group() here instead of before_action because we
    # want it wrapped in around_action, so that any exceptions that it
    # may generate are also caught (for JSONP calls).
    set_group
  end

  # GET /groups/new
  def new
    @group = Group.new
  end

  # GET /groups/1/edit
  def edit
  end

  # POST /groups
  # POST /groups.json
  def create
    @group = Group.new(group_params)

    respond_to do |format|
      if @group.save
        format.html { redirect_to @group, notice: 'Group was successfully created.' }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /groups/1
  # PATCH/PUT /groups/1.json
  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group.destroy
    respond_to do |format|
      format.html { redirect_to groups_url, notice: 'Group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between
    # actions.
    def set_group
      @group = Group.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the
    # white list through.
    def group_params
      params.require(:group).permit(:name, :balance, :private)
    end

    def handle_jsonp
      return unless request.format == :json and params[:callback]
      response['Content-Type'] = 'application/javascript'
      response.body = "#{params[:callback]}(#{response.body});"
    end

    def catch_errors_for_jsonp
      if request.format != :json or not params[:callback]
        # We only wrap JSONP calls; bail out.
        yield
        return
      end

      begin
        yield
      rescue ActiveRecord::RecordNotFound => e
        render json: {status: :not_found, error: e.message}, status: :ok
      rescue
        render json: {status: :internal_server_error, error: 'Unknown error'}, status: :ok
      end
    end
end
