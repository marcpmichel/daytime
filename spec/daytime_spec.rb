require_relative '../daytime'

describe Daytime do

	it "initializes from a number of seconds since the beginning of the day" do
		Daytime.new(45296).to_s.should == "12:34:56"
	end

	it "initializes from a string" do
		Daytime.from_string("12:34:56").to_seconds == 45296
	end

	it "initializes from an array" do
		Daytime.from_array([12,34,56]).to_i.should == 45296
	end

	it "initializes from a hash" do
		Daytime.from_hash( {
			hours: 12,
			minutes: 34,
			seconds: 56
		}).to_i.should == 45296
	end

	it "initializes from a Time" do
		t = Time.now
		Daytime.from_time(t).to_s.should == t.strftime("%H:%M:%S")
	end

	it "converts to hash" do
		h = Daytime.new(45296).to_h
		h[:hours].should == 12
		h[:minutes].should == 34
		h[:seconds].should == 56
	end

	context "edge cases" do
		it "handles 0" do
			Daytime.new(0).to_s.should == "00:00:00"
		end

		it "handles 23:59:59" do
			Daytime.from_array([23,59,59]).to_s.should == "23:59:59"
		end
	end

	context "hours" do
		it "handles overflowing hours" do
			Daytime.from_string("24:00:00").hours.should == 0
		end

		it "handles negative hours" do
			Daytime.from_string("-1:00:00").hours.should == 23
		end
	end

	context "minutes" do
		it "handles overflowing minutes" do
			dt = Daytime.from_string("0:67:0")
			dt.minutes.should == 7
			dt.hours.should == 1
		end

		it "handles negative minutes" do
			dt = Daytime.from_string("1:-2:0")
			dt.minutes.should == 58
			dt.hours.should == 0
		end
	end

	context "seconds" do
		it "handles overflowing seconds" do
			dt = Daytime.from_string("0:0:124")
			dt.seconds.should == 4
			dt.minutes.should == 2
			dt.hours.should == 0
		end

		it "handles negative seconds" do
			dt = Daytime.from_string("0:2:-30")
			dt.seconds.should == 30
			dt.minutes.should == 1
		end
	end

	context "operations" do
		it "adds time from a number of seconds" do
			dt = Daytime.from_string("1:2:3") + 61
			dt.to_s.should == "01:03:04"
		end

		it "adds time from a Daytime object" do
			dt = Daytime.from_string("1:2:3") + Daytime.from_string("1:1:1")
			dt.to_s.should == "02:03:04"
		end

		it "subs time from a number of seconds" do
			(Daytime.from_string("1:2:5") - 2).to_a.should == [1,2,3]
		end

		it "subs time from a Daytime object" do
			(Daytime.from_string("3:4:5") - Daytime.from_string("2:3:4")).to_a.should == [1,1,1]
		end
	end

	context "comparisons" do
		it "test if it is greater than another Daytime object" do
			(Daytime.new(10) > Daytime.new(5)).should be_true
			(Daytime.new(3) > Daytime.new(123)).should be_false
		end
		it "test if it is lesser than another Daytime object" do
			(Daytime.new(10) < Daytime.new(5)).should be_false
			(Daytime.new(3) < Daytime.new(123)).should be_true
		end
	end

end
