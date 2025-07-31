require 'buildsystems/cmake'

class Clamav < CMake
  description 'ClamAV is an open source antivirus engine for detecting trojans, viruses, malware & other malicious threats.'
  homepage 'https://www.clamav.net/'
  version '1.4.3'
  license 'GPL-2'
  compatibility 'all'
  source_url "https://www.clamav.net/downloads/production/clamav-#{version}.tar.gz"
  source_sha256 'd874cabf3d4765b35b518ef535658a1e6ec74802006a1d613f9f124aa1343210'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c79597e6bff782412d637d46de471e73cdc2853049e2d8ad558583d0c2365ede',
     armv7l: 'c79597e6bff782412d637d46de471e73cdc2853049e2d8ad558583d0c2365ede',
       i686: '7d24cd9a26466146d9df9dee6ba0815bed17a492b8059fa433fcd809199e0f63',
     x86_64: '9d30b61e19ae2ac8d71d87ce20078cf7b04e206a3e7aff290c31a0a520ae5986'
  })

  depends_on 'bzip2' # R
  depends_on 'check' => :build
  depends_on 'curl' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libiconv' => :build
  depends_on 'libxml2' # R
  depends_on 'ncurses' # R
  depends_on 'openssl' # R
  depends_on 'pcre2' # R
  depends_on 'py3_pytest' => :build
  depends_on 'rust' => :build
  depends_on 'zlib' # R

  cmake_options "-DAPP_CONFIG_DIRECTORY=#{CREW_PREFIX}/etc/clamav \
    -DCMAKE_C_FLAGS=-fPIC \
    -DDATABASE_DIRECTORY=#{CREW_PREFIX}/share/clamav \
    -DENABLE_JSON_SHARED=OFF \
    -DENABLE_MILTER=OFF \
    -DENABLE_STATIC_LIB=ON \
    -DENABLE_SYSTEMD=OFF"

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
