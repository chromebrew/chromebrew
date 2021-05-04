# Adapted from Arch Linux pixz PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/pixz/trunk/PKGBUILD

require 'package'

class Pixz < Package
  description 'Parallel, indexed xz compressor'
  homepage 'https://github.com/vasi/pixz'
  version '1.0.7-0829'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/vasi/pixz.git'
  git_hashtag '0829c7315c804a4e40abd63a9d624194dc1e4f0a'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pixz/1.0.7-0829_armv7l/pixz-1.0.7-0829-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pixz/1.0.7-0829_armv7l/pixz-1.0.7-0829-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pixz/1.0.7-0829_i686/pixz-1.0.7-0829-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pixz/1.0.7-0829_x86_64/pixz-1.0.7-0829-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'b3775ba946ecd95e87b68c8bd2d0c93c78027677eb4de15fc9df5d2e4d80f7c2',
     armv7l: 'b3775ba946ecd95e87b68c8bd2d0c93c78027677eb4de15fc9df5d2e4d80f7c2',
       i686: '8fff1c81a1b0f693a5e6fa592fba32410875e53e754c8b70e9bf5f14f8654627',
     x86_64: '2112ae37128533e88bd492d0aae688028fe7ea8b8149e50c16866aa69f90034e'
  })

  depends_on 'libarchive'
  depends_on 'asciidoc' => ':build'

  def self.build
    system '[ -x configure ] || NOCONFIGURE=1 ./autogen.sh'
    system "#{CREW_ENV_OPTIONS} \
      manpage=true \
      ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
