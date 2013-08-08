
class Daytime

	class << self
		def from_array(array)
			Daytime.new(array[0]*3600 + array[1]*60 + array[2])
		end
		def from_string(string)
			ary = string.split(':').map(&:to_i)
			Daytime.from_array( ary + [0]*(3 - ary.size) )
		end
		def from_hash(hash)
			Daytime.from_array [ hash[:hours], hash[:minutes], hash[:seconds] ]
		end
		def from_time(time)
			Daytime.from_array time.to_a.take(3).reverse
		end
	end


	def initialize(seconds_from_the_beginning_of_day = 0)
		@day_seconds = seconds_from_the_beginning_of_day
	end

	def to_s
		"%02d:%02d:%02d" % to_a
	end

	def to_i
		@day_seconds
	end
	alias to_seconds to_i

	def to_h
		{ :hours => hours, :minutes => minutes, :seconds => seconds }
	end

	def to_a
		[ hours, minutes, seconds ]
	end

	def hours
		(@day_seconds / 3600) % 24
	end

	def minutes
		(@day_seconds - hours * 3600)/60
	end
	
	def seconds
		@day_seconds - hours*3600 - minutes*60
	end

	def +(value)
		value = value.to_seconds if value.is_a?(Daytime)
		@day_seconds += value
		self
	end

	def -(value)
		value = value.to_seconds if value.is_a?(Daytime)
		@day_seconds -= value
		self
	end

	def >(daytime)
		@day_seconds > daytime.to_seconds
	end

	def <(daytime)
		@day_seconds < daytime.to_seconds
	end
end
