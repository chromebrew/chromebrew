require 'package'
require 'buildsystems/python/common'

class Python_build_v1 < Python_common
  @_buildsystems_python_pyproject_toml_version = '1.0.0'

  depends_on "#{@python}"
  depends_on "#{@minipython}_build" => :build
  depends_on "#{@minipython}_compile" => :build
  depends_on "#{@minipython}_installer" => :build
  depends_on "#{@minipython}_wheel" => :build

  def self.build
    system "#{@python} -m build #{PY3_BUILD_OPTIONS}"
    system "#{@python} -m compile #{PY3_COMPILE_OPTIONS}"
  end

  def self.install
    system "#{@python} -m installer #{PY3_INSTALLER_OPTIONS}"
  end
end
