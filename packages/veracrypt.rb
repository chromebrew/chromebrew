require 'buildsystems/autotools'

class Veracrypt < Autotools
  description 'VeraCrypt is a free open source disk encryption software for Windows, Mac OSX and Linux.'
  homepage 'https://www.veracrypt.fr/en/Home.html'
  version '1.26.29'
  license 'Apache 2.0 and TrueCrypt 3.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/veracrypt/VeraCrypt.git'
  git_hashtag "VeraCrypt_#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7f94d896fca02834f3cba32e13a62d28aed2dd1abc67a28edf1ce155c110527a',
     armv7l: '7f94d896fca02834f3cba32e13a62d28aed2dd1abc67a28edf1ce155c110527a',
     x86_64: '504ff9ceff8514b7e88a3373a241f1d649485e6488e675c209d9a4d42cee697a'
  })

  depends_on 'fuse2' => :executable
  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'pcsc_lite' => :executable
  depends_on 'wxwidgets31' => :executable
  depends_on 'yasm' => :build

  autotools_skip_configure
  autotools_build_relative_dir 'src'

  def self.install
    FileUtils.install 'src/Main/veracrypt', "#{CREW_DEST_PREFIX}/bin/veracrypt", mode: 0o755
  end
end
