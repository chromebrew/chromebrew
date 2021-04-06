require 'package'

class Py3_pymdown_extensions < Package
  description 'Pymdown is an extension pack for Python Markdown.'
  homepage 'https://facelessuser.github.io/pymdown-extensions/'
  version '8.1.1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/facelessuser/pymdown-extensions/archive/8.1.1.tar.gz'
  source_sha256 '951064eda88e5610ab90190a4486d340c0d17650af4420ea5497ceaa4d5c0f73'

  depends_on 'py3_markdown'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
