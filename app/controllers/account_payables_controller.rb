class AccountPayablesController < ApplicationController
  before_action :set_account_payable, only: [:show, :edit, :update, :destroy, :lower, :pay]

  respond_to :html

  def index
    @q = AccountPayable.where(status: -1).search(params[:q])
    @account_payables = AccountPayable.all
    #respond_with(@account_payables)
  end

  def show
    respond_with(@account_payable)
  end

  def new
    @account_payable = AccountPayable.new
    respond_with(@account_payable)
  end

  def edit
  end

  def create
    @account_payable = AccountPayable.new(account_payable_params)
    @account_payable.save
    respond_with(@account_payable)
  end

  def update
    @account_payable.update(account_payable_params)
    respond_with(@account_payable)
  end

  def destroy
    @account_payable.destroy
    respond_with(@account_payable)
  end
  
  def lower
    @account_banks = AccountBank.order(:nome)
  end

  def pay
    if !params[:lower_payables][:account_bank_id].present?
      flash[:danger] = "Conta Corrente can't be blank."
      redirect_to lower_account_payable_path(params[:id])
      return 
    elsif !params[:lower_payables][:data_pagamento].present?
      flash[:danger] = "Data Pagamento can't be blank."
      redirect_to lower_account_payable_path(params[:id])
      return 
    elsif !params[:lower_payables][:valor_pago].present?
      flash[:danger] = "Valor do Pagamento can't be blank."
      redirect_to lower_account_payable_path(params[:id])
      return
    end

    respond_to do |format|
      if @account_payable.payament(params[:lower_payables])
        format.html { redirect_to @account_payable, flash: { success: "Lower AccountsPayable was successful." } }
        #format.json { render action: 'show', status: :created, location: @account_payable }
      else
        format.html { redirect_to @account_payable, flash: { danger: "Could not lower accounts payable was successful." }}
        format.json { render json: @account_payable.errors, status: :unprocessable_entity }
      end
    end

  end

  def pay_all
    if !params[:account_bank][:account_bank_id].present?
      flash[:danger] = "Conta Corrente can't be blank."
      redirect_to lower_all_payables_path
      return 
    end

    AccountPayable.payament_all(params[:os][:ids], params[:valor_total], params[:account_bank][:account_bank_id])
    flash[:success] = "Contas pagas com sucesso."
    redirect_to lower_all_payables_path    
  end

  def lower_all_payables
    @q = AccountPayable.where(status: AccountPayable::TypeStatus::ABERTO).search(params[:q])
    @account_payables = @q.result
#    @employees = Employee.order('nome')
  end

  def part
    @people = Person.order(:nome)
    @cost_centers = CostCenter.order(:nome)
    @sub_cost_centers = SubCostCenter.where(id: -1)
    @sub_cost_center_threes = SubCostCenterThree.where(id: -1)
  end

  def part_payment
    AccountPayable.generate_parts(params)
    redirect_to account_payables_path
  end

  def search
    @q = AccountPayable.order('data_vencimento desc').search(params[:q])
    @account_payables = @q.result
  end

  private
    def set_account_payable
      @account_payable = AccountPayable.find(params[:id])
    end

    def account_payable_params
      params.require(:account_payable).permit(:person_id, :cost_center_id, :sub_cost_center_id, :sub_cost_center_three_id, :date_purchase, :data_vencimento, :documento, :valor, :obs, :status,
        lower_payables: [:account_bank_id, :data_pagamento, :valor_pago, :juros, :desconto, :total_pago]
        )
    end
end
