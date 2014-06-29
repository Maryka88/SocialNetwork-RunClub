class SessionsController < ApplicationController
  def new
    # non serve passare dati al form
  end

  def create
    # ricavo utente da email inserita nel form
    user = User.find_by_email(params[:session][:email].downcase)
    # controllo se l'utente esiste e se la password è corretta
     if user && user.authenticate(params[:session][:password])
           # login ok
           sign_in user # sign in  del SessionsHelper
           redirect_to user # redirect a profilo utente (redirect_to user_path(user))
     else
           # mostro errori login con flash.now
           flash.now[:danger] = 'L\'indirizzo di posta elettronica o la password immessi non sono validi. Riprova'
           # torno alla pagina di login
           render 'new'
     end
  end

  def destroy
  end

end
