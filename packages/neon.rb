require 'package'

class Neon < Package
  description 'neon is an HTTP and WebDAV client library, with a C interface.'
  homepage 'http://www.webdav.org/neon/'
  version '0.31.2'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/notroj/neon.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/neon/0.31.2_armv7l/neon-0.31.2-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/neon/0.31.2_armv7l/neon-0.31.2-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/neon/0.31.2_x86_64/neon-0.31.2-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '8da405951069b5143951dc15799a5367d8e5b752e85c31bc39b22ec32a40dcb7',
     armv7l: '8da405951069b5143951dc15799a5367d8e5b752e85c31bc39b22ec32a40dcb7',
     x86_64: 'cee9c8e0ace8b92c29bfb0f9e4592b93ba31f9fcfc5f0ad52910bb0b71d2f44b'
  })

  depends_on 'xmlto' => :build

  def self.build
    system './autogen.sh'
    system 'filefix'
    system "#{CREW_ENV_OPTIONS} ./configure \
            #{CREW_OPTIONS} \
           --enable-shared=yes \
           --with-ssl=openssl"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install-lib', 'install-headers', 'install-config'
    Dir.chdir(CREW_DEST_LIB_PREFIX) do
      FileUtils.ln_s "#{CREW_LIB_PREFIX}/libneon.so", 'neon.so'
    end
  end
end
