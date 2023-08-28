require_relative 'train'
require_relative 'station'
require_relative 'route'
require_relative 'wagon'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'passenger_wagon'
require_relative 'cargo_wagon'

stations = []
passenger_trains = []
cargo_trains = []
routes = []

loop do
  puts "Выберите действие и введите цифру, соответствующую желаемому действию: "
  puts "1. Создать станцию"
  puts "2. Создать поезд"
  puts "3. Создание маршрута и управление станциями в нем (добавить, удалить), информация о списке станций на маршруте"
  puts "4. Назначить маршрут поезду"
  puts "5. Добавить вагоны к поезду или отцепить вагоны от поезда"
  puts "6. Переместить поезд по маршруту (вперед или назад)"
  puts "7. Просмотреть список поездов на станции"

  choice = gets.chomp.to_i

  case choice
  when 1
    puts "Введите имя станции:"
    name_station_choice = gets.chomp.downcase
    station = Station.new(name_station_choice)
    stations << station
  when 2
    puts "Какой поезд вы хотите создать? Введите соответствующую цифру: 1. Пассажирский; 2. Грузовой"
    train_choice = gets.chomp.to_i

    case train_choice
    when 1
      puts "Введите номер поезда: "
      train_number = gets.chomp.to_i
      train = PassengerTrain.new(train_number)
      passenger_trains << train
    when 2
      puts "Введите номер поезда: "
      train_number = gets.chomp.to_i
      train = CargoTrain.new(train_number)
      cargo_trains << train
    else
      puts "Выберите цифру, которая соответствует пунктам от 1 до 2"
    end
  when 3
    puts "Вы хотите создать маршрут или внести изменения в существующий? Введите соответствующую цифру:"
    puts "1. Создать новый маршрут"
    puts "2. Внести изменения в существующий"
    puts "3. Просмотр списка станций на маршруте"
    route_action_choice = gets.chomp.to_i

    case route_action_choice
    when 1
      if stations.size < 2
        puts "Сперва создайте первую и последнюю станцию для маршрута"
      else
        puts "Выберите станции, которые хотите добавить в маршрут. Введите соответствующую цифру: "
        stations.each_with_index do |station, index|
          puts "#{index + 1}. #{station.name}"
        end
        puts "Выберите начальную станцию маршрута: "
        first_station_choice = gets.chomp.to_i - 1

        puts "Выберите конечную станцию маршрута: "
        last_station_choice = gets.chomp.to_i - 1

        route = Route.new(stations[first_station_choice], stations[last_station_choice])
        routes << route
      end
    when 2
      if routes.empty?
        puts "Сперва создайте хотя бы один маршрут"
      else
        puts "Выберите маршрут, в которй хотели бы внести изменения. Введите соответствующую цифру: "
        routes.each_with_index do |route, index|
          puts "#{index + 1}. #{route.stations}"
        end
        route_choice = gets.chomp.to_i - 1

        puts "Выберите действие: 1. Добавить станцию в маршрут; 2. Удалить станцию из маршрута"
        add_delete_stations_choice = gets.chomp.to_i

        case add_delete_stations_choice
        when 1
          puts "Выберите станцию, которую хотели бы добавить в маршрут: "

          stations.each_with_index do |station, index|
            puts "#{index + 1}. #{station.name}"
          end
          add_station_choice = gets.chomp.to_i - 1

          if routes[route_choice].stations.include?(stations[add_station_choice])
            puts "Стания уже есть в маршруте."
          else
            routes[route_choice].add_station(stations[add_station_choice])
          end
        when 2
          puts "Выберите станцию, которую хотели бы удалить из маршрута: "

          routes[route_choice].stations.each_with_index do |station, index|
            puts "#{index + 1}. #{station.name}"
          end
          delete_station_choice = gets.chomp.to_i - 1

          routes[route_choice].delete_station(routes[route_choice].stations[delete_station_choice])
        else
          puts "Выберите цифру, которая соответствует пунктам от 1 до 2"
        end
      end
    when 3
      puts "Какой маршрут вас интересует?"

      routes.each_with_index do |route, index|
        puts "#{index + 1}. #{route.stations}"
      end
      route_info_choice = gets.chomp.to_i - 1

      puts "На данном маршруте есть следующие станции: "
      routes[route_info_choice].stations.each do |stations|
        puts "#{stations.name}"
      end
    else
      puts "Выберите цифру, которая соответствует пунктам от 1 до 3"
    end
  when 4
    puts "Какому типу поезда Вы хотите добавить маршрут? Введите соответствующую цифру: 1. Пассажирский; 2. Грузовой"
    train_type_choice = gets.chomp.to_i

    case train_type_choice
    when 1
      if passenger_trains.empty?
        puts "У вас нет ни одного пассажирского поезда"
      else
        puts "Выберите порядковый номер поезда, которому хотите добавить маршрут: "
        passenger_trains.each_with_index do |train, index|
          puts "#{index + 1}. Пассажирский поезд № #{train.number}"
        end

        train_number_choice = gets.chomp.to_i - 1

        puts "Выберите маршрут, который хотите присвоить выбранному поезду: "
        routes.each_with_index do |route, index|
          puts "#{index + 1}. Маршрут со станциями: #{route.stations}"
        end
        route_to_train_choice = gets.chomp.to_i - 1

        passenger_trains[train_number_choice].add_route(routes[route_to_train_choice])
        puts "Поезду присвоен маршрут."
      end
    when 2
      if cargo_trains.empty?
        puts "У вас нет ни одного грузового поезда"
      else
        puts "Выберите порядковый номер поезда, которому хотите добавить маршрут: "
        cargo_trains.each_with_index do |train, index|
          puts "#{index + 1}. Грузовой поезд № #{train.number}"
        end

        train_number_choice = gets.chomp.to_i - 1

        puts "Выберите маршрут, который хотите присвоить выбранному поезду: "
        routes.each_with_index do |route, index|
          puts "#{index + 1}. Маршрут со станциями: #{route.stations}"
        end
        route_to_train_choice = gets.chomp.to_i - 1

        cargo_trains[train_number_choice].add_route(routes[route_to_train_choice])
        puts "Поезду присвоен маршрут."
      end
    else
      puts "Выберите цифру, которая соответствует пунктам от 1 до 2"
    end
  when 5
    puts "Вы хотите прицепить или отцепить вагон от поезда? 1. Прицпеть; 2. Отцепить"
    attach_or_unhook_choice = gets.chomp.to_i

    case attach_or_unhook_choice
    when 1
      puts "Какому типу поезда вы хотите прицепить вагон? 1. Пассажирский; 2. Грузовой"
      train_type_choice_for_attach = gets.chomp.to_i

      case train_type_choice_for_attach
      when 1
        if passenger_trains.empty?
          puts "У вас нет ни одного пассажирского поезда"
        else
          puts "Выберите поезд, к которому нужно прицепить вагон: "
          passenger_trains.each_with_index do |train, index|
            puts "#{index + 1}. Пассажирский поезд № #{train.number}"
          end
          train_number_choice_for_wagon = gets.chomp.to_i - 1

          passenger_wagon = PassengerWagon.new
          passenger_trains[train_number_choice_for_wagon].attach_a_wagon(passenger_wagon)
          puts "К поезду добавлен вагон, всего вагонов у поезда - #{passenger_trains[train_number_choice_for_wagon].wagons.size} шт."
        end
      when 2
        if cargo_trains.empty?
          puts "У вас нет ни одного грузового поезда"
        else
          puts "Выберите поезд, к которому нужно прицепить вагон: "
          cargo_trains.each_with_index do |train, index|
            puts "#{index + 1}. Грузовой поезд № #{train.number}"
          end
          train_number_choice_for_attach_wagon = gets.chomp.to_i - 1

          cargo_wagon = CargoWagon.new
          cargo_trains[train_number_choice_for_attach_wagon].attach_a_wagon(cargo_wagon)
          puts "К поезду добавлен вагон, всего вагонов у поезда - #{cargo_trains[train_number_choice_for_attach_wagon].wagons.size} шт."
        end
      else
        puts "Выберите цифру, которая соответствует пунктам от 1 до 2"
      end
    when 2
      puts "У какого типа поезда вы хотите отцепить вагон? 1. Пассажирский; 2. Грузовой"
      train_type_choice_for_unhook = gets.chomp.to_i

      case train_type_choice_for_unhook
      when 1
        if passenger_trains.empty?
          puts "У вас нет ни одного пассажирского поезда"
        else
          puts "Выберите поезд, у которого нужно отцепить вагон: "
          passenger_trains.each_with_index do |train, index|
            puts "#{index + 1}. Пассажирский поезд № #{train.number}"
          end
          train_number_choice_for_unhook_wagon = gets.chomp.to_i - 1

          passenger_trains[train_number_choice_for_unhook_wagon].unhook_the_wagon
          puts "Вы отцепили вагон от поезда, всего вагонов - #{passenger_trains[train_number_choice_for_unhook_wagon].wagons.size} шт."
        end
      when 2
        if cargo_trains.empty?
          puts "У вас нет ни одного пассажирского поезда"
        else
          puts "Выберите поезд, у которого нужно отцепить вагон: "
          cargo_trains.each_with_index do |train, index|
            puts "#{index + 1}. Грузовой поезд № #{train.number}"
          end
          train_number_choice_for_unhook_wagon = gets.chomp.to_i - 1

          сargo_trains[train_number_choice_for_unhook_wagon].unhook_the_wagon
          puts "Вы отцепили вагон от поезда, всего вагонов - #{сargo_trains[train_number_choice_for_unhook_wagon].wagons.size} шт."
        end
      else
        puts "Выберите цифру, которая соответствует пунктам от 1 до 2"
      end
    else
      puts "Выберите цифру, которая соответствует пунктам от 1 до 2"
    end
  when 6
    puts "Выберите тип поезда: 1. Пассажирский; 2. Грузовой: "
    type_choice_for_move = gets.chomp.to_i

    case type_choice_for_move
    when 1
      puts "Выберите поезд: "
      passenger_trains.each_with_index do |train, index|
        puts "#{index + 1}. Пассажирский поезд № #{train.number}"
      end
      train_number_choice_for_move = gets.chomp.to_i - 1

      puts "Переместить поезд вперед или незад? 1. Вперед; 2. Назад"
      forward_or_backward_choice = gets.chomp.to_i

      case forward_or_backward_choice
      when 1
        puts "Установите скорость, с которой будет ехать поезд до станции:"
        speed_choice = gets.chomp.to_i

        if speed_choice.positive?
          passenger_trains[train_number_choice_for_move].speed = speed_choice
          passenger_trains[train_number_choice_for_move].move_forward
          puts "Поезд прибыл на станцию #{passenger_trains[train_number_choice_for_move].current_station.name}"
        else
          puts "Чтоб поезд смог поехать установите скорость больше нуля!"
        end
      when 2
        puts "Установите скорость, с которой будет ехать поезд до станции:"
        speed_choice = gets.chomp.to_i

        if speed_choice.positive?
          passenger_trains[train_number_choice_for_move].speed = speed_choice
          passenger_trains[train_number_choice_for_move].move_backward
          puts "Поезд вернулся на станцию #{passenger_trains[train_number_choice_for_move].current_station.name}"
        else
          puts "Чтоб поезд смог поехать установите скорость больше нуля!"
        end
      else
        puts "Выберите цифру, которая соответствует пунктам от 1 до 2"
      end
    when 2
      puts "Выберите поезд: "
      cargo_trains.each_with_index do |train, index|
        puts "#{index + 1}. грузовой поезд № #{train.number}"
      end
      train_number_choice_for_move = gets.chomp.to_i - 1

      puts "Переместить поезд вперед или незад? 1. Вперед; 2. Назад"
      forward_or_backward_choice = gets.chomp.to_i

      case forward_or_backward_choice
      when 1
        puts "Установите скорость, с которой будет ехать поезд до станции:"
        speed_choice = gets.chomp.to_i

        if speed_choice.positive?
          cargo_trains[train_number_choice_for_move].speed = speed_choice
          cargo_trains[train_number_choice_for_move].move_forward
          puts "Поезд прибыл на станцию #{cargo_trains[train_number_choice_for_move].current_station.name}"
        else
          puts "Чтоб поезд смог поехать установите скорость больше нуля!"
        end
      when 2
        puts "Установите скорость, с которой будет ехать поезд до станции:"
        speed_choice = gets.chomp.to_i

        if speed_choice.positive?
          cargo_trains[train_number_choice_for_move].speed = speed_choice
          cargo_trains[train_number_choice_for_move].move_backward
          puts "Поезд вернулся на станцию #{cargo_trains[train_number_choice_for_move].current_station.name}"
        else
          puts "Чтоб поезд смог поехать установите скорость больше нуля!"
        end
      else
        puts "Выберите цифру, которая соответствует пунктам от 1 до 2"
      end
    else
      puts "Выберите цифру, которая соответствует пунктам от 1 до 2"
    end
  when 7
    puts "Выберите станцию: "
    stations.each_with_index do |station, index|
      puts "#{index + 1}. #{station.name}"
    end
    station_choice = gets.chomp.to_i - 1

    puts "На станции нахоятся такие поезда: #{stations[station_choice].trains}"
  else
    puts "Выберите цифру, которая соответствует пунктам от 1 до 7."
  end

  puts "Хотите продолжить? (Введите 'да' или 'нет')."
  continue = gets.chomp.downcase
  break unless continue == "да"
end
