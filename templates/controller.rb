class <%= controller_class_name %>Controller < ApplicationController
  # GET /<%= file_name %>
  def index
    @<%= controller_singular_name.downcase %> = <%= controller_singular_name %>.find(:all)
  end

  # GET /<%= file_name %>/1
  def show
    @<%= controller_singular_name.downcase %> = <%= controller_singular_name %>.find(params[:id])
  end

  # GET /<%= file_name %>/new
  def new
    @<%= controller_singular_name.downcase %> = <%= controller_singular_name %>.new
  end

  # GET /<%= file_name %>/1/edit
  def edit
    @<%= controller_singular_name.downcase %> = <%= controller_singular_name %>.find(params[:id])
  end

  # POST /<%= file_name %>
  def create
    @<%= controller_singular_name.downcase %> = <%= controller_singular_name %>.new(params[:<%= controller_singular_name.downcase %>])

    if @<%= controller_singular_name.downcase %>.save
      flash[:notice] = '<%= controller_singular_name %> was successfully created.'
      redirect_to([:admin, @<%= controller_singular_name.downcase %>])
    else
      render :action => "new"
    end
  end

  # PUT /<%= file_name %>/1
  def update
    @<%= controller_singular_name.downcase %> = <%= controller_singular_name %>.find(params[:id])

    if @<%= controller_singular_name.downcase %>.update_attributes(params[:<%= controller_singular_name.downcase %>])
      flash[:notice] = '<%= controller_singular_name %> was successfully updated.'
      redirect_to([:admin, @<%= controller_singular_name.downcase %>])
    else
      render :action => "edit"
    end
  end

  # DELETE /<%= file_name %>/1
  def destroy
    @<%= file_name %> = <%= controller_singular_name %>.find(params[:id])
    @<%= file_name %>.destroy

    redirect_to(<%= table_name %>_url)
  end
end
