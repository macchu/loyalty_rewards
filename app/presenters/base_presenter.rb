# From http://railscasts.com/episodes/287-presenters-from-scratch?view=asciicast
class BasePresenter
  def initialize(object, template)
    @object = object
    @template = template
  end
  
  def self.presents(name)
    define_method(name) do
      @object
    end
  end
  
  def h
    @template
  end
end