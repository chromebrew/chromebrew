require 'package'

class Six < Package
  description 'Six is a Python 2 and 3 compatibility library.'
  homepage 'https://github.com/benjaminp/six'
  version '1.12.0'
  source_url 'https://github.com/benjaminp/six/archive/1.12.0.tar.gz'
  source_sha256 '0ce7aef70d066b8dda6425c670d00c25579c3daad8108b3e3d41bef26003c852'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'python3'
  depends_on 'python27'

  def self.build
    system "python2.7 setup.py build"
    system "python3 setup.py build"
  end

  def self.install
    system "python2.7 setup.py install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR}"
    system "python3 setup.py install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR}"
  end
end
