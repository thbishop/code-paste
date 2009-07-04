class ParsersController < ApplicationController
  # GET /parsers
  # GET /parsers.xml
  def index
    @parsers = Parser.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @parsers }
    end
  end

  # GET /parsers/1
  # GET /parsers/1.xml
  def show
    @parser = Parser.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @parser }
    end
  end

  # GET /parsers/new
  # GET /parsers/new.xml
  def new
    @parser = Parser.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @parser }
    end
  end

  # GET /parsers/1/edit
  def edit
    @parser = Parser.find(params[:id])
  end

  # POST /parsers
  # POST /parsers.xml
  def create
    @parser = Parser.new(params[:parser])

    respond_to do |format|
      if @parser.save
        flash[:notice] = 'Parser was successfully created.'
        format.html { redirect_to(@parser) }
        format.xml  { render :xml => @parser, :status => :created, :location => @parser }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @parser.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /parsers/1
  # PUT /parsers/1.xml
  def update
    @parser = Parser.find(params[:id])

    respond_to do |format|
      if @parser.update_attributes(params[:parser])
        flash[:notice] = 'Parser was successfully updated.'
        format.html { redirect_to(@parser) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @parser.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /parsers/1
  # DELETE /parsers/1.xml
  def destroy
    @parser = Parser.find(params[:id])
    @parser.destroy

    respond_to do |format|
      format.html { redirect_to(parsers_url) }
      format.xml  { head :ok }
    end
  end
end
