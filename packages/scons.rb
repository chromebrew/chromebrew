require 'package'

class Scons < Package
  description 'SCons is an Open Source software construction tool that is, a next-generation build tool.'
  homepage 'http://scons.org/'
  version '3.0.1'
  source_url 'https://prdownloads.sourceforge.net/scons/scons-3.0.1.tar.gz'
  source_sha256 '24475e38d39c19683bc88054524df018fe6949d70fbd4c69e298d39a0269f173'

  depends_on 'python27'

  def self.build
    nil
  end

  def self.install
    system "python2.7 setup.py install --prefix=#{CREW_PREFIX} --root=#{CREW_DEST_DIR}"
  end
end
