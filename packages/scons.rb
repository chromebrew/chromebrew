require 'package'

class Scons < Package
  description 'SCons is an Open Source software construction tool that is, a next-generation build tool.'
  homepage 'http://scons.org/'
  version '2.5.1'
  source_url 'http://prdownloads.sourceforge.net/scons/scons-2.5.1.tar.gz'
  source_sha1 'f742350251734df75355e51c70f291e119ef927a'

  depends_on 'python27'

  def self.build
    nil
  end

  def self.install
    system "python2.7 setup.py install --prefix=/usr/local --root=#{CREW_DEST_DIR}"
  end
end
