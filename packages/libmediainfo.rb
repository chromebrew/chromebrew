require 'package'

class Libmediainfo < Package
  description 'MediaInfo is a convenient unified display of the most relevant technical and tag data for video and audio files.'
  homepage 'https://mediaarea.net/en/MediaInfo'
  version '25.04'
  license 'BSD-2'
  compatibility 'all'
  source_url "https://mediaarea.net/download/binary/libmediainfo0/#{version}/MediaInfo_DLL_#{version}_GNU_FromSource.tar.xz"
  source_sha256 '958530caacf1a897d48587d59177dc7d4d54cfd0cc4ccb922432d907c94af1d4'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '028a158e4ec285018b9e7e285ef4f4e67273890edb3455fa9c8f06b0c82a284b',
     armv7l: '028a158e4ec285018b9e7e285ef4f4e67273890edb3455fa9c8f06b0c82a284b',
       i686: '42dfcbdba287f36429d57fe344bf0c9bb5f2b71bc14a097b9d8a8723f2992229',
     x86_64: '20b41b5118591f29f0567b1d9bdacfc7cd87f5c634e243fcd73183dd7e09ee51'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'zlib' # R

  def self.patch
    # Fix /usr/bin/file: No such file or directory
    system 'filefix'
  end

  def self.build
    system "./SO_Compile.sh #{CREW_CONFIGURE_OPTIONS}"
  end

  def self.install
    Dir.chdir 'MediaInfoLib/Project/GNU/Library' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
  end
end
