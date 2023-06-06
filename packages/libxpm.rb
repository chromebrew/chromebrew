require 'package'

class Libxpm < Package
  description 'X.org X Pixmap Library'
  homepage 'https://www.x.org'
  version '3.5.15'
  license 'custom'
  compatibility 'all'
  source_url 'https://www.x.org/archive/individual/lib/libXpm-3.5.15.tar.gz'
  source_sha256 '2a9bd419e31270593e59e744136ee2375ae817322447928d2abb6225560776f9'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxpm/3.5.15_armv7l/libxpm-3.5.15-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxpm/3.5.15_armv7l/libxpm-3.5.15-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxpm/3.5.15_i686/libxpm-3.5.15-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxpm/3.5.15_x86_64/libxpm-3.5.15-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'dda20cb64733b2ad86fd1073547056006b0e4214f86a0fcf72cebfa309d5bc29',
     armv7l: 'dda20cb64733b2ad86fd1073547056006b0e4214f86a0fcf72cebfa309d5bc29',
       i686: '6b1e51fbcf3ae2ea5a21ffa84ea8815f0dee3db6a0c8fd89bccd8792f8388a3c',
     x86_64: 'c154aa0ff14f8fffd52031e56362e48dbdf6217c84a99e5bf9e0bc4598a8a661'
  })

  depends_on 'libx11'
  depends_on 'util_macros'
  depends_on 'gettext'
  depends_on 'glibc' # R
  depends_on 'libbsd' # R
  depends_on 'libmd' # R
  depends_on 'libxau' # R
  depends_on 'libxcb' # R
  depends_on 'libxdmcp' # R
  depends_on 'ncompress' => :build
  depends_on 'gcc_lib' # R

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
