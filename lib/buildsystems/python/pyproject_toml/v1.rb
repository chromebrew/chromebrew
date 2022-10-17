require 'buildsystems/python/common'

class Pyproject_toml_v1 < Pycommon
  @_buildsystems_python_pyproject_toml_version = '1.0.0'

  depends_on $python
  depends_on "#{$minipython}_build" => :build
  depends_on "#{$minipython}_compile" => :build
  depends_on "#{$minipython}_installer" => :build
  depends_on "#{$minipython}_wheel" => :build

  if @_ver
    @pretend_version = @_ver
  else
    @pretend_version = @pkg.version
    puts 'Could not find @_ver, setting SETUPTOOLS_SCM_PRETEND_VERSION to @pkg.version.'.yellow
    puts 'This may not be what you want.'.yellow
  end
  BUILD_ENV_OPTIONS = "SETUPTOOLS_SCM_PRETEND_VERSION=#{@pretend_version}"

  def self.build
    system "#{BUILD_ENV_OPTIONS} #{$python} -m build #{PY3_BUILD_OPTIONS}"
    system "#{$python} -m compile #{PY3_COMPILE_OPTIONS}"
  end

  def self.install
    system "#{$python} -m installer #{PY3_INSTALLER_OPTIONS}"
  end
end
