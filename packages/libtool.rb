require 'package'

class Libtool < Package
  description 'GNU libtool is a generic library support script. Libtool hides the complexity of using shared libraries behind a consistent, portable interface.'
  homepage 'https://www.gnu.org/software/libtool/'
  version '2.6.2'
  license 'GPL-2'
  compatibility 'all'
  source_url "https://ftp.gnu.org/gnu/libtool/libtool-#{version}.tar.xz"
  source_sha256 '2ef1067c16c97db930fd740cc9bc3d3ba9a583804ae5ac42cc3e8719e49e191e'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4244caab67ac15c61707946a9262d4968ac5972779c40bf08f4ddbc524cbcb34',
     armv7l: '4244caab67ac15c61707946a9262d4968ac5972779c40bf08f4ddbc524cbcb34',
       i686: '4a591b118963cae4a217518ae5bbb4f7ca6bd63f2fa0d28b737bf1cda8f3950e',
     x86_64: '45f5d8177ff8f0a1581db666489f3f1d08ec456aa0aaafcba9b49e5c852adec6'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'm4'

  def self.build
    system "./configure #{CREW_CONFIGURE_OPTIONS} \
            --enable-ltdl-install"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    # Some tests fail on arm builds.
    # Link order of deplibs             FAILED (link-order2.at:126)
    # static linking flags for programs FAILED (static.at:177)
    # Run tests with low max_cmd_len    FAILED (cmdline_wrap.at:48)
    # Failure on i686:                   FAILED (lt_dlopenext.at:242)
    system 'make check', exception: false
  end
end
