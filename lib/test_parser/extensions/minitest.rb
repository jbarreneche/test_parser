module MiniTest
  class Unit
    def self.dont_install_at_exit!
      @@installed_at_exit = true
    end
  end
end