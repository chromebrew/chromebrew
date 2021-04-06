require 'package'

class Py3_toml < Package
  description 'Toml is a python library for Tom\'s Obvious, Minimal Language'
  homepage 'https://github.com/uiri/toml/'
  version '0.10.2'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/uiri/toml/archive/0.10.2.tar.gz'
  source_sha256 '71d4039bbdec91e3e7591ec5d6c943c58f9a2d17e5f6783acdc378f743fcdd2a'

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
