class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  # GET /items
  # GET /items.json
  def index
    @items = Item.all.page(params[:page]).per(9)
    @item = Item.new
    @filtered_data = Array.new
  end

  # GET /items/1
  # GET /items/1.json
  def show
  end

  # GET /items/new
  def new
    @item = Item.new
  end

  # GET /items/1/edit
  def edit
    authorize @item
  end

  # POST /items
  # POST /items.json
  def create

    user_id = current_user.id
    @item = Item.new(item_params)

    respond_to do |format|
      if @item.save
        format.html { redirect_to @item, notice: 'Item was successfully created.' }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    respond_to do |format|
      authorize @item
      if @item.update(item_params)
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    authorize @item
    @item.destroy
    respond_to do |format|
      format.html { redirect_to items_url, notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # post /items/filter
  def filter
    @item_categories = ['Books', 'Movie']
    @filter_key = 'Books'
    @filtered_data = Array.new
    respond_to do |format|
        Item.all.each do |item|
          if('Books' == item.category)
            @filtered_data << item
            format.html { redirect_to items_url, notice: 'filtered data'}
            # format.json {render json: @items}
            format.js
          else
            format.html
            format.js
          end
        end
    end
  end


  def search
  @items = Item.search do
    keywords params[:query]
  end.results

  respond_to do |format|
    format.html { render action: 'index' }
    format.json { render json: @items }
  end
end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:title, :price, :category, :description, :status, :image, :email, :phone_number, :location, :user_id)
    end
end
