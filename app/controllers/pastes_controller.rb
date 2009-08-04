class PastesController < ApplicationController
  # GET /pastes
  # GET /pastes.xml
  def index
    @pastes = Paste.paginate :page => params[:page] , :order => 'updated_at DESC', :per_page => 10
    
    logger.debug "found #{@pastes.length} pastes for the index"
    
    @all_pastes_count = Paste.all.length
    @lang_counts = Parser.lang_counts
    @day_count = Paste.count(:conditions => [ 'created_at >= ?', 1.days.ago ])
    @week_count = Paste.count(:conditions => [ 'created_at >= ?', 7.days.ago ])
    @this_month_count = Paste.count(:conditions => [ 'created_at >= ? and created_at <= ?', Time.now.beginning_of_month, Time.now.end_of_month ])
    @last_month_count = Paste.count(:conditions => [ 'created_at >= ? and created_at <= ?', 1.months.ago.beginning_of_month, 1.months.ago.end_of_month ])
    @this_year = Paste.count(:conditions => [ 'created_at >= ? and created_at <= ?', Time.now.beginning_of_year, Time.now.end_of_year ])

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /pastes/1
  # GET /pastes/1.xml
  def show
    @paste = Paste.find_by_id(params[:id])

    respond_to do |format|
      if @paste
        format.html # show.html.erb
        format.text { render :text => @paste.code }
      else
        format.html { response_to_missing_id }
        format.text { response_to_missing_id }
      end
    end
  end

  # GET /pastes/new
  # GET /pastes/new.xml
  def new
    @paste = Paste.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /pastes/1/edit
  def edit
    @paste = Paste.find_by_id(params[:id])
    
    respond_to do |format|
      if @paste
        format.html { render }
      else
        format.html { response_to_missing_id }
      end
    end
  end

  # POST /pastes
  # POST /pastes.xml
  def create
    @paste = Paste.new(params[:paste])

    respond_to do |format|
      if @paste.code.blank?
        format.html { 
          render :action => "new"
        }
      else
        if @paste.save
          format.html { redirect_to(@paste) }
        else
          format.html { render :action => "new" }
        end
      end
    end
  end

  # PUT /pastes/1
  # PUT /pastes/1.xml
  def update
    @paste = Paste.find_by_id(params[:id])

    respond_to do |format|
      if @paste
        if params[:paste].keys.include?('code') && params[:paste]['code'] == ''
          format.html {
            render :action => "edit"
          }
        else
          if @paste.update_attributes(params[:paste])
            format.html { redirect_to(@paste) }
          else
            format.html { render :action => "edit" }
          end
        end
      else
        format.html { response_to_missing_id }
      end
    end
  end

  # DELETE /pastes/1
  # DELETE /pastes/1.xml
  def destroy
    @paste = Paste.find_by_id(params[:id])

    respond_to do |format|
      if @paste
        @paste.destroy
        format.html { redirect_to root_path }
      else
        format.html {
          response_to_missing_id
        }
      end
    end
  end
  
  private
  def response_to_missing_id
    flash[:notice] = "Whoops, it doesn't look like that paste exits.  Perhaps you should just create a new one."
    redirect_to root_path
  end
end