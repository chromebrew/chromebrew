require 'buildsystems/autotools'

class Bacula < Autotools
  description 'Bacula is a set of computer programs that permits the system administrator to manage backup, recovery, and verification of computer data across a network of computers of different kinds.'
  homepage 'https://www.bacula.org/'
  version '17.0.0'
  license 'AGPL-3'
  compatibility 'x86_64'
  source_url 'https://gitlab.bacula.org/bacula-community-edition/bacula-community.git'
  git_hashtag "Release-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
     x86_64: 'c1b245c79892c1d10843c6c615d9e0e9f2ee5008a4ccbddf6264efbe3470d622'
  })

  depends_on 'acl' => :executable
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libcap' => :library
  depends_on 'lzo'
  depends_on 'lzo' => :executable
  depends_on 'mysql' => :library
  depends_on 'openssl' => :library
  depends_on 'sommelier' => :logical
  depends_on 'tcpwrappers' => :library
  depends_on 'zlib' => :library
  depends_on 'zstd' => :library

  autotools_build_relative_dir 'bacula'
  autotools_configure_options "--sbindir=#{CREW_PREFIX}/bin \
    --enable-smartalloc \
    --with-mysql \
    --with-tcp-wrappers \
    --with-pid-dir=#{CREW_PREFIX}/var/run \
    --with-subsys-dir=#{CREW_PREFIX}/var/run/subsys \
    --with-working-dir=#{CREW_PREFIX}/var/run/bacula \
    --with-dump-email=#{USER}@localhost \
    --with-job-email=#{USER}@localhost"
end
