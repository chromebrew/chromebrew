require 'buildsystems/cmake'

class Clamav < CMake
  description 'ClamAV is an open source antivirus engine for detecting trojans, viruses, malware & other malicious threats.'
  homepage 'https://www.clamav.net/'
  version '1.5.5'
  license 'GPL-2'
  compatibility 'all'
  source_url "https://www.clamav.net/downloads/production/clamav-#{version}.tar.gz"
  source_sha256 '90284644e5568732c15fc4f4312fd0f09ac14c14e5b29fba3909d4da4e281b1e'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '33953b02cadb7e9d86c8a014ddd34a39ef723760bd2995ed1dd5fb549fa0294d',
     armv7l: '33953b02cadb7e9d86c8a014ddd34a39ef723760bd2995ed1dd5fb549fa0294d',
       i686: '7594504649d0f44bbc5b883354a8254dde4b5dd156937422fc6768e8157b6f4c',
     x86_64: '558f832c92c03b991a997fa43e3b42f031799fc573f842864bfde8bdc8cc472b'
  })

  depends_on 'bzip2' => :library
  depends_on 'check' => :build
  depends_on 'curl' => :library
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'json_c' => :library
  depends_on 'libiconv' => :build
  depends_on 'libxml2' => :library
  depends_on 'ncurses' => :executable
  depends_on 'openssl' => :library
  depends_on 'pcre2' => :library
  depends_on 'psmisc' => :executable
  depends_on 'py3_pytest' => :build
  depends_on 'rust' => :build
  depends_on 'zlib' => :library

  cmake_options "-DAPP_CONFIG_DIRECTORY=#{CREW_PREFIX}/etc/clamav \
    -DDATABASE_DIRECTORY=#{CREW_PREFIX}/share/clamav \
    -DENABLE_JSON_SHARED=ON \
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
