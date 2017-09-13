class AccountReceivablesController < ApplicationController
  before_action :set_account_receivable, only: [:show, :edit, :update, :destroy, :lower, :pay]

  respond_to :html

  def index
    @account_receivables = AccountReceivable.all
    respond_with(@account_receivables)
  end

  def show
    respond_with(@account_receivable)
  end

  def new
    @account_receivable = AccountReceivable.new
    respond_with(@account_receivable)
  end

  def edit
  end

  def create
    @account_receivable = AccountReceivable.new(account_receivable_params)
    @account_receivable.save
    respond_with(@account_receivable)
  end

  def update
    @account_receivable.update(account_receivable_params)
    respond_with(@account_receivable)
  end

  def destroy
    @account_receivable.destroy
    respond_with(@account_receivable)
  end

  def lower
    @account_banks = AccountBank.order(:nome)
  end

 def pay
    if !params[:lower_receivables][:account_bank_id].present?
      flash[:danger] = "Conta Corrente can't be blank."
      redirect_to lower_account_receivable_path(params[:id])
      return 
    elsif !params[:lower_receivables][:data_pagamento].present?
      flash[:danger] = "Data Pagamento can't be blank."
      redirect_to lower_account_receivable_path(params[:id])
      return 
    elsif !params[:lower_receivables][:valor_pago].present?
      flash[:danger] = "Valor do Pagamento can't be blank."
      redirect_to lower_account_receivable_path(params[:id])
      return
    end

    respond_to do |format|
      if @account_receivable.payament(params[:lower_receivables])
        format.html { redirect_to @account_receivable, flash: { success: "Lower AccountsPayable was successful." } }
        #format.json { render action: 'show', status: :created, location: @account_payable }
      else
        format.html { redirect_to @account_receivable, flash: { danger: "Could not lower accounts payable was successful." }}
        format.json { render json: @account_receivable.errors, status: :unprocessable_entity }
      end
    end

  end  

  private
    def set_account_receivable
      @account_receivable = AccountReceivable.find(params[:id])
    end

    def account_receivable_params
      params.require(:account_receivable).permit(:person_id, :cost_center_id, :sub_cost_center_id, :sub_cost_center_three_id, :data_vencimento, :documento, :valor, :obs, :status,
        lower_receivables: [:account_bank_id, :data_pagamento, :valor_pago, :juros, :desconto, :total_pago]
        )
    end
end