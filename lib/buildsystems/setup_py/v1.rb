require 'package'

class Setup_py_v1 < Package
  @_buildsystems_setup_py_version = '1.0.0'

  def self.svem? (bool = true)
    @svem = bool
    return @svem
  end

  def self.python_version (pyversion = '3')
    @python = 'python' + pyversion
    return @python
  end

  def self.build
    if @python == nil
      @python = 'python3'
    end
    system "#{@python} setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    unless @svem
      @py_setup_install_options = PY_SETUP_INSTALL_OPTIONS_NO_SVEM
    else
      @py_setup_install_options = PY_SETUP_INSTALL_OPTIONS
    end
    system "#{@python} setup.py install #{@py_setup_install_options}"
  end
end
