require 'package'

class Setuptools < Package
  description 'Easily download, build, install, upgrade, and uninstall Python packages'
  homepage 'https://pypi.org/project/setuptools/'
  version '50.3.2'
  compatibility 'all'
  source_url 'https://github.com/pypa/setuptools/archive/v50.3.2.tar.gz'
  source_sha256 '7d97c001ce9193c6d947bc584b6a19f593e1d2dd4d6c443de3b1e545875bc132'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/setuptools-50.3.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/setuptools-50.3.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/setuptools-50.3.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/setuptools-50.3.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'bb3de709aa29d38537d1690bd3c3b75aa213f7afbe1e60e883d85dc926fc5aec',
     armv7l: 'bb3de709aa29d38537d1690bd3c3b75aa213f7afbe1e60e883d85dc926fc5aec',
       i686: 'bfb77f5a9fe09deefdc4cec86c8424d1f3d7d3c3e575865d0a50ed406fc4f03c',
     x86_64: '2900eaa2a0cda2be9c692f673e72f95cf25a6267794b170dd0f7a1b10f362bff',
  })

  depends_on 'python27'
  depends_on 'python3'

  def self.build
    system 'python3 bootstrap.py'
  end

  def self.install
    # Now let python3 pip install and overwrite pip, leaving pip2 for python27
    system "python3 setup.py install --root=#{CREW_DEST_DIR} --prefix=#{CREW_PREFIX}"
    # Install pip for python2 using the last supported systemtools version (<=v45) for python27.
    system "pip2 install setuptools==44.1.1 --root=#{CREW_DEST_DIR} --prefix=#{CREW_PREFIX}"
  end
end
