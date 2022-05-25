require 'package'

class Libmng < Package
  description 'A PNG-like Image Format Supporting Multiple Images, Animation and Transparent JPEG'
  homepage 'http://www.libpng.org/pub/mng/'
  version '2.0.3-1'
  license 'libmng'
  compatibility 'all'
  source_url 'https://prdownloads.sourceforge.net/project/libmng/libmng-devel/2.0.3/libmng-2.0.3.tar.xz'
  source_sha256 '4a462fdd48d4bc82c1d7a21106c8a18b62f8cc0042454323058e6da0dbb57dd3'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libmng/2.0.3-1_armv7l/libmng-2.0.3-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libmng/2.0.3-1_armv7l/libmng-2.0.3-1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libmng/2.0.3-1_i686/libmng-2.0.3-1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libmng/2.0.3-1_x86_64/libmng-2.0.3-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '7ddc6eaaf8264668c0ec04ffe02d0a3f24139a3e657b9498147df68458f69099',
     armv7l: '7ddc6eaaf8264668c0ec04ffe02d0a3f24139a3e657b9498147df68458f69099',
       i686: '725351f8123d95a88ba23b8c0f26c4e72f0e207a992c6489717570bfbeba6e27',
     x86_64: '5b737b4b4ecd5374111b2478110f830a88b460104f1e87b9785f975f0a638eae'
  })

  depends_on 'lcms'
  depends_on 'libjpeg'
  depends_on 'glibc' # R
  depends_on 'zlibpkg' # R

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.postinstall
    return unless File.exist?("#{CREW_PREFIX}/bin/gdk-pixbuf-query-loaders")

    system 'gdk-pixbuf-query-loaders',
           '--update-cache'
  end
end
