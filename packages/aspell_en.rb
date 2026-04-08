require 'package'

class Aspell_en < Package
  description 'English Aspell Dictionary'
  homepage 'https://aspell.net'
  version '2026.02.25-0'
  license 'myspell-en_CA-KevinAtkinson, public-domain, Princeton, and Ispell'
  compatibility 'all'
  source_url 'https://ftp.gnu.org/gnu/aspell/dict/en/aspell6-en-2026.02.25-0.tar.bz2'
  source_sha256 '77a5cb437c45d1115f3b593802c20651d8c93803ed1073278dc1a1240016f10d'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0a61edf44cd24839e4d2e5c4733f7b62885e3a9d86506a93faf4c95c8f858b86',
     armv7l: '0a61edf44cd24839e4d2e5c4733f7b62885e3a9d86506a93faf4c95c8f858b86',
       i686: 'e7376b5493cc90788abbd684508fa11520ad34055ead2af34b8fc8ee035551bf',
     x86_64: '8abaadca000f3ac762674273e1df173a2c4f0d6451da2db8f4656f3e09fd4b70'
  })

  depends_on 'aspell' => :logical

  def self.build
    system "env CFLAGS='-flto=auto -ltinfo' CXXFLAGS='-flto=auto' \
        LDFLAGS='-flto=auto' ./configure"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
