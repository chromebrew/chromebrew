require 'package'

class Nuitka < Package
  description 'nuitka is a Python to binary compiler written in Python. You feed it your Python app, it does a lot of clever things, and spits out an executable or extension module.'
  homepage 'https://nuitka.net/'
  version '0.6.13.2'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/Nuitka/Nuitka/archive/refs/tags/0.6.13.2.tar.gz'
  source_sha256 'a594d054255688dbef8f8ba5b6cbb0207ad467384f2a6214522781ffbd5d43e5'

  def self.install
    system "python3 -m pip install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR} -I nuitka==#{version} --no-warn-script-location"
  end
end
