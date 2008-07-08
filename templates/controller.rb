class <%= controller_class_name %>Controller < ApplicationController
  before_filter :check_access, :except => [:index, :show]
  
  # GET /<%= table_name %>
  def index
    @<%= table_name %> = <%= class_name %>.find(:all)

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /<%= table_name %>/1
  def show
    @<%= file_name %> = <%= class_name %>.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /<%= table_name %>/new
  def new
    @<%= file_name %> = <%= class_name %>.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /<%= table_name %>/1/edit
  def edit
    @<%= file_name %> = <%= class_name %>.find(params[:id])
    
    respond_to do |format|
      format.html # edit.html.erb
    end
  end

  # POST /<%= table_name %>
  def create
    @<%= file_name %> = <%= class_name %>.new(params[:<%= file_name %>])

    respond_to do |format|
      if @<%= file_name %>.save
        flash[:notice] = '<%= class_name %> was successfully created.'
        format.html { redirect_to(@<%= file_name %>) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /<%= table_name %>/1
  def update
    @<%= file_name %> = <%= class_name %>.find(params[:id])

    respond_to do |format|
      if @<%= file_name %>.update_attributes(params[:<%= file_name %>])
        flash[:notice] = '<%= class_name %> was successfully updated.'
        format.html { redirect_to(@<%= file_name %>) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /<%= table_name %>/1
  def destroy
    @<%= file_name %> = <%= class_name %>.find(params[:id])
    @<%= file_name %>.destroy

    respond_to do |format|
      format.html { redirect_to(<%= table_name %>_url) }
    end
  end
end
