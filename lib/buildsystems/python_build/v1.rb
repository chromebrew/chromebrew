require 'package'

class Python_build_v1 < Package
  @_buildsystems_python_build_version = '1.0.0'

  def self.python_version (pyversion = '3')
    @python = 'python' + pyversion
    return @python
  end

  def self.build
    system "#{@python} -m build #{PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "#{@python} -m installer #{PY3_INSTALLER_OPTIONS}"
  end
end
