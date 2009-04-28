module UI
  class AccountNavigation

    def self.links
      @links ||= []
    end

    def initialize(context)
      @context = context
    end

    def to_s
      @to_s ||= Harbor::View.new("ui/account_navigation.html.erb", @context).to_s
    end
  end
end