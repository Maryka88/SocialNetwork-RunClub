class UsersController < ApplicationController

  # controlla se l'utente è loggato per funz di modifica
  before_filter :signed_in_user, only: [:edit, :update]
  # controlla se utente modifica proprio profilo (può mod solo il proprio)
  before_filter :correct_user, only: [:edit, :update]

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
       flash[:success] = 'Benvenuto nel SocialNetwork di Maryka!'
       # login automatico ut
       sign_in @user
       # salvataggio ok redirect su profilo
       redirect_to @user
    else
       # problema e redirect su registrazione
       render 'new'
    end
  end

  def edit
    # utente trovato tramite dati passati da form
    #@user = User.find(params[:id])

    #volutamente lasciato vuoto dal momento che il metodo correct_user (chiamato da before_filter) inizializza l'oggetto @user
  end

  def update
    # utente trovato tramite dati passati da form
    #@user = User.find(params[:id])

    #volutamente lasciato vuoto dal momento che il metodo correct_user (chiamato da before_filter) inizializza l'oggetto @user

    # se aggiornamento ok
    if @user.update_attributes(params[:user])
           # messaggio di conferma
           flash[:success] = 'Profilo aggiornato'
           # re-login
           sign_in @user
           # redirect a profilo
           redirect_to @user
    else
           # aggiornamento non riuscito
           render 'edit'
    end
  end

  private

  # redirect a pagina di login se l'utente non è loggato
  def signed_in_user
    redirect_to signin_url, notice: "Fai il login" unless signed_in?
    # notice: "Fai il login" è uguale a flash[:notice] = "Fai il login"
  end

  # redirect a home se l'utente corrente non è quello "giusto"
  def correct_user
    # inizializza l'oggetto @user (tolto da funz edit e update)
    @user = User.find(params[:id])
    redirect_to root_path unless current_user?(@user) # il met current_user?(user)è definito nel SessionsHelper
  end

end
