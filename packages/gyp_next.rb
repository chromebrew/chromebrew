require 'package'

class Gyp_next < Package
  description 'GYP can Generate Your Projects'
  homepage 'https://github.com/nodejs/gyp-next'
  version '0.8.1'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/nodejs/gyp-next/archive/v0.8.1.tar.gz'
  source_sha256 '2387f884799b561bc8e4e982e66b8a825147aa17d2d08c42473f08f8152e245a'

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
