require 'package'

class Nuitka < Package
  description 'nuitka is a Python to binary compiler written in Python. You feed it your Python app, it does a lot of clever things, and spits out an executable or extension module.'
  homepage 'https://nuitka.net/'
  version '0.6.12.3'
  compatibility 'all'
  source_url 'https://github.com/Nuitka/Nuitka/archive/0.6.12.3.tar.gz'
  source_sha256 '4f65349b87c3ffc297e19251308d743ee8b5ef09b695c134d6a46ec89d255216'

  def self.install
    system "python3 -m pip install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR} -I nuitka==#{version} --no-warn-script-location"
  end
end
