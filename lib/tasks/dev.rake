namespace :dev do

  #Task para configurar o ambiente de desenvolvimento (dev:setup)
  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
    if Rails.env.development?
      show_spinner("Apagando BD...", "Concluido!") { %x(rails db:drop) }
      show_spinner("Criando BD...", "Concluido!") { %x(rails db:create) }
      show_spinner("Migrando BD...", "Concluido!") { %x(rails db:migrate) }
      %x(rails dev:add_coins) 
      %x(rails dev:add_mining_types) 
    else
      puts "Você não está em modo de desenvolvimento"
    end
  end


  #Task para cadastrar as moedas (dev:add_coins)
  desc "Cadastra as moedas"
  task add_coins: :environment do
    show_spinner("Cadastrando Moedas") do
      coins = [
          {
              description: "Bitcoin",
              acronym: "BTC",
              url_image: "https://toppng.com/uploads/preview/bitcoin-png-bitcoin-logo-transparent-background-11562933997uxok6gcqjp.png"
          },
          {
              description: "Ethereum",
              acronym: "DASH",
              url_image: "https://img2.gratispng.com/20180411/gwq/kisspng-ethereum-blockchains-digital-assets-smart-contr-blockchain-5ace40c3acb1a6.6050038115234664357074.jpg"
          },
          {
              description: "Dash",
              acronym: "ETH",
              url_image: "https://i.ya-webdesign.com/images/dash-coin-png-4.png"
          },
          {
              description: "Iota",
              acronym: "IOT",
              url_image: "https://img2.gratispng.com/20180712/tkc/kisspng-iota-cryptocurrency-logo-internet-of-things-tether-aren-5b481f06b57ae1.5360095415314531907434.jpg"
          },
          {
              description: "Zcash",
              acronym: "ZEC",
              url_image: "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRZcYBoy7rwMspi8xD44k5_ADVpSKknaVwCvjY9yHuBeKzkcZNS&usqp=CAU" 
          }
      ]

      coins.each do |coin| 
          Coin.find_or_create_by!(coin)
      end
    end
  end


  #Task para cadastrar os tipos de mineração (dev:add_mining_types)
  desc "Cadastra os tipos de mineração"
  task add_mining_types: :environment do
    show_spinner("Cadastrando tipos de mineração") do
      mining_types = [
        {description: "Proof of Work", acronym: "PoW"},
        {description: "Proof of Stake", acronym: "PoS"},
        {description: "Proof of Capacity", acronym: "PoC"}
      ]

      mining_types.each do |mining_type| 
        MiningType.find_or_create_by!(mining_type)
      end
    end
  end

  private
  def show_spinner(msg_start, msg_end = "Concluído")
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
    spinner.auto_spin
    yield
    spinner.success("(#{msg_end})")
  end

end
