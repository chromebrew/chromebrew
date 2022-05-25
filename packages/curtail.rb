require 'package'

class Curtail < Package
  description 'Curtail (previously ImCompressor) is an useful image compressor, supporting PNG, JPEG and WEBP file types.'
  homepage 'https://github.com/Huluti/Curtail'
  version '1.3.0'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/Huluti/Curtail/archive/1.3.0.tar.gz'
  source_sha256 '56859211b1b147aec677a00295e524b6beabcdf415938db1bd8ca4dae79409cf'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/curtail/1.3.0_armv7l/curtail-1.3.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/curtail/1.3.0_armv7l/curtail-1.3.0-chromeos-armv7l.tar.zst',
      i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/curtail/1.3.0_i686/curtail-1.3.0-chromeos-i686.tar.zst',
    x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/curtail/1.3.0_x86_64/curtail-1.3.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '6d5947e652598d3e7aac80193bbb5a51e3b4bd2678ed8ed1f459e63b68c74da0',
     armv7l: '6d5947e652598d3e7aac80193bbb5a51e3b4bd2678ed8ed1f459e63b68c74da0',
      i686: '2643affd0cc34358f1b3540f7701313e699401975d242f5128b856b742cd7699',
    x86_64: '8fab707529ff0e2d8db29045a9e05a91a30d8b66d738dde84a5ca12145a0d6fa'
  })

  depends_on 'gtk3'
  depends_on 'optipng'
  depends_on 'pngquant'
  depends_on 'jpegoptim'
  depends_on 'libwebp'

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} build"
    system 'ninja -C build'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C build install"
  end
end
