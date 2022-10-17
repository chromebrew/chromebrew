require 'package'

class Python_v1 < Package
  @_buildsystems_python_setup_py_version = '1.0.0'

  def self.svem?(bool = true)
    return (@svem = bool)
  end

  def self.pyver(string = '3')
    return (@pyver = string)
  end

  def self.python_imp(str = 'python')
    return (@python_imp = str)
  end

  def self.python
    return (@python = @python_imp + @pyver)
  end

  def self.minipython
    case @python
    when /^python/
      minipython = "py#{@pyver}"
    when /^pypy/
      minipython = "pypy#{@pyver}"
    when /^jython/
      minipython = "jpy#{@pyver}"
    end
    return (@minipython = minipython)
  end

  depends_on "#{@python}"
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
    pyver
    python_imp
    python
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

  # Massive amounts of check logic
  def self.check?(bool = true)
    return (@check = bool)
  end

  # Allow the packager to specify the type of test to be run
  def self.check_type(packager_test = nil)
    python_test_types = ['tox', \
                         'pytest', \
                         'setup.py test', \
                         'ptr', \
                         'invoke', \
                         'nox', \
                         'unittest', \
                         'other']
    if python_test_types.include? packager_test
      check_type = packager_test
    elsif packager_test.nil?
      check_type = nil
    else
      abort "check_type is set to an invalid value. Please pick one of #{python_test_types}."
    end
    return (@check_type = check_type)
  end

  # If the user needs to pass extra operands, use this function
  def self.additional_arguments(additional_arguments = '')
    return (@additional_arguments = additional_arguments)
  end

  def guess_action
    guess_action = if File.exist? 'tasks.py'
                     "#{@python} -m invoke"
                   elsif File.exist? 'pytest.ini'
                     "#{@python} -m pytest"
                   elsif File.exist? 'tox.ini'
                     "#{@python} -m tox"
                   elsif File.exist? 'noxfile.py'
                     "#{@python} -m nox"
                   elsif File.exist? '.ptrconfig'
                     "#{@python} -m ptr"
    # Default to pytest, as it is the most common
                   else
                     "#{@python} -m pytest"
                   end
    return (@guess_action = guess_action)
  end

  # Decide what to do with the information from check_type
  def check_action(check_action = nil)
    case @check_type
    when 'pytest', 'ptr', 'nose', 'unittest', 'invoke', 'nox', 'tox'
      check_action = "#{@python} -m #{@check_type} #{@additional_arguments}"
    when 'setup.py test'
      check_action = "#{@python} setup.py test #{@additional_arguments}"
    when 'other'
      check_action = "#{check_action} #{@additional_arguments}"
    when nil # Guess what type of test to use (beta)
      check_action = guess_action
    end
    return (@check_action = check_action)
  end

  if @check
    def self.check
      # How should we check the script?
      system @check_action
    end
  end
end
