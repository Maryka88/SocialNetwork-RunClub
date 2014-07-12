class MessagesController < ApplicationController
  # controllo se l'utente è loggato
  before_filter :signed_in_user

  # controllo se l'utente può cancellare il messaggio
  before_filter :correct_user, only: :destroy

  # solo l'azione new risponde al javascript
  respond_to :js, only: :new

  def new
   # prendo utente destinatario
   @user = User.find(params[:user])
   # creo un nuovo messaggio
   @message = Message.new

   # rispondo a un messaggio esistente
   unless params[:message].nil?
       # prendo il messaggio
       subject = Message.find(params[:message]).subject
       # imposto il soggetto dle messaggio di risposta
       @message.subject = "Re: #{subject}"
       end

   respond_with @user, @message
  end

  def create
   # costruisco un nuovo messaggio in base alle informazioni ricevute dal form che lo crea
   # in questo caso non si può usare il create per alcune scelte e impostazioni della gemma simple-private-messages
   @message = Message.new
   @message.subject = params[:message][:subject]
   @message.body = params[:message][:body]
   @message.sender = User.find(params[:message][:sender])
   recipient = User.find(params[:message][:recipient])
   @message.recipient = recipient

    if @message.save
       flash[:success] = "Messaggio inviato a #{recipient.name}!"
       redirect_to root_url
    else
       render 'pages/home'
    end
  end

  def destroy
   # un messaggio viene cancellato in modo diverso da un messaggio ricevuto
    if current_user.received_messages.find_by_id(@message.id).nil?
       # il messaggio è stato inviato dall'utente
       @message.mark_deleted
    else
       # il messaggio è stato ricevuto
       @message.mark_deleted(current_user)
    end
    redirect_to current_user
  end

  private

  def correct_user
   # l'utente ha ricevuto un messaggio con l'id fornito?
   @message = current_user.received_messages.find_by_id(params[:id])
   # l'utente ha inviato un messaggio con l'id fornito?
   @message = current_user.sent_messages.find_by_id(params[:id]) if @message.nil?
   # se no, redirect a homepage
   redirect_to root_url if @message.nil?
   end
end
