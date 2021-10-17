require 'package'

class Setup_py_v1 < Package
  @_buildsystems_setup_py_version = '1.0.0'

  def self.check? (bool)
    @check = bool
    return @check
  end

  def self.svem? (bool)
    @svem = bool
    return @svem
  end

  def self.python_version (pyversion)
    if pyversion == '2'
      @python = 'python2'
    elsif pyversion == '3'
      @python = 'python3'
    end
    @python
  end

  def self.build
    system "#{@python} setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    if @svem == false
      @py_setup_install_options = PY_SETUP_INSTALL_OPTIONS_NO_SVEM
    else
      @py_setup_install_options = PY_SETUP_INSTALL_OPTIONS
    end
    system "#{@python} setup.py install #{@py_setup_install_options}"
  end
end
