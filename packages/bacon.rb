require 'buildsystems/autotools'

class Bacon < Autotools
  description 'BaCon is a free BASIC to C translator for Unix-based systems.'
  homepage 'https://chiselapp.com/user/bacon/repository/bacon/home'
  version '5.0.3'
  license 'MIT'
  compatibility 'all'
  source_url "https://www.basic-converter.org/stable/bacon-#{version}.tar.gz"
  source_sha256 '17b7ca78cd9ac019b42db517df47038b9036c269fe76bb6ff07ea1c0c8038918'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e4060f1682208b403f2e9a2da4f31d3df8b16b8035c21fa437786167dac94715',
     armv7l: 'e4060f1682208b403f2e9a2da4f31d3df8b16b8035c21fa437786167dac94715',
       i686: '783e565c4f5068bf9e71bab02e55439d95572f45612a98ee818ade6975ea642b',
     x86_64: 'd483716bd64c47cd54e3fff09b78308db0736125c9b1d031a7d969cc026a6f9b'
  })

  depends_on 'glibc' # R

  def self.patch
    system 'sed -i "s,/usr/share,\$\(DATADIR\)," Makefile.in'
  end

  autotools_configure_options '--disable-gui'
end
