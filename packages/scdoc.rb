require 'buildsystems/autotools'

class Scdoc < Autotools
  description 'A simple man page generator for POSIX systems written in C99'
  homepage 'https://git.sr.ht/~sircmpwn/scdoc/'
  version '1.11.5'
  license 'MIT'
  compatibility 'all'
  source_url "https://git.sr.ht/~sircmpwn/scdoc/archive/#{version}.tar.gz"
  source_sha256 '98780bbdf16c1bce89ef3a8c0f537ac6e4ea77087b609e7698857614488a2a62'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f52cb4acc19f20ee0480b4c64f41285b00043a5fa2f6b56afe77a7e9606aae2a',
     armv7l: 'f52cb4acc19f20ee0480b4c64f41285b00043a5fa2f6b56afe77a7e9606aae2a',
       i686: '78e8a4b9d53505e7d5e6f7e9008d79a7934487f32bb058e8dca70e0464aade04',
     x86_64: 'c1a45e11d99f9aee48cd2fa832e5e6dfeb1dc36aec7389eef9f93a693f4985ae'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable

  autotools_skip_configure

  def self.patch
    # Build a dynamically linked binary
    system "sed -i 's:LDFLAGS+=-static:LDFLAGS+=:' Makefile"
  end
end
