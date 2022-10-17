require 'package'

# This file holds functions common to all Python buildsystems
class Python_common < Package

  # Python version defaults to 3, 2 is still an option
  def self.python_version (pyversion = '3')
    @pyversion = pyversion
    return @pyversion
  end

  # In case we ever implement another python implementation, like PyPy
  def self.python_implementation (pyimplementation = "python")
    @python = pyimplementation + pyversion
    return @python
  end

  case @minipython
  when @python =~ /^python/
    @minipython = "py" + @pyversion
  when @python =~ /^pypy/
    @minipython = "pypy" + @pyversion
  when @python =~ /^jython/
    @minipython = "jpy" + @pyversion
  end
end