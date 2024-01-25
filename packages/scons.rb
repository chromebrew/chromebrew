require 'package'

class Scons < Package
  description 'SCons is an Open Source software construction tool that is, a next-generation build tool.'
  homepage 'https://scons.org/'
  license 'MIT'
  version '3.0.5'
  compatibility 'all'
  source_url 'https://prdownloads.sourceforge.net/scons/scons-3.0.5.tar.gz'
  source_sha256 'df676f23dc6d4bfa384fc389d95dcd21ab907e6349d4c848958ba4befb73c73e'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: 'e4498f5a89565452fee2f035af1a9ea37e7c36862c0d8cb3d2e3702faaea3abb',
     armv7l: 'e4498f5a89565452fee2f035af1a9ea37e7c36862c0d8cb3d2e3702faaea3abb',
       i686: '189352c2c7e9263b71e11fe363f6c1c610aa6b6fad280f7347cb7e823544e545',
     x86_64: 'f4cff9a4f35e2feeff5aac3dc49605b645a8362f53a335f37dd49b1dd6f8092c'
  })

  depends_on 'python2'

  def self.build
    nil
  end

  def self.install
    system "python2.7 setup.py install --prefix=#{CREW_PREFIX} --root=#{CREW_DEST_DIR}"
  end
end
