class WelcomeController < ApplicationController
  def index
    cookies[:curso] = "Curso de Ruby on Rails - Jackson Pires [COOKIES]"
    session[:curso] = "Curso de Ruby on Rails - Jackson Pires [SESSION]"
    @meu_nome = params[:nome]
    @curso = params[:curso]
  end
end
