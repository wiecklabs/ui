module UI
  class AccountNavigation

    def self.links
      @links ||= []
    end

    def self.register(action, url, block=nil)
      links << [action, url, (block||lambda { true })]
    end

    def initialize(context)
      @context = context
    end

    def to_s
      @to_s ||= Harbor::View.new("ui/account_navigation.html.erb", @context).to_s
    end
  end
end