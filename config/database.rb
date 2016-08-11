
configure :development do
  ActiveRecord::Base.logger = Logger.new(STDOUT)
end

configure :development, :test do
  # set :database, {
  #   'development' => {
  #     'adapter' => 'sqlite3',
  #     'database' => APP_ROOT.join('db', 'development.sqlite3')
  #   },
  #   'test' => {
  #     'adapter' => 'sqlite3',
  #     'database' => APP_ROOT.join('db', 'test.sqlite3')
  #   }
  # }
  # db = URI.parse(ENV['DATABASE_URL'] || 'postgres://localhost/mydb')

  ActiveRecord::Base.establish_connection(
      :adapter => 'postgresql',
      # :host     => 'localhost',
      # :username => 'development',
      # :password => 'development',
      # :database => 'pokemontradeapp',
      :host     => 'ec2-54-243-54-56.compute-1.amazonaws.com',
      :username => 'pyvghtrvcebxnb',
      :password => 'Zna3ItnXeCAJa0h2qXTSDUn38U',
      :database => 'd67be7i3k94hmh',
      :encoding => 'utf8'
  )

end

configure :production do
  # Database connection is configured automatically based on the DATABASE_URL
  # environment variable. This is a feature of sinatra/activerecord support.
  #
  # If you're deploying to Heroku this will be set automatically.
end

configure do
  # Load all models from app/models, using autoload instead of require
  # See http://www.rubyinside.com/ruby-techniques-revealed-autoload-1652.html
  Dir[APP_ROOT.join('app', 'models', '*.rb')].each do |model_file|
    filename = File.basename(model_file).gsub('.rb', '')
    autoload ActiveSupport::Inflector.camelize(filename), model_file
  end
end
