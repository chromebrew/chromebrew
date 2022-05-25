require 'package'

class Popt < Package
  description 'Library for parsing command line options'
  homepage 'https://directory.fsf.org/wiki/Popt'
  version '1.18-7182e46-1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/rpm-software-management/popt.git'
  git_hashtag '7182e4618ad5a0186145fc2aa4a98c2229afdfa8'
  binary_compression 'tar.xz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/popt/1.18-7182e46-1_armv7l/popt-1.18-7182e46-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/popt/1.18-7182e46-1_armv7l/popt-1.18-7182e46-1-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/popt/1.18-7182e46-1_i686/popt-1.18-7182e46-1-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/popt/1.18-7182e46-1_x86_64/popt-1.18-7182e46-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '9cefdde6c7c465b26348751ddd4d90c21483e31771237534a583fdc95ade39b5',
     armv7l: '9cefdde6c7c465b26348751ddd4d90c21483e31771237534a583fdc95ade39b5',
       i686: '8cbf20d99228e07d40c79f580f3d6f8ba84f9a402acd93203ace8b8248d8037e',
     x86_64: 'a9c888f6b22b88eb5635e17df8c3b2eab6e91539e1a58696336722b0530c5eda'
  })

  depends_on 'glibc' # R
  depends_on 'gcc_lib' unless ARCH == 'x86_64' # R
  no_patchelf
  no_zstd

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
