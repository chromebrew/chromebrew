require 'buildsystems/autotools'

class Gperf < Autotools
  description 'GNU gperf is a perfect hash function generator.'
  homepage 'https://www.gnu.org/software/gperf/'
  version '3.3'
  license 'GPL-2'
  compatibility 'all'
  source_url "https://ftp.gnu.org/pub/gnu/gperf/gperf-#{version}.tar.gz"
  source_sha256 'fd87e0aba7e43ae054837afd6cd4db03a3f2693deb3619085e6ed9d8d9604ad8'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9f913442cd16d2c1612ac95ecdfc7bae329b40e9bb753d2bf973a2b4b64bb27f',
     armv7l: '9f913442cd16d2c1612ac95ecdfc7bae329b40e9bb753d2bf973a2b4b64bb27f',
       i686: '0591d0d275bc2430867996f859bb0fbca9118021ae51fd7fb7e668abaf43d040',
     x86_64: '42b377dbb7b1e42dd6762b0f50d098f7a1d0298f5d557300d6e16fd03aa070cf'
  })

  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'wget2' => :build

  def self.build
    system "./configure --prefix=#{CREW_PREFIX}"
    system 'make'
  end
end
