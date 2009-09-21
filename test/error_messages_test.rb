require "pathname"
require Pathname(__FILE__).dirname + "test_helper"

class ErrorMessagesTest < Test::Unit::TestCase
  
  def test_error_messages_renders_empty_string_when_no_errors_are_found
    messages = UI::ErrorMessages.new(nil, "El autobus es en fuego.", Harbor::Errors.new)
    assert_equal('', messages.to_s)
  end
  
  def test_error_message_renders_all_errors
    errors = Harbor::Errors.new([
      "Some simple error message",
      UI::ErrorMessages::FormFieldError.new('login', 'user_login', 'Login is invalid'),
      UI::ErrorMessages::FormFieldError.new('first_name', 'user_first_name', 'First name is invalid')
    ])
    
    output = UI::ErrorMessages.new(nil, "El autobus es en fuego.", errors).to_s

    assert_match(/El\sautobus\ses\sen\sfuego/, output.to_s)
    assert_match(/Some\ssimple\serror\smessage/, output.to_s)
    assert_match(/Login\sis\sinvalid/, output.to_s)
    assert_match(/First\sname\sis\sinvalid/, output.to_s)
  end
  
  def test_datamapper_errors
    dm_user = new_dm_user
    dm_user.errors.add("login", "Login is invalid")
    dm_user.errors.add("first_name", "First name is invalid")

    errors = UI::ErrorMessages::DataMapperErrors.new(dm_user)

    assert(errors.detect { |e| e.object_field == 'login' })
    assert(errors.detect { |e| e.form_field_id == 'some_user_login' })
    assert(errors.detect { |e| e.message == 'Login is invalid' })

    assert(errors.detect { |e| e.object_field == 'first_name' })
    assert(errors.detect { |e| e.form_field_id == 'some_user_first_name' })
    assert(errors.detect { |e| e.message == 'First name is invalid' })
  end

  def test_datamapper_errors_can_be_empty
    dm_user = new_dm_user
    errors = UI::ErrorMessages::DataMapperErrors.new(dm_user)

    assert_equal(0, errors.size)
  end
  
  def test_datamapper_errors_accepts_nulls
    errors = UI::ErrorMessages::DataMapperErrors.new(nil)

    assert_equal(0, errors.size)
  end

  private

  def new_dm_user
    begin
      gem "dm-core"
      require "dm-core"

      gem "dm-validations"
      require "dm-validations"
    rescue
      flunk "Please install dm-core and dm-validations: #{$!}\n#{$!.backtrace.join("\n\t")}"
    end

    Class.new do
      include DataMapper::Resource
      
      property :id, Integer, :key => true
      property :login, String
      property :first_name, String
      
      def self.to_s
        'SomeUser'
      end
    end.new
  end

end