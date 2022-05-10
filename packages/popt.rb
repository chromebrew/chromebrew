require 'package'

class Popt < Package
  description 'Library for parsing command line options'
  homepage 'https://directory.fsf.org/wiki/Popt'
  version '1.18-7182e46'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/rpm-software-management/popt.git'
  git_hashtag '7182e4618ad5a0186145fc2aa4a98c2229afdfa8'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/popt/1.18-7182e46_armv7l/popt-1.18-7182e46-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/popt/1.18-7182e46_armv7l/popt-1.18-7182e46-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/popt/1.18-7182e46_i686/popt-1.18-7182e46-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/popt/1.18-7182e46_x86_64/popt-1.18-7182e46-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '5bc51a9e367fac643a4c39acf250d8989c606c3d49c5ee41a662911acfc6863d',
     armv7l: '5bc51a9e367fac643a4c39acf250d8989c606c3d49c5ee41a662911acfc6863d',
       i686: '3ef4682d25a75e2d3464a5479744d9bd57473e9e303d1161fa4a2945752d3eb5',
     x86_64: '93a2f1c02bda8ceee0c4cec070eab58bb997ba1a80e5cd0c37d4052464da4ce2'
  })

  depends_on 'glibc' # R
  depends_on 'gcc12' if ARCH == 'i686' # R

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
