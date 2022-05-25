require 'package'

class Swig1 < Package
  description 'Simplified Wrapper and Interface Generator'
  homepage 'http://www.swig.org'
  version '1.3.40'
  license 'GPL-3, BSD and BSD-2'
  compatibility 'all'
  source_url 'https://prdownloads.sourceforge.net/project/swig/swig/swig-1.3.40/swig-1.3.40.tar.gz'
  source_sha256 '1945b3693bcda6777bd05fef1015a0ad1a4604cde4a4a0a368b61ccfd143ac09'
  binary_compression 'tar.xz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/swig1/1.3.40_armv7l/swig1-1.3.40-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/swig1/1.3.40_armv7l/swig1-1.3.40-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/swig1/1.3.40_i686/swig1-1.3.40-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/swig1/1.3.40_x86_64/swig1-1.3.40-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'bff62d68c6c6ab5c57ffb994153b506711cc8eca0b50a29c80736617d2baae68',
     armv7l: 'bff62d68c6c6ab5c57ffb994153b506711cc8eca0b50a29c80736617d2baae68',
       i686: '3d878e0d24a378f6deb27cb2760363d82a0c81273ccd12091d863c6080588225',
     x86_64: '7c2e070c4325546cd74ff4219a5737b020f43c23f3bcaf49b302551962361215'
  })

  depends_on 'pcre'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
