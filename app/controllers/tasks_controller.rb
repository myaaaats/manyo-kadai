class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  #before_action :own_task?, only: [:show, :edit, :update, :destroy]

  def index
    if params[:sort_expired]
      @tasks = Task.limit_order
    elsif params[:search]
      case params[:status_search]
      when "yet" then
        puts "yet"
        @tasks = Task.where(status: "未着手")
      when "start" then
        puts "start"
        @tasks = Task.where(status: "着手中")
      when "complete" then
        puts "comp"
        @tasks = Task.where(status: "完了")
      else
        puts "else"
        @tasks = Task.all.order(created_at: :desc)
      end
      unless params[:title_search].blank?
        puts "titlesearch"
        @tasks = Task.where("title Like ?", "%#{params[:title_search]}%")
      end
    else
      puts "other"
      @tasks = Task.desc_order
    end
    @tasks = @tasks.page(params[:page]).per(10)
  end

  def new
    if params[:back]
      @task = Task.new(task_params)
    else
      @task = Task.new
    end
  end

  def create
    @task = Task.create(task_params)
    if @task.save
      redirect_to tasks_path, notice: "タスクを作成しました！"
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: "タスクを編集しました！"
    else
      render 'edit'
    end
  end

  def destroy
    @task.destroy
    params[:id] == "delete"
    redirect_to tasks_path, notice:"タスクを削除しました！"
  end

  def confirm
    @task = Task.new(task_params)
    render :new if @task.invalid?
  end

  private

  def task_params
    params.require(:task).permit(:title, :content, :limit, :status, :priority)
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def own_task?
    if @task.user_id != current_user.id
      redirect_to root_path
    end
  end
end
