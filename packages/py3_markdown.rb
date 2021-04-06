require 'package'

class Py3_markdown < Package
  description 'Python markdown is a python implementation of John Gruber’s markdown with extension support. '
  homepage 'https://python-markdown.github.io/'
  version '3.3.4'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/Python-Markdown/markdown/archive/3.3.4.tar.gz'
  source_sha256 'dcba963ea6d47d845aaa5d169911052985eec90d50267850c5c4c4fb4b05eff7'

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
