class TasksController < ApplicationController
	before_action :set_catagory
	before_action :check_user, only: [:index, :sort, :update_status]

  def index
  	@tasks = @catagory.tasks.order(:position)
  end

  def new
  	@task = Task.new
  end

  def create
  	@task = @catagory.tasks.new(task_params)
  	if @task.save
  		redirect_to catagory_tasks_path(@catagory), flash: {success: "Task added successfully"}
  	else
  		flash_now!(:error => @task.errors.full_messages.join(', '))
			render ("new")
  	end
  end

  def sort
  	params[:task].each_with_index do |id, index|
  		Task.where(id: id).update_all(position: index+1)
  	end
  	render json: {
  		result: 'ok'
  	}
  end

  def update_status
  	@task = Task.find(params[:task_id])
  	if @task.user == current_user
	  	if @task.update(status: 'completed')
	  		render json: {
	  			success: true
	  		}
	  	else
	  		render json: {
	  			success: false,
	  			error: @task.errors.full_messages.join(', ')
	  		}
	  	end
	  else
	  	render json: {
	  			success: false,
	  			error: "Unauthorised Access"
	  		}
	  end
  end


  private

  def set_catagory
  	@catagory = Catagory.find(params[:catagory_id])
  end

   def check_user
  	unless @catagory.user == current_user
  		redirect_to catagories_path, flash: {error: "Unauthoried Access"}
  	end
  end

  def task_params
  	params.require(:task).permit(:name, :due_date)
  end
end
