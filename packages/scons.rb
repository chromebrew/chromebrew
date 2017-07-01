require 'package'

class Scons < Package
  description 'SCons is an Open Source software construction tool that is, a next-generation build tool.'
  homepage 'http://scons.org/'
  version '2.5.1'
  source_url 'http://prdownloads.sourceforge.net/scons/scons-2.5.1.tar.gz'
  source_sha256 '0b25218ae7b46a967db42f2a53721645b3d42874a65f9552ad16ce26d30f51f2'

  depends_on 'python27'

  def self.build
    nil
  end

  def self.install
    system "python2.7 setup.py install --prefix=/usr/local --root=#{CREW_DEST_DIR}"
  end
end
