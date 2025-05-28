require 'buildsystems/autotools'

class Bacon < Autotools
  description 'BaCon is a free BASIC to C translator for Unix-based systems.'
  homepage 'https://chiselapp.com/user/bacon/repository/bacon/home'
  version '5.0'
  license 'MIT'
  compatibility 'all'
  source_url "https://www.basic-converter.org/stable/bacon-#{version}.tar.gz"
  source_sha256 '04f76e0792913ee7b4266493d3748813cab59450a06db9fa9eea240c9bae8a6b'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f5db8a5434ecc652329d3d899f50e7acdf99645f66fd6e6749a9aec50445f52c',
     armv7l: 'f5db8a5434ecc652329d3d899f50e7acdf99645f66fd6e6749a9aec50445f52c',
       i686: '201c5b886ba06bad7eb0d770a819a6f71f07a6091137f8fb1cc0d63797d5c970',
     x86_64: 'ddb485cbbc31ec7aa2fd3f4f6faf1fd5353cdf0951a5174bfbf24d2857a96b0c'
  })

  def self.patch
    system 'sed -i "s,/usr/share,\$\(DATADIR\)," Makefile.in'
  end

  autotools_configure_options '--disable-gui'
end
