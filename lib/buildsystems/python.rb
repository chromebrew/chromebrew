require 'package'
require 'require_gem'

class Python < Package
  property :python_build_extras, :python_build_options, :python_build_relative_dir, :python_install_extras, :python_install_options, :python_no_svem

  def self.build
    method_list = methods.grep(/#{superclass.to_s.downcase}_/).delete_if { |i| send(i).blank? }
    return if method_list.empty?

    require_gem 'method_source'
    method_blocks = []
    method_strings = []
    method_list.sort.each do |method|
      @method_info = send method
      if @method_info.is_a? String
        method_strings << "#{method}: #{@method_info}".orange
      else
        method_blocks << @method_info.source.to_s.orange
      end
    end
    puts "Additional #{superclass.to_s.capitalize} options being used:".orange
    puts method_strings
    puts method_blocks

    @python_build_relative_dir ||= '.'
    Dir.chdir(@python_build_relative_dir) do
      if File.file?('setup.py')
        puts "Python build options being used: #{PY3_SETUP_BUILD_OPTIONS} #{@python_build_options}".orange
        puts "MAKEFLAGS=-j#{CREW_NPROC} python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS} #{@python_build_options}" if CREW_VERBOSE
        system "MAKEFLAGS=-j#{CREW_NPROC} python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS} #{@python_build_options}"
      else
        puts "Python build options being used: #{PY3_BUILD_OPTIONS}".orange
        puts "MAKEFLAGS=-j#{CREW_NPROC} python3 -m build #{PY3_BUILD_OPTIONS}" if CREW_VERBOSE
        system "MAKEFLAGS=-j#{CREW_NPROC} python3 -m build #{PY3_BUILD_OPTIONS}"
      end
      @python_build_extras&.call
    end
  end

  def self.install
    Dir.chdir(@python_build_relative_dir) do
      if File.file?('setup.py')
        @py_setup_install_options = @python_no_svem ? PY_SETUP_INSTALL_OPTIONS_NO_SVEM : PY_SETUP_INSTALL_OPTIONS
        puts "Python install options being used: #{@py_setup_install_options} #{@python_install_options}".orange
        puts "MAKEFLAGS=-j#{CREW_NPROC} python3 setup.py install #{@py_setup_install_options} #{@python_install_options}" if CREW_VERBOSE
        system "MAKEFLAGS=-j#{CREW_NPROC} python3 setup.py install #{@py_setup_install_options} #{@python_install_options}"
      else
        puts "Python install options being used: #{PY3_INSTALLER_OPTIONS}".orange
        puts "MAKEFLAGS=-j#{CREW_NPROC} python3 -m installer #{PY3_INSTALLER_OPTIONS}" if CREW_VERBOSE
        system "MAKEFLAGS=-j#{CREW_NPROC} python3 -m installer #{PY3_INSTALLER_OPTIONS}"
      end
      @python_install_extras&.call
    end
  end
end
