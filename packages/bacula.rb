require 'buildsystems/autotools'

class Bacula < Autotools
  description 'Bacula is a set of computer programs that permits the system administrator to manage backup, recovery, and verification of computer data across a network of computers of different kinds.'
  homepage 'https://www.bacula.org/'
  version '15.0.3'
  license 'AGPL-3'
  compatibility 'x86_64'
  source_url "https://downloads.sourceforge.net/project/bacula/bacula/#{version}/bacula-#{version}.tar.gz"
  source_sha256 '294afd3d2eb9d5b71c3d0e88fdf19eb513bfdb843b28d35c0552e4ae062827a1'
  binary_compression 'tar.zst'

  binary_sha256({
     x86_64: '5fb007691efba2b6dea4c93b4247d1dedd43ce97cb4e4129096ea646ceb6d8b7'
  })

  depends_on 'acl' # R
  depends_on 'libcap' # R
  depends_on 'lzo'
  depends_on 'mysql'
  depends_on 'openssl' # R
  depends_on 'sommelier'
  depends_on 'tcpwrappers'
  depends_on 'zlib' # R
  depends_on 'zstd' # R

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
