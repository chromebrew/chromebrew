# fileutils_glob.rb: Add glob support to FileUtils
require 'fileutils'

module FileUtils
  class << self
    def glob_handler(*args, **opts)
      path_index = %i[chmod chmod_R install].include?(__callee__) ? 1 : 0

      # replace ~ to home directory
      args[path_index][0] = Dir.home if args[path_index][0] == '~'

      # parse glob
      args[path_index] = Dir[args[path_index]]

      # call original method with resolved glob
      send("orig_#{__callee__}", *args, **opts)
    end

    %w[chmod chmod_R cp cp_r install ln ln_s ln_sf mv rm rm_f rm_rf rmdir].each do |method|
      # rename existing methods to orig_#{method_name}
      alias_method "orig_#{method}".to_sym, method.to_sym
      remove_method method.to_sym

      # redirect methods to the glob wrapper
      alias_method method, :glob_handler
    end
  end
end