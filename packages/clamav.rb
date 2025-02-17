require 'buildsystems/cmake'

class Clamav < CMake
  description 'ClamAV is an open source antivirus engine for detecting trojans, viruses, malware & other malicious threats.'
  homepage 'https://www.clamav.net/'
  version '1.4.2'
  license 'GPL-2'
  compatibility 'all'
  source_url "https://www.clamav.net/downloads/production/clamav-#{version}.tar.gz"
  source_sha256 '8c92f8ade2a8f2c9d6688d1d63ee57f6caf965d74dce06d0971c6709c8e6c04c'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '18d557cc5687cbbf701971891dcc887d966745032f53e93b5bada06a07238ba7',
     armv7l: '18d557cc5687cbbf701971891dcc887d966745032f53e93b5bada06a07238ba7',
       i686: '259d7f16e80d5c13c90322cfaf7f189988b93ec0069904323160d5213d3d2c8c',
     x86_64: 'b409f59d64681ea826f9810faa9bd76c130548b74398de7624208ae8ddf4040b'
  })

  depends_on 'rust' => :build
  depends_on 'libcheck' => :build
  depends_on 'libiconv' => :build
  depends_on 'json_c' => :build
  depends_on 'py3_pytest' => :build
  depends_on 'bzip2' # R
  depends_on 'curl' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libxml2' # R
  depends_on 'ncurses' # R
  depends_on 'openssl' # R
  depends_on 'pcre2' # R
  depends_on 'zlib' # R

  no_shrink

  cmake_options "-D APP_CONFIG_DIRECTORY=#{CREW_PREFIX}/etc/clamav \
    -D DATABASE_DIRECTORY=#{CREW_PREFIX}/share/clamav \
    -D CMAKE_C_FLAGS=-fPIC \
    -D ENABLE_JSON_SHARED=OFF \
    -D ENABLE_STATIC_LIB=ON \
    -D ENABLE_SYSTEMD=OFF \
    -D ENABLE_MILTER=OFF \
    -G Ninja"

  cmake_install_extras do
    FileUtils.cp "#{CREW_DEST_PREFIX}/etc/clamav/clamd.conf.sample", "#{CREW_DEST_PREFIX}/etc/clamav/clamd.conf"
    FileUtils.cp "#{CREW_DEST_PREFIX}/etc/clamav/freshclam.conf.sample", "#{CREW_DEST_PREFIX}/etc/clamav/freshclam.conf"
    system "sed -i 's,^Example,#Example,' #{CREW_DEST_PREFIX}/etc/clamav/clamd.conf"
    system "sed -i 's,^#LocalSocket ,LocalSocket ,' #{CREW_DEST_PREFIX}/etc/clamav/clamd.conf"
    system "sed -i 's,^Example,#Example,' #{CREW_DEST_PREFIX}/etc/clamav/freshclam.conf"
  end

  def self.postinstall
    system 'freshclam' # Create the clamav database.
    ExitMessage.add <<~EOM

      To start the clamav daemon, execute the following:
      sudo clamd &

      To modify the clamav config, edit the following:
      #{CREW_PREFIX}/etc/clamav/clamd.conf
      #{CREW_PREFIX}/etc/clamav/freshclam.conf

    EOM
  end

  def self.postremove
    Package.agree_to_remove("#{CREW_PREFIX}/share/clamav")
  end
end
