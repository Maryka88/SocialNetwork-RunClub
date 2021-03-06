module SessionsHelper
  # salvo remember token in 1 cookie permanente
  # imposto utente del sign in a utente corrente
  def sign_in(user)
      cookies.permanent[:remember_token] = user.remember_token
      # indico che current_use è un metodo dichiarato e non una variabile
      self.current_user = user # equivale a: self.current_user=(user)
  end

  # imposto ut sign in = ut corrente
  def current_user=(user)
     @current_user = user
  end

  # se current_user è definito prendo ut che corrisponde al remember_token
  def current_user
     @current_user ||= User.find_by_remember_token(cookies[:remember_token])
  end

  # utente signed in ?
  def signed_in?
     !current_user.nil?
  end

  # cancello istanza current user e cookie
  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end

  # controllo se l'utente dato coincide con l'utente corrente (per funz di autorizzazione)
  # user - l'utente per il quale si chiede autorizzazione
  def current_user?(user)
    user == current_user
  end

  # redirect a signi in se utente non loggato
  def signed_in_user
    redirect_to signin_url, notice: "Fai il login" unless signed_in?
    # flash[:notice] = "Please sign in"
  end

end