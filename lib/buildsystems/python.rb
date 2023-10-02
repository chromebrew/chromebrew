require 'package'

class Python < Package
  property :python_build_options
  property :python_install_options
  property :no_svem

  depends_on 'python3'

  def self.build
    puts "Python build options being used: #{PY3_SETUP_BUILD_OPTIONS} #{@python_build_options}".orange
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS} #{@python_build_options}"
  end

  def self.install
    @py_setup_install_options = @no_svem.empty? ? PY_SETUP_INSTALL_OPTIONS.to_s : PY_SETUP_INSTALL_OPTIONS_NO_SVEM.to_s
    puts "Python install options being used: #{@py_setup_install_options} #{@python_install_options}".orange
    system "python3 setup.py install #{@py_setup_install_options} #{@python_install_options}"
  end
end
