require 'package'

class Libmediainfo < Package
  description 'MediaInfo is a convenient unified display of the most relevant technical and tag data for video and audio files.'
  homepage 'http://mediaarea.net/en/MediaInfo'
  version '24.04'
  license 'BSD-2'
  compatibility 'all'
  source_url 'https://mediaarea.net/download/binary/libmediainfo0/24.04/MediaInfo_DLL_24.04_GNU_FromSource.tar.xz'
  source_sha256 'ad93d20aa87f5e45415a2e1b70725006d97d9ca560b84175056809be73a4469d'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b4465fc64fa432ffdd890dd8b4ebd048d84e806c75f30e215d3bd08aa045aaa2',
     armv7l: 'b4465fc64fa432ffdd890dd8b4ebd048d84e806c75f30e215d3bd08aa045aaa2',
       i686: '4e95604cafcdd336dbd11ec5e07c31661f55e1e2197331261f211cbb9b87046d',
     x86_64: 'b2daaf6c3077d6a3686ad912182174bc31f8eaec18cde8e6e9bf4453fadf49c5'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'zlibpkg' # R

  def self.patch
    # Fix /usr/bin/file: No such file or directory
    system 'filefix'
  end

  def self.build
    system "mold -run ./SO_Compile.sh #{CREW_OPTIONS}"
  end

  def self.install
    Dir.chdir 'MediaInfoLib/Project/GNU/Library' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
  end
end
