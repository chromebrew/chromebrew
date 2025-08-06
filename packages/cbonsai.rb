require 'package'

class Cbonsai < Package
  description 'A CLI bonsai tree generator, grow bonsai trees in our terminal'
  homepage 'https://gitlab.com/jallbrit/cbonsai'
  version '1.4.2'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://gitlab.com/jallbrit/cbonsai.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e93c15b21338ec9781864c281923491beba65020914b8aace6b05686bfa36169',
     armv7l: 'e93c15b21338ec9781864c281923491beba65020914b8aace6b05686bfa36169',
       i686: '0e8ae960704b8b44d37277bf51b24182dcdc646c5aeaa40ea763a67a886a7763',
     x86_64: 'efb7685bc4e771abccef7f9ab6f124d7ec938c94b242f17412e85d0e329497ae'
  })

  depends_on 'glibc' # R
  depends_on 'ncurses' # R
  depends_on 'scdoc' => :build

  def self.build
    system 'make', "PREFIX=#{CREW_PREFIX}"
  end

  def self.install
    system 'make', "PREFIX=#{CREW_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
