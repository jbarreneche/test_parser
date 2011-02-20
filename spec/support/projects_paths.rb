require 'pathname'

module ProjectsPaths

  def devotest_path
    Pathname.new File.join(File.dirname(__FILE__), '..', '..')
  end

  def path_for_test_project(*append)
    ([devotest_path, 'test_project'] + append).reduce(:+).cleanpath
  end

end