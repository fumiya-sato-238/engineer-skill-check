class EmployeesController < ApplicationController
  before_action :set_employee, only: %i(edit update destroy)
  before_action :set_form_option, only: %i(new create edit update)

  def index
    @employees = Employee.active.order("#{sort_column} #{sort_direction}")
  end

  def new
    @employee = Employee.new
  end

  def create
    @employee = Employee.new(employee_params)

    #不要になったので削除
    #add_params

    if @employee.save
      redirect_to employees_url, notice: "社員「#{@employee.last_name} #{@employee.first_name}」を登録しました。"
    else
      render :new
    end
  end

  def edit
  end

  def update
    #不要になったので削除
    #add_params

    if @employee.update(employee_params)
      redirect_to employees_url, notice: "社員「#{@employee.last_name} #{@employee.first_name}」を更新しました。"
    else
      render :edit
    end
  end

  def destroy
    ActiveRecord::Base.transaction do
      now = Time.now
      @employee.update_column(:deleted_at, now)
      @employee.profiles.active.first.update_column(:deleted_at, now) if @employee.profiles.active.present?
    end

    redirect_to employees_url, notice: "社員「#{@employee.last_name} #{@employee.first_name}」を削除しました。"
  end

  private

  #email,date_of_joining,news_post_authを追加
  def employee_params
    params.require(:employee).permit(:number, :last_name, :first_name, :account, :password, :email, :date_of_joining, :department_id, :office_id, :employee_info_manage_auth, :news_post_auth)
  end

  def set_employee
    @employee = Employee.find(params["id"])
  end

  def set_form_option
    @departments = Department.all
    @offices = Office.all
  end

  # 現在、メールアドレスと入社日は入力できないため、ここで追加しています。
  #入力フォームを追加したので不要
  # def add_params
  #   unless @employee.email
  #     @employee.email = 'sample@example.com'
  #   end
  #   unless @employee.date_of_joining
  #     @employee.date_of_joining = Date.today
  #   end
  # end

  def sort_column
    params[:sort] ? params[:sort] : 'number'
  end

  def sort_direction
    params[:direction] ? params[:direction] : 'asc'
  end

end
