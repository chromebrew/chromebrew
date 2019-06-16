require 'package'

class Scons < Package
  description 'SCons is an Open Source software construction tool that is, a next-generation build tool.'
  homepage 'http://scons.org/'
  version '3.0.5'
  source_url 'https://prdownloads.sourceforge.net/scons/scons-3.0.5.tar.gz'
  source_sha256 'df676f23dc6d4bfa384fc389d95dcd21ab907e6349d4c848958ba4befb73c73e'

  depends_on 'python27'

  def self.build
    nil
  end

  def self.install
    system "python2.7 setup.py install --prefix=#{CREW_PREFIX} --root=#{CREW_DEST_DIR}"
  end
end
