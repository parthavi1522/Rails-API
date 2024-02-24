class V1::EmployeesController < ApplicationController
  before_action :set_employee, only: [:show, :update, :destroy]

  def index
    @employees = Employee.includes(:department)
    render json: @employees.to_json(include: :department), status: :ok
  end

  def create
    @employee = Employee.new(employee_params)

    if @employee.save
      render json: @employee, status: :created
    else
      render json: @employee.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: @employee.to_json(include: [:department, :country])
  end

  def update
    if @employee.update(employee_params)
      render json: @employee
    else
      render json: @employee.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @employee.destroy
    render json: { message: "Employee deleted successfully." }
  end

  private

  def set_employee
    @employee = Employee.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Employee not found' }, status: :not_found
  end

  def employee_params
    params.require(:employee).permit(:first_name, :last_name, :has_passport, :salary, :gender, :email, :phone_number, :birth_date, :hiring_date, :notes, :department_id, :country_id)
  end
end
