require 'package'

class Meson < Package
  description 'The Meson Build System'
  homepage 'http://mesonbuild.com/'
  version '0.56.0'
  compatibility 'all'
  source_url 'https://github.com/mesonbuild/meson/archive/0.56.0.tar.gz'
  source_sha256 'a9ca7adf66dc69fbb7e583f7c7aef16b9fe56ec2874a3d58747e69a3affdf300'

  depends_on 'ninja'
  depends_on 'setuptools'

  def self.install
    system "python3 setup.py install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR}"
  end
  
  def self.postinstall
    system "pip3 install --upgrade pip"
    system "pip3 install --upgrade --force-reinstall meson"
  end 
end
