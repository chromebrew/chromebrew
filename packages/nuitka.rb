require 'package'

class Nuitka < Package
  description 'nuitka is a Python to binary compiler written in Python. You feed it your Python app, it does a lot of clever things, and spits out an executable or extension module.'
  homepage 'https://nuitka.net/'
  version '0.6.10.5'
  compatibility 'all'
  source_url 'https://github.com/Nuitka/Nuitka/archive/0.6.10.5.tar.gz'
  source_sha256 'e29f150b308d2c388c4faa2b14bf4e2ea5259b3ba996e50a7dbc9ceb0f97cae4'

  def self.install
    system "pip install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR} -I nuitka==#{version} --no-warn-script-location"
  end
end
