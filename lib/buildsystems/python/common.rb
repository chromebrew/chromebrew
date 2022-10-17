require 'package'

# This file holds functions common to all Python buildsystems
class Python_common < Package

  # Python version defaults to 3, 2 is still an option
  def self.python_version(pyversion = '3')
    return (@pyversion = pyversion)
  end

  # In case we ever implement another python implementation, like PyPy
  def self.python_implementation(pyimplementation = 'python')
    return (@python = "#{pyimplementation}#{pyversion}")
  end

  def self.minipython
    case @python
    when /^python/
      @minipython = "py#{@pyversion}"
    when /^pypy/
      @minipython = "pypy#{@pyversion}"
    when /^jython/
      @minipython = "jpy#{@pyversion}"
    end
    return @minipython
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