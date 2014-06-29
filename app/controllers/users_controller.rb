class UsersController < ApplicationController

  def show
    #prendo utente dall'id :id
    @user = User.find(params[:id])
  end

  def new
    #creo utente base per testing - poi da rimuovere
    #@user = User.create(name: 'Marika', email: 'marika.pinori@polito.it', password: 'test0123', password_confirmation: 'test0123')
    #@user = User.create(name: 'Luigi', email: 'luigi.derussis@polito.it', password: 'prova123', password_confirmation: 'prova123')

    #inizializzo la variabile da utilizzare nel form di registrazione
    @user = User.new
  end

  def create
    # utente creato tramite dati passati da form
    @user = User.new(params[:user])
    if @user.save
       # messaggio di benvenuto al salvataggio
       flash[:success] = 'Benvenuto nel SNS di Maryka!'
       # salvataggio ok redirect su profilo
       redirect_to @user
    else
       # problema e redirect su registrazione
       render 'new'
    end
  end

end
