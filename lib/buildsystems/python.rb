require 'package'

class Python < Package
  property :python_build_options, :python_install_options, :python_build_extras, :python_install_extras, :no_svem

  attr_accessor :python_build_relative_dir

  def initialize
    super
    @python_build_relative_dir = '.'
  end

  def self.build
    # @required_pip_modules = %w[build installer setuptools wheel pyproject_hooks]
    # @pip_list = `pip list --exclude pip`
    # @required_pip_modules.each do |pip_pkg|
    #  unless @pip_list.include?(pip_pkg)
    #    puts "Installing #{pip_pkg} using pip..."
    #    system "MAKEFLAGS=-j#{CREW_NPROC} pip install #{pip_pkg}"
    #  end
    # end
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
        @py_setup_install_options = @no_svem ? PY_SETUP_INSTALL_OPTIONS_NO_SVEM : PY_SETUP_INSTALL_OPTIONS
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
