require 'package'

class Popt < Package
  description 'Library for parsing command line options'
  homepage 'https://directory.fsf.org/wiki/Popt'
  version '1.18-7182e46-1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/rpm-software-management/popt.git'
  git_hashtag '7182e4618ad5a0186145fc2aa4a98c2229afdfa8'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/popt/1.18-7182e46-1_armv7l/popt-1.18-7182e46-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/popt/1.18-7182e46-1_armv7l/popt-1.18-7182e46-1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/popt/1.18-7182e46-1_i686/popt-1.18-7182e46-1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/popt/1.18-7182e46-1_x86_64/popt-1.18-7182e46-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '7f4e3731424ab89c32d4d492715b421f7a2e08ff3722f42db56c116abed0afde',
     armv7l: '7f4e3731424ab89c32d4d492715b421f7a2e08ff3722f42db56c116abed0afde',
       i686: '1d7715334c368c049386f977c50a234f1f9204c829301b1a5482740d526acefe',
     x86_64: 'f97c13e9e22bda93cc219dd899947f2269c2a2e997e713810e9603ad8ba69d6b'
  })

  depends_on 'glibc' # R
  depends_on 'gcc' unless ARCH == 'x86_64' # R
  no_patchelf

  def self.build
    system '[ -x configure ] || NOCONFIGURE=1 ./autogen.sh'
    system "./configure #{CREW_OPTIONS} \
      --disable-maintainer-mode"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
