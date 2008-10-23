require "pathname"
require Pathname(__FILE__).dirname + "helper"

events = [
  UI::Calendar::Event.new(Date.today, "Position Opened", { :type => "milestone" }),
  UI::Calendar::Event.new(Date.today + 5, "Exclusivity End Date", { :type => "deadline" }),
  UI::Calendar::Event.new(Date.today + 25, "Fill Date", { :type => "deadline" })
]

IO.popen("pbcopy", "w") { |f| f.puts(UI::Calendar.new(events).to_s(:size => :small)) }

# puts UI::Calendar.new(events).to_s(:size => :small)

__END__
describe "UI::Calendar" do

  it "should do stuff" do
    events = [
      UI::Calendar::Event.new(Date.today, "Position Opened", { :type => "milestone" }),
      UI::Calendar::Event.new(Date.today + 5, "Exclusivity End Date", { :type => "deadline" }),
      UI::Calendar::Event.new(Date.today + 25, "Fill Date", { :type => "deadline" })
    ]
    puts UI::Calendar.new(events).to_s(:size => :small)
  end

end

describe "UI::Calendar::Month" do

  describe "succ" do
    it "should return the next month" do
      UI::Calendar::Month.new(2008, 10).succ.should == UI::Calendar::Month.new(2008, 11)
      UI::Calendar::Month.new(2008, 12).succ.should == UI::Calendar::Month.new(2009, 1)
    end
  end

  describe "<=>" do
    it "should handle a normal case" do
      (UI::Calendar::Month.new(2008, 10) <=> UI::Calendar::Month.new(2008, 11)).should == -1
    end

    it "should handle an edge case" do
      (UI::Calendar::Month.new(2009, 1) <=> UI::Calendar::Month.new(2008, 12)).should == 1
    end
  end

  it "should generate a range" do
    (UI::Calendar::Month.new(2008, 10)..UI::Calendar::Month.new(2009, 1)).to_a.size.should == 4
  end

  describe "to_s" do
    it "should return the month name and year" do
      UI::Calendar::Month.new(2008, 10).to_s.should == "October 2008"
    end
  end

end

__END__

## UI::Calendar::Event

UI::Calendar::Event.new(Date.now, "Position Opened", { :type => "milestone" })

# Some other site
UI::Calendar::Event.new(Date.now, "Stuff Happens")
UI::Calendar::Event.new([Date.now, Date.now + 10], "Christmas Break")
UI::Calendar::Event.new(Time.now, "Registration Opens", { :type => "registration", :description => "Blah Blah Blah" })
UI::Calendar::Event.new(Time.now..(Time.now + 1000), "Game", { :type => "football", :description => "Blah!" })

## UI::Calendar

c = UI::Calendar.new [event1, event2]
c.to_s # :view => :calendar, :start => first_event, :end => last_event
c.to_s :view => :plain
c.to_s :view => :list
c.to_s :view => :calendar
c.to_s :view => :list, :start => Date.now - 10
c.to_s :start => Date.now - 10, :end => Date.now

<table class="calendar">
  <thead>
    <tr>
      <th>Mon</th>
      <th>Tue</th>
      <th>Wed</th>
      <th>Thu</th>
      <th>Fri</th>
      <th>Sat</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>
        <span class="date">1</span>
        <span class="event milestone">Position Opened</span>
      </td>
    </tr>
  </tbody>
</table>