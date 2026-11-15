require 'buildsystems/cmake'

class Clamav < CMake
  description 'ClamAV is an open source antivirus engine for detecting trojans, viruses, malware & other malicious threats.'
  homepage 'https://www.clamav.net/'
  version '1.5.4'
  license 'GPL-2'
  compatibility 'all'
  source_url "https://www.clamav.net/downloads/production/clamav-#{version}.tar.gz"
  source_sha256 '1af1117a228f1b5bc7fa91a0dabc37848a99e7d25188e9be8043332ce721dfd3'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '36c0b81ac3e88d55ab21e848b50484df7578524b51f4b0aeb2fbc013bf2c52a5',
     armv7l: '36c0b81ac3e88d55ab21e848b50484df7578524b51f4b0aeb2fbc013bf2c52a5',
       i686: 'a87a01816065f891069a8e6756bc7f2c54fd5b97c02264e757c30f83e89c8dc6',
     x86_64: 'be80ccb967d52328626da29f85b49a9986d186119d6b7004c792855153154f74'
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
