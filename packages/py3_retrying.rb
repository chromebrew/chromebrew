require 'package'

class Py3_retrying < Package
  description 'Retrying is a general-purpose retrying library for python.'
  homepage 'https://github.com/rholder/retrying/'
  version '1.3.3'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/rholder/retrying/archive/v1.3.3.tar.gz'
  source_sha256 '6a73d0210bf515e5cc5c5eadc8f2ee9dfb805b638d8b8514086128d3f411a49a'

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
