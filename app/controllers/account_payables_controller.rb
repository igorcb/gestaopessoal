class AccountPayablesController < ApplicationController
  before_action :set_account_payable, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @account_payables = AccountPayable.all
    respond_with(@account_payables)
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

  private
    def set_account_payable
      @account_payable = AccountPayable.find(params[:id])
    end

    def account_payable_params
      params.require(:account_payable).permit(:person_id, :cost_center_id, :sub_cost_center_id, :sub_cost_center_three_id, :data_vencimento, :documento, :valor, :obs, :status)
    end
end
