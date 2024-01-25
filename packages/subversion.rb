require 'package'

class Subversion < Package
  description 'Subversion is an open source version control system.'
  homepage 'https://subversion.apache.org/'
  version '1.9.12'
  license 'Apache-2.0, BSD, MIT, BSD-2, FSFAP and unicode'
  compatibility 'all'
  source_url 'https://www-us.apache.org/dist/subversion/subversion-1.9.12.tar.bz2'
  source_sha256 '3c3a15fd73a21ab55556d7c291cf40e25ade1c070294504aa50b4767db1be397'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '797938b9feb0336b42848540b6fecb5f4474b78df1addc8cc2aefa05cc16796f',
     armv7l: '797938b9feb0336b42848540b6fecb5f4474b78df1addc8cc2aefa05cc16796f',
       i686: 'f6db4dc8a42150902b737c4a12258c3fd0ad6d939c14234ec90d99c5df889e07',
     x86_64: 'c708bfe66744ccb19d7fcf463912a4b27c14fe854d9de83e49cb174baadf5d5e'
  })

  depends_on 'apr_util'
  depends_on 'serf'
  depends_on 'sqlite'

  def self.build
    system './configure', '--disable-static', "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
