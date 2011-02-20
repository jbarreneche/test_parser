module RSpec

  def self.world=(new_world)
    @world = new_world
  end

  def self.with_world(world)
    old_world, ::RSpec.world = ::RSpec.world, world
    result = yield(world)
    ::RSpec.world = old_world
    result
  end

end

RSpec::Core::Runner.disable_autorun!