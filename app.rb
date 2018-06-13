# https://github.com/shannonjen/sinatra_crud_tutorial
# https://kodewithklossydet2017.slack.com/messages/G6PGUM5KL/
# https://www.postgresql.org/docs/current/static/app-psql.html
# https://www.postgresql.org/docs/9.1/static/tutorial-select.html
# http://www.postgresqltutorial.com/postgresql-update/
# sudo service postgresql restart
# Dark Green: 339E4C
# Dark Blue: 005ADE
# Green: 2EEE46
# Yellow : FFEB04
# Blue: 54E1FF
# Blue-Green: 1AFBB4
# https://developers.google.com/maps/documentation/geocoding/intro#GeocodingRequests
#  1 | Isabelle Lian | 16  | scoopme123 | 24400 Cavendish Ave W |      |       | novliani07@stu.novik12.org | 2489437718 | ABCD123 | Chevy Cruze | Novi High School | {2}    | 2018-06-08 15:35:18.031563 | 2018-06-08 15:42:43.619754
# #   4 | Sylvia        | 17  | figgywiggy | 24604 Cavendish Ave E |      |       | novweis59@stu.novik12.org  | 2488802194 | ABCD123 | Honda Wonda | Novi High School | {}     | 2018-06-08 15:58:59.238891 | 2018-06-08 15:58:59.238891
# 1 | Sylvia     | 17  | figgywiggy | novweis59@stu.novik12.org  | 2488802194 | Novi High School | {}      | 2018-06-08 15:33:14.193643 | 2018-06-08 15:33:14.193643
#   2 | Linda Weng | 15  | scoopme    | NOVwengl02@stu.novik12.org | 2481234567 | Novi High School | {1}     | 2018-06-08 15:33:25.608984 | 2018-06-08 15:42:43.62595require 'bundler'
Bundler.require
require "sinatra"
require "./modelsDriver.rb"
require "./modelsRider.rb"
require "./modelsFeedback.rb"
require "sinatra/activerecord"
require 'active_record'

