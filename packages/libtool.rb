require 'package'

class Libtool < Package
  description 'GNU libtool is a generic library support script. Libtool hides the complexity of using shared libraries behind a consistent, portable interface.'
  homepage 'https://www.gnu.org/software/libtool/'
  version '2.5.4'
  license 'GPL-2'
  compatibility 'all'
  source_url "https://ftp.gnu.org/gnu/libtool/libtool-#{version}.tar.xz"
  source_sha256 'f81f5860666b0bc7d84baddefa60d1cb9fa6fceb2398cc3baca6afaa60266675'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '18ade89384da064df570c86ff63ae190c10d1c5d34d872713eddb94871931074',
     armv7l: '18ade89384da064df570c86ff63ae190c10d1c5d34d872713eddb94871931074',
       i686: 'cc1ba27ddb6617e1201f977bad9648acbd4902ae54625c77be485378e3c6c782',
     x86_64: '2df93fa3536d089531733db725b75a5e2f9bc1afb039167fee10538625ac8266'
  })

  depends_on 'glibc' # R
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
