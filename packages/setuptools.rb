require 'package'

class Setuptools < Package
  description 'Easily download, build, install, upgrade, and uninstall Python packages'
  homepage 'https://pypi.org/project/setuptools/'
  version '46.1.3'
  source_url 'https://github.com/pypa/setuptools/archive/v46.1.3.tar.gz'
  source_sha256 '984eeb7909fa610a441711c00dc4fa5bbf3c49f9b4b5204b56b7362bdd04f397'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'python27'
  depends_on 'python3'

  def self.build
    system 'python3 bootstrap.py'
  end

  def self.install
    system "python2 setup.py install --root #{CREW_DEST_DIR} --prefix #{CREW_PREFIX}"
    system "python3 setup.py install --root #{CREW_DEST_DIR} --prefix #{CREW_PREFIX}"
  end
end
