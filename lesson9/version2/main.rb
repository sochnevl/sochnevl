# frozen_string_literal: true

require_relative 'train'
require_relative 'station'
require_relative 'route'
require_relative 'wagon'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'passenger_wagon'
require_relative 'cargo_wagon'
require_relative 'actions'

class Main
  include Actions

  def initialize
    @stations = []
    @passenger_trains = []
    @cargo_trains = []
    @routes = []
  end

  def start
    loop do
      user_choice

      choice = gets.chomp.to_i

      MENU_ACTIONS.key?(choice) ? send(MENU_ACTIONS[choice]) : puts('Неверный выбор. Введите цифру от 1 до 7')

      puts "Хотите продолжить? (Введите 'уes' или 'no')."
      continue = gets.chomp.downcase
      break unless continue == 'yes'
    end
  end

  def create_station
    puts 'Введите имя станции:'
    name_station_choice = gets.chomp
    station = Station.new(name_station_choice)
    @stations << station
  rescue StandardError => e
    puts "Error: #{e.message}"
    retry
  end

  def create_train
    puts 'Какой поезд вы хотите создать? Введите соответствующую цифру: 1. Пассажирский; 2. Грузовой'
    train_choice = gets.chomp.to_i

    if CREATE_TRAIN_ACTIONS.key?(train_choice)
      send(CREATE_TRAIN_ACTIONS[train_choice])
    else
      puts 'Выберите цифру, которая соответствует пунктам от 1 до 2'
    end
  end

  def route_management
    puts 'Вы хотите создать маршрут или внести изменения в существующий? Введите соответствующую цифру:'
    puts '1. Создать новый маршрут'
    puts '2. Внести изменения в существующий'
    puts '3. Просмотр списка станций на маршруте'
    route_action_choice = gets.chomp.to_i

    if ROUTE_ACTIONS.key?(route_action_choice)
      send(ROUTE_ACTIONS[route_action_choice])
    else
      puts 'Выберите цифру, которая соответствует пунктам от 1 до 3'
    end
  end

  def assing_route
    puts 'Какому типу поезда Вы хотите добавить маршрут? Введите соответствующую цифру: 1. Пассажирский; 2. Грузовой'
    train_type_choice = gets.chomp.to_i

    if ASSING_ROUTE_ACTIONS.key?(train_type_choice)
      send(ASSING_ROUTE_ACTIONS[train_type_choice])
    else
      puts 'Выберите цифру, которая соответствует пунктам от 1 до 2'
    end
  end

  def wagons_management
    display_wagon_actions
    wagons_management_choice = gets.chomp.to_i

    if WAGON_MANAGEMENT_ACTIONS.key?(wagons_management_choice)
      send(WAGON_MANAGEMENT_ACTIONS[wagons_management_choice])
    else
      puts 'Выберите цифру, которая соответствует пунктам от 1 до 4'
    end
  end

  def train_movement
    puts 'Выберите направление движения поезда: 1. Вперед; 2. Назад'
    direction_choice = gets.chomp.to_i

    if TRAIN_MOVEMENT_ACTIONS.key?(direction_choice)
      send(TRAIN_MOVEMENT_ACTIONS[direction_choice])
    else
      puts 'Выберите цифру, которая соответствует пунктам от 1 до 2'
    end
  end

  def station_info
    return puts 'У вас нет созданных станций' if @stations.empty?

    station_info!
  end
end

rr = Main.new

rr.start

# при создании станции нужно вводить имя с большой буквы иметь в названии более одной буквы
# ------------------------------------------------------
# ранее, при создании поезда, нужно было вводить номер в соответсвии с форматом,
# мои поезда создаются как экземпляр подклассов (пассажирские и грузовые), в задании сказано, что реализация валидации у подклассов не обязательна
# потому создается поезд с любым номером
# ------------------------------------------------------
# при создании маршрута нужно выбирать станции из предложенных (1 - первая станция маршрута, 2 - последняя станция маршрута),
# если в  момент выбора станция нажать , допустим 3 (а она не создана, выбрасывается исключение)
# ------------------------------------------------------
# в некотрых местах исключения не выбрасываются из-за того, что конструкция if else предотвращает возникновение ошибки,
# например, если назначить маршрут поезду, но при этом, ни один маршрут создан не был выводится инфа о том,
# что нужно сперва создать поезд  и т.п.
# ------------------------------------------------------
