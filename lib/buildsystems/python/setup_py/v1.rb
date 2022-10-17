require 'buildsystems/python/common'

class Setup_py_v1 < Python_common
  @_buildsystems_python_setup_py_version = '1.0.0'

  def self.svem?(bool = true)
    @svem = bool
    return @svem
  end

  depends_on @python
  depends_on "#{@minipython}_setuptools" => :build
  depends_on "#{@minipython}_wheel" => :build

  def self.preflight
    if File.exist?('pyproject.toml')
      puts 'WARNING: Found pyproject.toml, and you are attempting to set up with setup.py.'.lightred
      puts 'It is STRONGLY recommended to use pyproject.toml if possible.'.lightred
      puts 'If you are not a Chromebrew developer, you may safely avoid this message.'.lightred
    end
  end

  def self.build
    system "#{@python} setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    @py_setup_install_options = if @svem
                                  PY_SETUP_INSTALL_OPTIONS
                                else
                                  PY_SETUP_INSTALL_OPTIONS_NO_SVEM
                                end
    system "#{@python} setup.py install #{@py_setup_install_options}"
  end
end
