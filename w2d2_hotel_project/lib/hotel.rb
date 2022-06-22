require_relative "room"

class Hotel
  def initialize(name, hash)
    @name = name
    @rooms = {}

    hash.each do |k, v|
      @rooms[k] = Room.new(v)
    end
  end

  def name
    arr_name = @name.split(" ")
    cap_name = []

    arr_name.each do |ele|
      new_ele = ele[0].upcase + ele[1..-1].downcase
      cap_name << new_ele
    end

    return cap_name.join(" ")
  end

  def rooms
    @rooms
  end

  def room_exists?(room_name)
    if @rooms.key?(room_name)
      return true
    else
      return false
    end
  end

  def check_in(person, room_name)
    if self.room_exists?(room_name)
      if @rooms[room_name].add_occupant(person)
        puts "check in successful"
      else
        puts "sorry, room is full"
      end
    else
      puts "sorry, room does not exist"
    end
  end

  def has_vacancy?
    @rooms.each do |k, v|
      if !v.full?
        return true
      end
    end

    return false
  end

  def list_rooms
    @rooms.each do |k, v|
      puts k + v.available_space.to_s
    end
  end
end
