require 'package'

class Scdoc < Package
  description 'A simple man page generator for POSIX systems written in C99'
  homepage 'https://git.sr.ht/~sircmpwn/scdoc/'
  version '1.11.2'
  license 'MIT'
  # source_url 'https://git.sr.ht/~sircmpwn/scdoc.git' # Git url with .git at the end returns 403 Forbidden
  # git_hashtag @_ver
  compatibility 'all'
  source_url "https://git.sr.ht/~sircmpwn/scdoc/archive/#{version}.tar.gz"
  source_sha256 'e9ff9981b5854301789a6778ee64ef1f6d1e5f4829a9dd3e58a9a63eacc2e6f0'
  binary_compression 'tar.zst'

  binary_url({
     aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/scdoc/1.11.2_armv7l/scdoc-1.11.2-chromeos-armv7l.tar.zst',
      armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/scdoc/1.11.2_armv7l/scdoc-1.11.2-chromeos-armv7l.tar.zst',
        i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/scdoc/1.11.2_i686/scdoc-1.11.2-chromeos-i686.tar.zst',
      x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/scdoc/1.11.2_x86_64/scdoc-1.11.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
     aarch64: 'dcf77b6cae857f23bb42151fdc6c0d3155756c07d7710d286d9ef8e97414adf9',
      armv7l: 'dcf77b6cae857f23bb42151fdc6c0d3155756c07d7710d286d9ef8e97414adf9',
        i686: 'dad39f88f3c071f8d32f8f5e33e84c0aee44c7dab986b939a812b9743d1d1e03',
      x86_64: '1963cd6a64b25991b28207389a8a6d3299e07c4b4e2a00da7de432d93a3d1ae9'
  })

  depends_on 'glibc' # R

  def self.patch
    # Use correct gcc compiler
    system "sed -i '2 s:^:CC = #{CREW_TGT}-gcc\\n:' Makefile"

    # Build a dynamically linked binary
    system "sed -i 's:LDFLAGS+=-static:LDFLAGS+=:' Makefile" # Compile dynamically
  end

  def self.build
    system 'make'
  end

  def self.check
    system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
