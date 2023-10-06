require 'package'

class Python < Package
  property :python_build_options
  property :python_install_options
  property :no_svem

  depends_on 'python3'

  def self.build
    @required_pip_modules = %w[build installer setuptools wheel pyproject_hooks]
    @pip_list = `pip list --exclude pip`
    @required_pip_modules.each do |pip_pkg|
      unless @pip_list.include?(pip_pkg)
        puts "Installing #{pip_pkg} using pip..."
        system "MAKEFLAGS=-j#{CREW_NPROC} pip install #{pip_pkg}"
      end
    end
    if File.file?('setup.py')
      puts "Python build options being used: #{PY3_SETUP_BUILD_OPTIONS} #{@python_build_options}".orange
      system "MAKEFLAGS=-j#{CREW_NPROC} python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS} #{@python_build_options}"
    else
      puts "Python build options being used: #{PY3_BUILD_OPTIONS}".orange
      system "MAKEFLAGS=-j#{CREW_NPROC} python3 -m build #{PY3_BUILD_OPTIONS}"
    end
  end

  def self.install
    if File.file?('setup.py')
      @py_setup_install_options = @no_svem ? PY_SETUP_INSTALL_OPTIONS_NO_SVEM.to_s : PY_SETUP_INSTALL_OPTIONS.to_s
      puts "Python install options being used: #{@py_setup_install_options} #{@python_install_options}".orange
      system "MAKEFLAGS=-j#{CREW_NPROC} python3 setup.py install #{@py_setup_install_options} #{@python_install_options}"
    else
      puts "Python install options being used: #{PY3_INSTALLER_OPTIONS}".orange
      system "MAKEFLAGS=-j#{CREW_NPROC} python3 -m installer #{PY3_INSTALLER_OPTIONS}"
    end
  end
end
