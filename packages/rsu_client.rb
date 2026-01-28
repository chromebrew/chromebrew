require 'package'

class Rsu_client < Package
  description 'RSU-Client is a RuneScape Client Launcher written for the now Legacy client and now OldSchool.'
  homepage 'https://github.com/rsu-client/rsu-client'
  version '4.3.8'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/rsu-client/rsu-client/archive/v4.3.8.tar.gz'
  source_sha256 'a84d27f2775ceef3bf0f715504ba41f3776c5374b61f9820993a26f350e4fa3d'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '740174a97f6f60b8fde6cc6458934ecb1605fa66d40c4ee04b095316b8fa4e7e',
     armv7l: '740174a97f6f60b8fde6cc6458934ecb1605fa66d40c4ee04b095316b8fa4e7e',
       i686: '17999feafa2539689e57454b9825d9f436baca894125383405f5c5e93421d70e',
     x86_64: '535a8a5339b57fe5929b6b1ff4fc40c8c93039ecf43006c2323c0d65502ed899'
  })

  depends_on 'fontconfig' # R
  depends_on 'freetype' # R
  depends_on 'harfbuzz' # R
  depends_on 'libx11' # R
  depends_on 'libxcb' # R
  depends_on 'libxrender' # R
  depends_on 'openjdk8'
  depends_on 'p7zip'
  depends_on 'pixman' # R
  depends_on 'sommelier' => :logical
  depends_on 'wxwidgets'
  depends_on 'xdg_utils'
  depends_on 'zlib' # R

  def self.patch
    Dir.chdir 'runescape' do
      system "for f in \$(grep -r /usr/bin .|egrep -v '^Binary'|egrep -o '^[^:]+');do
                sed -i 's,/usr/local,/usr,g' \${f}
              done"
      system "for f in \$(grep -r /usr/bin .|egrep -v '^Binary'|egrep -o '^[^:]+');do
                sed -i 's,/usr,#{CREW_PREFIX},g' \${f}
              done"
    end
  end

  def self.build
    system 'cpan -f -i Archive::Extract'
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share"
    FileUtils.cp_r 'runescape', "#{CREW_DEST_PREFIX}/share/"
    FileUtils.ln_s "#{CREW_PREFIX}/share/runescape/runescape", "#{CREW_DEST_PREFIX}/bin/runescape"
  end
end
