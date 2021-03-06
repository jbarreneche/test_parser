module RSpec

  def self.world=(new_world)
    @world = new_world
  end

  def self.with_world(world)
    old_world, self.world = self.world, world
    result = yield(world)
    self.world = old_world
    result
  end

end

RSpec::Core::Runner.disable_autorun!