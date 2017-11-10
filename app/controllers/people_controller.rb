class PeopleController < ApplicationController
  before_action :set_person, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @people = Person.all
    respond_with(@people)
  end

  def show
    respond_with(@person)
  end

  def new
    @person = Person.new
    respond_with(@person)
  end

  def edit
  end

  def create
    @person = Person.new(person_params)
    @person.save
    respond_with(@person)
  end

  def update
    @person.update(person_params)
    respond_with(@person)
  end

  def destroy
    @person.destroy
    respond_with(@person)
  end

  private
    def set_person
      @person = Person.find(params[:id])
    end

    def person_params
      params.require(:person).permit(:tipo_pessoa, :cpf_cnpj, :nome, :endereco, :numero, :complemento, :bairro,
        :cidade, :estado, :cep, :observacao, 
        assets_attributes: [:asset, :id, :_destroy],
        emails_attributes: [:sector_id, :email, :contato, :observation, :id, :_destroy],
        contacts_attributes: [:contact, :tipo, :nome, :fone, :complemento, :id, :_destroy],
        account_banks_attributes: [:bank_id, :agencia, :conta, :tipo,:favorecido, :cpf_cnpj, :observation, :id, :_destroy]
      
        )
    end
end
