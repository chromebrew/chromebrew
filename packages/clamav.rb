require 'buildsystems/cmake'

class Clamav < CMake
  description 'ClamAV is an open source antivirus engine for detecting trojans, viruses, malware & other malicious threats.'
  homepage 'https://www.clamav.net/'
  version '1.5.1'
  license 'GPL-2'
  compatibility 'all'
  source_url "https://www.clamav.net/downloads/production/clamav-#{version}.tar.gz"
  source_sha256 '64fe4a16a5622c1d71efe9ed7f2c2fbd37f8f237da9f11ff66b73038df71db91'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c0db3aab369545201accb021a6c1fd6a04d618b4f59ae792fa5d850b4f5f9d6c',
     armv7l: 'c0db3aab369545201accb021a6c1fd6a04d618b4f59ae792fa5d850b4f5f9d6c',
       i686: 'b9bb06591614920d105386eb4cfa192f3a36f05c2fe4e95c69920fc46a90c85e',
     x86_64: '83d74f2a4797944f96952ccfd74ece4d7fce04c23f47f0a44dab285bb5bbc6e8'
  })

  depends_on 'bzip2' # R
  depends_on 'check' => :build
  depends_on 'curl' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'json_c' # R
  depends_on 'libiconv' => :build
  depends_on 'libxml2' # R
  depends_on 'ncurses' # R
  depends_on 'openssl' # R
  depends_on 'pcre2' # R
  depends_on 'psmisc' # R
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

      To stop the clamav daemon, execute the following:
      sudo killall clamd

      To modify the clamav config, edit the following:
      #{CREW_PREFIX}/etc/clamav/clamd.conf
      #{CREW_PREFIX}/etc/clamav/freshclam.conf
    EOM
  end

  def self.postremove
    Package.agree_to_remove("#{CREW_PREFIX}/share/clamav")
  end
end
