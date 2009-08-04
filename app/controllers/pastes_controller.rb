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
      format.xml  { render :xml => @pastes }
    end
  end

  # GET /pastes/1
  # GET /pastes/1.xml
  def show
    @paste = Paste.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @paste }
      format.text { render :text => @paste.code }
    end
  end

  # GET /pastes/new
  # GET /pastes/new.xml
  def new
    @paste = Paste.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @paste }
    end
  end

  # GET /pastes/1/edit
  def edit
    @paste = Paste.find(params[:id])
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
        format.xml { 
          render :xml => @paste.errors, :status => :unprocessable_entity 
        }
      else
        if @paste.save
          format.html { redirect_to(@paste) }
          format.xml  { render :xml => @paste, :status => :created, :location => @paste }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @paste.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # PUT /pastes/1
  # PUT /pastes/1.xml
  def update
    @paste = Paste.find(params[:id])

    respond_to do |format|
      if @paste.update_attributes(params[:paste])
        format.html { redirect_to(@paste) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @paste.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /pastes/1
  # DELETE /pastes/1.xml
  def destroy
    @paste = Paste.find(params[:id])
    @paste.destroy

    respond_to do |format|
      format.html { redirect_to(pastes_url) }
      format.xml  { head :ok }
    end
  end
end