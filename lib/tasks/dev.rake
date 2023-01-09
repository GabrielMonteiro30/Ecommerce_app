namespace :dev do
  
  DEFAULT_PASSWORD = 123456
  
  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
    if Rails.env.development?
      show_spinner("Apagando BD...") { %x(rails db:drop) }
      show_spinner("Craindo BD...") { %x(rails db:create)  }
      show_spinner("Migrando BD...") { %x(rails db:migrate) }
      show_spinner("Cadastrando o Administrador Ṕadrão ...") { %x(rails dev:add_default_admin) }
      show_spinner("Cadastrando o Usuário Ṕadrão ...") { %x(rails dev:add_default_user) }
      %x(rails dev:add_clients)
      %x(rails dev:add_products)
      %x(rails dev:add_sales)

    else
      puts "Você está em ambiente  de desenvolvimento!"
    end
  end
  
  desc "Cadastro dos clientes"
  task add_clients: :environment do
    show_spinner("Cadastrando clientes...") do
      
      @client_01 = Client.create(name: "Gabriel Monteiro", email: "gabriel@gabriel.com")
      @client_02 = Client.create(name: "Gearlem Camargo", email: "gearlem@gearlem.com")
      @client_03 = Client.create(name: "Cayo Rodrigues", email: "cayo@cayo.com")
    end
  end 
  
  desc "Cadastro dos produtos"
  task add_products: :environment do
    show_spinner("Cadastrando produtos...") do 
      
      @product_01 = Product.create(name: "Micro-ondas", description: "Micro-ondas 20 litros da Electrolux", price: "493,05")
      @product_02 = Product.create(name: "Geladeira", description: "Refrigerador Brastemp Frost Free Duplex", price: "2859,00")
      @product_03 = Product.create(name: "Fogão", description: "Com piso Brastemp 5 bocas Preto", price: "2195,10")
    end
  end
  
  desc "Cadastro das vendas"
  task add_sales: :environment do
    show_spinner("Cadastrando as vendas...") do 
      
      @sale_01 = Sale.create(client Client find_by_name: "Gabriel Monteiro")
      @sale_02 = Sale.create(client Client find_by_name: "Gearlem Camargo")
      @sale_03 = Sale.create(client Client find_by_name: "Cayo Rodrigues")  
      
    end
  end
  
  desc "Adiciona o administrador padrão"
  task add_default_admin: :environment do 
    Admin.create!(
      email: 'admin@admins.com.br',
      password: DEFAULT_PASSWORD,
      password_confirmation: DEFAULT_PASSWORD
    )
  end
  
  desc "Adiciona o usuário padrão"
  task add_default_user: :environment do 
    User.create!(
      email: 'user@user.com',
      password: DEFAULT_PASSWORD,
      password_confirmation: DEFAULT_PASSWORD
    )
  end
  
  private 
  
  def show_spinner(msg_start, msg_end = "Concluído")
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
    spinner.auto_spin
    yield
    spinner.success("(#{msg_end})")
  end
end
