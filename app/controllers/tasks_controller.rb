class TasksController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:edit, :update, :destroy]
  
  def index
    @tasks = Task.all.page(params[:page])
  end
  
  def new
    @task = Task.new
  end
  
  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:success] = 'メッセージを投稿しました。'
      redirect_to root_url
    else
      @tasks = current_user.tasks.order('created_at DESC').page(params[:page])
      flash.now[:danger] = 'メッセージの投稿に失敗しました。'
      render 'toppages/index'
    end 
  end
  
  def destroy
    @task.destroy
    
    flash[:success] = 'メッセージを削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  def edit
    
  end
  
  def update
    
    if @task.update(task_params)
      flash[:success] = "更新しました"
      redirect_to root_url
    else
      flash[:error] = "更新できませんでした"
      render :edit
    end
  end  
    
  private
  
  def task_params
    params.require(:task).permit(:content, :status)
  end
  
  def correct_user
    @task = Task.find(params[:id])
    if (current_user != @task.user)
      redirect_to root_url
    end
  end
end
