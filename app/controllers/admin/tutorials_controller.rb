class Admin::TutorialsController < Admin::BaseController
  def edit
    @tutorial = Tutorial.find(params[:id])
  end

  def create
    @tutorial = Tutorial.create(tutorial_create_params)
    flash[:success] = "Successfully created tutorial." if @tutorial.save
    redirect_to tutorial_path(@tutorial)
  end

  def new
    @tutorial = Tutorial.new
  end

  def update
    tutorial = Tutorial.find(params[:id])
    if tutorial.update(tutorial_params)
      flash[:success] = "#{tutorial.title} tagged!"
    end
    redirect_to edit_admin_tutorial_path(tutorial)
  end

  def destroy
    tutorial = Tutorial.find(params[:id])
    flash[:success] = "#{tutorial.title} tagged!" if tutorial.destroy
    redirect_to admin_dashboard_path
  end

  private

  def tutorial_create_params
    params.require(:tutorial).permit(:title, :description, :thumbnail)
  end

  def tutorial_params
    params.require(:tutorial).permit(:tag_list)
  end
end