class MyApp < Sinatra::Base
    get '/' do
        erb :index
    end
    
    get '/test' do
        erb :riderHome1
    end
    
    get '/driverSignup' do
        erb :driverSignup
    end
    
    get '/riderSignup' do
        erb :riderSignup
    end
    
    get '/driverLogin' do
        erb :driverLogin
    end
    
    get '/riderLogin' do
        erb :riderLogin
    end
    
    post '/feedback' do
        Feedback.create(name: params[:name], email: params[:email], feedback: params[:feedback])
        erb :feedback
    end
    
    get '/riderAccount/:id' do
        @id = params[:id]
        @rider = Rider.find(@id)
        erb :riderAccount
    end
    
    get '/driverAccount/:id' do 
        @id = params[:id]
        @driver = Driver.find(@id)
        erb :driverAccount
    end
    
    get '/riderHome/:id' do
        @id = params[:id]
        @rider = Rider.find(@id)
        @drivers = @rider.drivers
        @name = @rider.name
        @driversAcc = Driver.all
        @driverAddresses = []
        @driversAcc.each do |driver|
            @driverArr = []
            @driverArr.push(driver.name)
            @driverArr.push(driver.address)
            @driverAddresses.push(@driverArr)
        end
        erb :riderHome
    end
    
    get '/driverHome/:id' do
        @id = params[:id]
        @driver = Driver.find(@id)
        @name = @driver.name
        @riders= @driver.riders
        erb :driverHome
    end
    
    post '/driverSignup' do
        @email = params[:email]
        @drivers = Driver.all
        count = 0
        @drivers.each do |driver|
            if driver.email == @email
                count += 1
            end
        end
        if count != 0
            @output = "That email has already been used. Please use a different email."
            erb :driverSignup
        end
        @driver = Driver.create(name: params[:name], age: params[:age], email: params[:email], password: params[:password], address: params[:address], city: params[:city], state: params[:state], phone: params[:phone], plate: params[:plate], car: params[:car], school: params[:school], riders: [])
        @id = @driver.id
        @name = params[:name]
        @age = params[:age]
        @email = params[:email]
        @password = params[:password]
        @phone = params[:phone]
        @address = params[:address]
        @city = params[:city]
        @state = params[:state]
        @plate = params[:plate]
        @school = params[:school]
        @car = params[:car]
        @riders = []
        erb :driverHome
    end
    
    post '/riderSignup' do
        @email = params[:email]
        @riders = Rider.all
        count = 0
        @riders.each do |rider|
            if rider.email == @email
                count += 1
            end
        end
        if count != 0
            @output = "That email has already been used. Please use a different email."
            erb :riderSignup
        end
        @rider = Rider.create(name: params[:name], age: params[:age], email: params[:email], password: params[:password], phone: params[:phone], school: params[:school])
        @id = @rider.id
        @name = params[:name]
        @age = params[:age]
        @email = params[:email]
        @password = params[:password]
        @phone = params[:phone]
        @school = params[:school]
        @drivers = []
        @driversAcc = Driver.all
        @driverAddresses = []
        @driversAcc.each do |driver|
            @driverArr = []
            @driverArr.push(driver.name)
            @driverArr.push(driver.address)
            @driverAddresses.push(@driverArr)
        end
        erb :riderHome
    end
    
    post '/driverLogin' do
        @email = params[:email]
        @password = params[:password]
        @drivers = Driver.all
        count = 0
        @drivers.each do |driver|
            if driver.email == @email && driver.password == @password
                count+=1
                @id = driver.id
            end
        end
        if count == 0
            @output = "Wrong email or password."
        end
        @driver = Driver.find(@id)
        @name = @driver.name
        @riders= @driver.riders
        erb :driverHome
    end
    
    post '/riderLogin' do
        @email = params[:email]
        @password = params[:password]
        @riders = Rider.all
        count = 0
        @riders.each do |rider|
            if rider.email.downcase() == @email.downcase() && rider.password == @password
                @id = rider.id
                puts rider
                count = 1
                break;
            end
        end
        if count == 0
            @output = "Wrong email or password."
            erb :riderLogin
        else
            @rider = Rider.find(@id)
            @drivers = @rider.drivers
            @name = @rider.name
            @driversAcc = Driver.all
            @driverAddresses = []
            @driversAcc.each do |driver|
                @driverArr = []
                @driverArr.push(driver.name)
                @driverArr.push(driver.address)
                @driverAddresses.push(@driverArr)
            end
            erb :riderHome
        end
    end
    
    post '/chooseDriver' do
        @riderID = params[:riderId]
        @driverID = params[:driverId]
        @driver = Driver.find(@driverID)
        @rider = Rider.find(@riderID)
        @riders = @driver.riders
        @drivers = @rider.drivers
        @driver.update(riders: @riders.push(@riderID + "~"))
        @rider.update(drivers: @drivers.push(@driverID + "~"))
        @name = @rider.name
        @driversAcc = Driver.all
        @driverAddresses = []
        @driversAcc.each do |driver|
            @driverArr = []
            @driverArr.push(driver.name)
            @driverArr.push(driver.address)
            @driverAddresses.push(@driverArr)
            puts @driverAddresses
        end
        @id = @rider.id
        redirect "/riderHome/#{@id}"
    end
    
    post '/unchooseDriver' do
        @riderID = params[:riderId]
        @driverID = params[:driverId]
        @driver = Driver.find(@driverID)
        @rider = Rider.find(@riderID)
        @riders = @driver.riders
        @drivers = @rider.drivers
        @riders.delete_at(@riders.index(@riderID + "~"))
        @drivers.delete_at(@drivers.index(@driverID + "~"))
        @driver.update(riders: @riders)
        @rider.update(drivers: @drivers)
        @name = @rider.name
        @driversAcc = Driver.all
        @driverAddresses = []
        @driverArr = []
        @driversAcc.each do |driver|
            @driverArr = []
            @driverArr.push(driver.name)
            @driverArr.push(driver.address)
            @driverAddresses.push(@driverArr)
            puts @driverAddresses
        end
        @id = @rider.id
        redirect "/riderHome/#{@id}"
    end
    
    post '/selectRider' do
        @riderID = params[:riderId]
        @driverID = params[:driverId]   
        @rider = Rider.find(@riderID)
        @driver = Driver.find(@driverID)
        @drivers = @rider.drivers
        @riders = @driver.riders
        @riders[@riders.index(@riderID + "~")] = @riderID + "~" + "true"
        @drivers[@drivers.index(@driverID + "~")] = @driverID + "~" + "true"
        @driver.update(riders: @riders)
        @rider.update(drivers: @drivers)
        @id = @driver.id
        redirect "/driverHome/#{@id}"
    end
    
    post '/noRider' do
        @riderID = params[:riderId]
        @driverID = params[:driverId]
        @rider = Rider.find(@riderID)
        @driver = Driver.find(@driverID)
        @drivers = @rider.drivers
        @riders = @driver.riders
        @riders.delete_at(@riders.index(@riderID + "~"))
        @drivers[@drivers.index(@driverID + "~")] = @driverID + "~" + "false"
        @driver.update(riders: @riders)
        @rider.update(drivers: @drivers)
        @id = @driver.id
        redirect "/driverHome/#{@id}"
    end
end