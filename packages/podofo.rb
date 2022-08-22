require 'package'

class Podofo < Package
  description 'A PDF parsing, modification and creation library.'
  homepage 'https://sourceforge.net/projects/podofo/'
  version '0.9.7'
  license 'LGPLv2'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/project/podofo/podofo/0.9.7/podofo-0.9.7.tar.gz'
  source_sha256 '7cf2e716daaef89647c54ffcd08940492fd40c385ef040ce7529396bfadc1eb8'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/podofo/0.9.7_armv7l/podofo-0.9.7-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/podofo/0.9.7_armv7l/podofo-0.9.7-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/podofo/0.9.7_i686/podofo-0.9.7-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/podofo/0.9.7_x86_64/podofo-0.9.7-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'd0a5ea8bb5e465d45cc5ab468c4bfef62f450c951dc703871f5ea6a60b81ae8d',
     armv7l: 'd0a5ea8bb5e465d45cc5ab468c4bfef62f450c951dc703871f5ea6a60b81ae8d',
       i686: 'ca6bcca682a0296a9e4f80541fe9ac26f03b17b58c75a60124f75afc8bb9beab',
     x86_64: '32c13806a35388042a63e8a641ebdf7e0cc3ce4fd46cb98b79995f06eca743a3'
  })

  depends_on 'lua'
  depends_on 'libidn2'
  depends_on 'libpng'
  depends_on 'libtiff'

  def self.build
    Dir.mkdir 'build'
    Dir.chdir 'build' do
      system "cmake -G 'Unix Makefiles' -DWANT_LIB64=ON #{CREW_CMAKE_OPTIONS} \
               -DLIBIDN_LIBRARY_RELEASE=#{CREW_LIB_PREFIX}/libidn2.so .."
      system 'make'
    end
  end

  def self.install
    Dir.chdir 'build' do
      system "DESTDIR=#{CREW_DEST_DIR} make install"
    end
  end
end
