class TodosController < ApplicationController

  before_action :set_todo, only: [:show, :update, :destroy]

  def index
    @todos = @current_user.todos
    json_response(@todos)
  end

  def create
    @todo = current_user.todos.create!(todo_params)
    json_response(@todo, :created)
  end

  def show
    json_response(@todo)
  end

  def update
    @todo.update!(todo_params)
    head :no_content
  end

  def destroy
    @todo.destroy
    head :no_content
  end

  private

    def todo_params
      # Whitelist parameters. 
      params.permit(:id, :title)
    end

    def set_todo
      p = params.permit(:id)
      p = p['id']
      @todo = Todo.find(p.to_i)
    end

end
