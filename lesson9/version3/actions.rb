# frozen_string_literal: true

module Actions
  MENU_ACTIONS = {
    1 => :create_station,
    2 => :create_train,
    3 => :route_management,
    4 => :assing_route,
    5 => :wagons_management,
    6 => :train_movement,
    7 => :station_info
  }.freeze

  CREATE_TRAIN_ACTIONS = { 1 => :create_passenger_train, 2 => :create_cargo_train }.freeze

  ROUTE_ACTIONS = { 1 => :create_route, 2 => :change_existing_route, 3 => :route_station_info }.freeze

  ASSING_ROUTE_ACTIONS = { 1 => :passenger_train_route, 2 => :cargo_train_route }.freeze

  WAGON_MANAGEMENT_ACTIONS = { 1 => :attach, 2 => :unhook, 3 => :seats_or_volume, 4 => :wagons_info }.freeze

  TRAIN_MOVEMENT_ACTIONS = { 1 => :move_forward, 2 => :move_backward }.freeze

  STATION_IN_ROUTE_ACTIONS = { 1 => :add_station_to_route, 2 => :delete_station_from_route }.freeze

  ATTACH_WAGON_ACTIONS = { 1 => :attach_passenger, 2 => :attach_cargo }.freeze

  UNHOOK_WAGON_ACTIONS = { 1 => :unhook_passenger, 2 => :unhook_cargo }.freeze

  TAKE_PLACE_ACTIONS = { 1 => :take_a_seat, 2 => :take_a_volume }.freeze

  MOVE_FORWARD_ACTIONS = { 1 => :passenger_train_move_forward, 2 => :cargo_train_move_forward }.freeze

  MOVE_BACKWARD_ACTIONS = { 1 => :passenger_train_move_backward, 2 => :cargo_train_move_backward }.freeze

  WAGONS_INFO_ACTIONS = { 1 => :passenger_train_wagons_info, 2 => :cargo_train_wagons_info }.freeze

  private

  def user_choice
    puts 'Выберите действие и введите цифру, соответствующую желаемому действию: '
    puts '1. Создать станцию'
    puts '2. Создать поезд'
    puts '3. Управление маршрутами(создать, изменить, информация)'
    puts '4. Назначить маршрут поезду'
    puts '5. Управление вагонами поездов'
    puts '6. Переместить поезд по маршруту (вперед или назад)'
    puts '7. Просмотреть список поездов на станции'
  end

  def display_wagon_actions
    puts 'Выберите действие: '
    puts '1. Прицпеть вагон к поезду'
    puts '2. Отцепить вагон от поезда'
    puts '3. Занять место или объем в вагоне'
    puts '4. Показать список вагонов поезда'
  end

  def create_route
    if @stations.size < 2
      puts 'Сперва создайте первую и последнюю станцию для маршрута'
    else
      begin
      display_station_list
      first_station_choice = choose_station('Выберите начальную станцию маршрута: ')
      last_station_choice = choose_station('Выберите конечную станцию маршрута: ')

      route = Route.new(@stations[first_station_choice], @stations[last_station_choice])
      @routes << route
      rescue StandardError => e
        puts "Error: #{e.message}"
        retry
      end
    end
  end

  def change_existing_route
    return puts('Сперва создайте хотя бы один маршрут') if @routes.empty?

    display_routes
    route_choice = gets.chomp.to_i - 1

    puts 'Выберите действие: 1. Добавить станцию в маршрут; 2. Удалить станцию из маршрута'
    action_choice = gets.chomp.to_i

    if STATION_IN_ROUTE_ACTIONS.key?(action_choice)
      send(STATION_IN_ROUTE_ACTIONS[action_choice], route_choice)
    else
      puts 'Выберите цифру, которая соответствует пунктам от 1 до 2'
    end
  end

  def route_station_info
    return puts 'у вас нет ни одного маршрута, сперва создайте' if @routes.empty?

    puts 'Какой маршрут вас интересует?'

    @routes.each_with_index do |route, index|
      puts "#{index + 1}. #{route.stations}"
    end
    route_info_choice = gets.chomp.to_i - 1

    puts 'На данном маршруте есть следующие станции: '
    @routes[route_info_choice].stations.each do |stations|
      puts stations.name
    end
  end

  def attach
    puts 'Какому типу поезда вы хотите прицепить вагон? 1. Пассажирский; 2. Грузовой'
    train_type_choice = gets.chomp.to_i

    if ATTACH_WAGON_ACTIONS.key?(train_type_choice)
      send(ATTACH_WAGON_ACTIONS[train_type_choice])
    else
      puts 'Выберите цифру, которая соответствует пунктам от 1 до 2'
    end
  rescue StandardError => e
    puts "Error: #{e.message}"
    retry
  end

  def unhook
    puts 'У какого типа поезда вы хотите отцепить вагон? 1. Пассажирский; 2. Грузовой'
    train_type_choice = gets.chomp.to_i

    if UNHOOK_WAGON_ACTIONS.key?(train_type_choice)
      send(UNHOOK_WAGON_ACTIONS[train_type_choice])
    else
      puts 'Выберите цифру, которая соответствует пунктам от 1 до 2'
    end
  end

  def seats_or_volume
    puts 'Выберите действие: '
    puts '1. Занять место в пассажирском вагоне'
    puts '2. Занять объем в грузовом вагоне'
    wagon_type_choice = gets.chomp.to_i

    if TAKE_PLACE_ACTIONS.key?(wagon_type_choice)
      send(TAKE_PLACE_ACTIONS[wagon_type_choice])
    else
      puts 'Выберите цифру, которая соответствует пунктам от 1 до 2'
    end
  rescue StandardError => e
    puts "Error: #{e.message}"
    retry
  end

  def move_forward
    puts 'Выберите тип поезда: 1. Пассажирский; 2. Грузовой: '
    type_choice = gets.chomp.to_i

    if MOVE_FORWARD_ACTIONS.key?(type_choice)
      send(MOVE_FORWARD_ACTIONS[type_choice])
    else
      puts 'Выберите цифру, которая соответствует пунктам от 1 до 2'
    end
  end

  def move_backward
    puts 'Выберите тип поезда: 1. Пассажирский; 2. Грузовой: '
    type_choice = gets.chomp.to_i

    if MOVE_BACKWARD_ACTIONS.key?(type_choice)
      send(MOVE_BACKWARD_ACTIONS[type_choice])
    else
      puts 'Выберите цифру, которая соответствует пунктам от 1 до 2'
    end
  end

  def take_a_seat
    return puts 'У вас нет ни одного пассажирского поезда' if @passenger_trains.empty?

    display_passenger_trains
    train_choice = gets.chomp.to_i - 1
    train_choice if train_choice >= 0 && train_choice < @passenger_trains.size

    if train_choice.nil?
      puts 'У выбранного поезда нет вагонов'
    else
      wagon_choice = choose_wagon(train_choice)

      if wagon_choice.nil?
        puts 'В вагоне все места заняты'
      else
        wagon = @passenger_trains[train_choice].wagons[wagon_choice]
        if wagon.free_place.positive?
          wagon.take_seat
          puts "Место занято. Занятых мест - #{wagon.used_place}"
          puts "Свободных мест в вагоне - #{wagon.free_place}"
        else
          puts 'В вагоне все места заняты'
        end
      end
    end
  end

  def take_a_volume
    return puts 'У вас нет ни одного грузового поезда' if @cargo_trains.empty?

    display_cargo_trains
    train_choice = gets.chomp.to_i - 1
    selected_train = @cargo_trains[train_choice]

    return puts 'У выбранного поезда нет вагонов' if selected_train.wagons.empty?

    display_wagons(selected_train)
    wagon_choice = gets.chomp.to_i - 1
    selected_wagon = selected_train.wagons[wagon_choice]

    take_volume(selected_wagon)
  end

  def wagons_info
    puts 'Выберите тип поезда: 1. Пассажирский; 2. Грузовой: '
    type_choice = gets.chomp.to_i

    if WAGONS_INFO_ACTIONS.key?(type_choice)
      send(WAGONS_INFO_ACTIONS[type_choice])
    else
      puts 'Выберите цифру, которая соответствует пунктам от 1 до 2'
    end
  end

  def create_passenger_train
    puts 'Введите номер поезда: '
    train_number = gets.chomp
    train = PassengerTrain.new(train_number)
    @passenger_trains << train
    puts "Пассажирский поезд с номером #{train_number} создан"
  rescue StandardError => e
    puts "Error: #{e.message}"
    retry
  end

  def create_cargo_train
    puts 'Введите номер поезда: '
    train_number = gets.chomp
    train = CargoTrain.new(train_number)
    @cargo_trains << train
    puts "Грузовой поезд с номером #{train_number} создан"
  rescue StandardError => e
    puts "Error: #{e.message}"
    retry
  end

  def passenger_train_route
    return puts 'У вас нет ни одного пассажирского поезда' if @passenger_trains.empty?

    display_passenger_trains

    train_choice = gets.chomp.to_i - 1

    return puts 'у вас нет ни одного маршрута, сперва создайте' if @routes.empty?

    display_routes
    route_choice = gets.chomp.to_i - 1

    @passenger_trains[train_choice].add_route(@routes[route_choice])
    puts 'Поезду присвоен маршрут.'
  end

  def cargo_train_route
    return puts 'У вас нет ни одного грузового поезда' if @cargo_trains.empty?

    display_cargo_trains

    train_choice = gets.chomp.to_i - 1

    return puts 'у вас нет ни одного маршрута, сперва создайте' if @routes.empty?

    display_routes
    route_choice = gets.chomp.to_i - 1

    @cargo_trains[train_choice].add_route(@routes[route_choice])
    puts 'Поезду присвоен маршрут.'
  end

  def station_info!
    display_station_list
    station_choice = gets.chomp.to_i - 1

    if @stations[station_choice].trains.any?
      puts "На станции #{@stations[station_choice].name} нахоятся такие поезда: "
      @stations[station_choice].each_trains do |train|
        puts "Номер поезда #{train.number}. Тип поезда: #{train.type}. Количество вагонов: #{train.wagons.size}"
      end
    else
      puts "На станции #{@stations[station_choice].name} нет ни одного поезда"
    end
  end

  def add_station_to_route(route_choice)
    display_station_list
    station_choice = gets.chomp.to_i - 1

    if @routes[route_choice].stations.include?(@stations[station_choice])
      puts 'Стания уже есть в маршруте.'
    else
      @routes[route_choice].add_station(@stations[station_choice])
    end
  end

  def delete_station_from_route(route_choice)
    route = @routes[route_choice]

    puts 'Выберите станцию, которую хотели бы удалить из маршрута: '

    route.stations.each_with_index { |station, index| puts "#{index + 1}. #{station.name}" }
    choice = gets.chomp.to_i - 1

    station_to_delete = route.stations[choice]

    if [route.stations.first, route.stations.last].include?(station_to_delete)
      puts 'Вы не можете удалять начальную и конечные станции'
    else
      route.delete_station(station_to_delete)
    end
  end

  def attach_passenger
    return puts 'У вас нет ни одного пассажирского поезда' if @passenger_trains.empty?

    display_passenger_trains
    train_choice = gets.chomp.to_i - 1

    puts 'Укажите количество мест в вагоне: '
    number_of_seats = gets.chomp

    if number_of_seats.match?(/\A\d+\z/)
      number_of_seats = number_of_seats.to_i
    else
      raise 'Input must be numeric'
    end

    passenger_wagon = PassengerWagon.new(number_of_seats)
    @passenger_trains[train_choice].attach_a_wagon(passenger_wagon)
    puts "К поезду добавлен вагон. Мест в вагоне: #{number_of_seats}."
    puts "Всего вагонов у поезда - #{@passenger_trains[train_choice].wagons.size} шт."
  end

  def attach_cargo
    return puts 'У вас нет ни одного грузового поезда' if @cargo_trains.empty?

    display_cargo_trains
    train_choice = gets.chomp.to_i - 1

    puts 'Укажите объем грузового вагона: '
    total_volume = gets.chomp

    if total_volume.match?(/\A\d+\z/)
      total_volume = total_volume.to_i
    else
      raise 'Input must be numeric'
    end

    cargo_wagon = CargoWagon.new(total_volume)
    @cargo_trains[train_choice].attach_a_wagon(cargo_wagon)
    puts "К поезду добавлен вагон. Объем вагона: #{total_volume}."
    puts "Всего вагонов у поезда - #{@cargo_trains[train_choice].wagons.size} шт."
  end

  def unhook_passenger
    return puts 'У вас нет ни одного пассажирского поезда' if @passenger_trains.empty?

    display_passenger_trains

    train_choice = gets.chomp.to_i - 1

    if @passenger_trains[train_choice].wagons.any?
      @passenger_trains[train_choice].unhook_the_wagon
      puts "Вы отцепили вагон от поезда, всего вагонов - #{@passenger_trains[train_choice].wagons.size} шт."
    else
      puts 'У этого поезда нет вагонов'
    end
  end

  def unhook_cargo
    return puts 'У вас нет ни одного грузового поезда' if @cargo_trains.empty?

    display_cargo_trains
    train_choice = gets.chomp.to_i - 1

    if @cargo_trains[train_choice].wagons.any?
      @cargo_trains[train_choice].unhook_the_wagon
      puts "Вы отцепили вагон от поезда, всего вагонов - #{@cargo_trains[train_choice].wagons.size} шт."
    else
      puts 'У этого поезда нет вагонов'
    end
  end

  def passenger_train_move_forward
    if @passenger_trains.any?
      begin
        display_passenger_trains
        train_choice = gets.chomp.to_i - 1

        puts 'Установите скорость, с которой будет ехать поезд до станции:'
        speed_choice = gets.chomp.to_i

        if speed_choice.positive?
          @passenger_trains[train_choice].speed = speed_choice
          @passenger_trains[train_choice].move_forward
          puts "Поезд прибыл на станцию #{@passenger_trains[train_choice].current_station.name}"
        else
          puts 'Чтоб поезд смог поехать установите скорость больше нуля!'
        end
      rescue StandardError => e
        puts "Error : the train has not been assigned a route"
      end
    else
      puts 'У вас нет пассажирских поездов'
    end
  end

  def cargo_train_move_forward
    if @cargo_trains.any?
      begin
        display_cargo_trains
        train_choice = gets.chomp.to_i - 1

        puts 'Установите скорость, с которой будет ехать поезд до станции:'
        speed_choice = gets.chomp.to_i

        if speed_choice.positive?
          @cargo_trains[train_choice].speed = speed_choice
          @cargo_trains[train_choice].move_forward
          puts "Поезд прибыл на станцию #{@cargo_trains[train_choice].current_station.name}"
        else
          puts 'Чтоб поезд смог поехать установите скорость больше нуля!'
        end
      rescue StandardError => e
        puts "Error : the train has not been assigned a route"
      end
    else
      puts 'У вас нет грузовых поездов'
    end
  end

  def passenger_train_move_backward
    if @passenger_trains.any?
      begin
        display_passenger_trains
        train_choice = gets.chomp.to_i - 1

        puts 'Установите скорость, с которой будет ехать поезд до станции:'
        speed_choice = gets.chomp.to_i
        if speed_choice.positive?
          @passenger_trains[train_choice].speed = speed_choice
          @passenger_trains[train_choice].move_backward
          puts "Поезд вернулся на станцию #{@passenger_trains[train_choice].current_station.name}"
        else
          puts 'Чтоб поезд смог поехать установите скорость больше нуля!'
        end
      rescue StandardError => e
        puts "Error : the train has not been assigned a route"
      end
    else
      puts 'У вас нет пассажирских поездов'
    end
  end

  def cargo_train_move_backward
    if @cargo_trains.any?
      begin
        display_cargo_trains
        train_choice = gets.chomp.to_i - 1

        puts 'Установите скорость, с которой будет ехать поезд до станции:'
        speed_choice = gets.chomp.to_i

        if speed_choice.positive?
          @cargo_trains[train_choice].speed = speed_choice
          @cargo_trains[train_choice].move_backward
          puts "Поезд вернулся на станцию #{@cargo_trains[train_choice].current_station.name}"
        else
          puts 'Чтоб поезд смог поехать установите скорость больше нуля!'
        end
      rescue StandardError => e
        puts "Error : the train has not been assigned a route"
      end
    else
      puts 'У вас нет грузовых поездов'
    end
  end

  def passenger_train_wagons_info
    return puts 'У вас нет пассажирских поездов' if @passenger_trains.empty?

    display_passenger_trains
    train_choice = gets.chomp.to_i - 1

    return puts 'У данного поезда нет вагонов' if @passenger_trains[train_choice].wagons.empty?

    wagon_number = 0
    @passenger_trains[train_choice].each_wagons do |wagon|
      puts "#{wagon_number += 1}. Тип вагона: #{wagon.type}."
      puts "Количество мест - #{wagon.total_place}. Количество свободных мест - #{wagon.free_place}"
    end
  end

  def cargo_train_wagons_info
    return puts 'У вас нет грузовых поездов' if @cargo_trains.empty?

    display_cargo_trains
    train_choice = gets.chomp.to_i - 1

    return puts 'У данного поезда нет вагонов' if @cargo_trains[train_choice].wagons.empty?

    wagon_number = 0
    @cargo_trains[train_choice].each_wagons do |wagon|
      puts "#{wagon_number += 1}. Тип вагона: #{wagon.type}."
      puts "Объем вагона - #{wagon.total_place}. Доступный объем - #{wagon.free_place}"
    end
  end

  def display_station_list
    puts 'Выберите станцию. Введите соответствующие цифру: '
    @stations.each_with_index do |station, index|
      puts "#{index + 1}. #{station.name}"
    end
  end

  def choose_station(message)
    puts message
    choice = gets.chomp
    if choice.match?(/\A\d+\z/)
      choice = choice.to_i - 1
    else
      raise 'Input must be numeric'
    end
  end

  def display_routes
    puts 'Выберите маршрут. Введите соответствующую цифру: '
    @routes.each_with_index { |route, index| puts "#{index + 1}. #{route.stations}" }
  end

  def display_passenger_trains
    puts 'Выберите пассажирский поезд:'
    @passenger_trains.each_with_index { |train, index| puts "#{index + 1}. Пассажирский поезд № #{train.number}" }
  end

  def choose_wagon(train_choice)
    train = @passenger_trains[train_choice]
    return nil if train.wagons.empty?

    puts 'Выберите вагон, в котором хотите занять место: '
    train.wagons.each_with_index do |wagon, index|
      puts "#{index + 1}. Вагон с количеством мест - #{wagon.total_place}"
    end
    wagon_choice = gets.chomp.to_i - 1
    wagon_choice if wagon_choice >= 0 && wagon_choice < train.wagons.size
  end

  def display_cargo_trains
    puts 'Выберите грузовой поезд:'
    @cargo_trains.each_with_index { |train, index| puts "#{index + 1}. Грузовой поезд № #{train.number}" }
  end

  def display_wagons(train)
    puts 'Выберите вагон, в котором хотите занять объем:'
    train.wagons.each_with_index { |wagon, index| puts "#{index + 1}. Вагон с объемом - #{wagon.total_place}" }
  end

  def take_volume(wagon)
    puts "Укажите объем. Доступный объем - #{wagon.free_place}"
    volume_choice = gets.chomp

    if volume_choice.match?(/\A\d+\z/)
      volume_choice = volume_choice.to_i
    else
      raise 'Input must be numeric'
    end

    if wagon.free_place >= volume_choice
      wagon.take_volume(volume_choice)
      puts "Объем занят. Занятый объем вагона - #{wagon.used_place}. Доступный объем - #{wagon.free_place}."
    else
      puts 'Весь объем вагона занят'
    end
  end
end
