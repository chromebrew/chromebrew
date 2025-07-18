require 'package'

class Docbook2x < Package
  description 'docbook2X is a software package that converts DocBook documents into the traditional Unix man page format and the GNU Texinfo format.'
  homepage 'https://docbook2x.sourceforge.net/'
  version '0.8.8-1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/project/docbook2x/docbook2x/0.8.8/docbook2X-0.8.8.tar.gz'
  source_sha256 '4077757d367a9d1b1427e8d5dfc3c49d993e90deabc6df23d05cfe9cd2fcdc45'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '17f43a04fd80fb126cd8c7fd62163897be3edb24ed82026a1109fd614c52a585',
     armv7l: '17f43a04fd80fb126cd8c7fd62163897be3edb24ed82026a1109fd614c52a585',
       i686: '43dfe469d361f695e655035bc30e4e92273b43e6f5b0ec8ccff872815810dc90',
     x86_64: 'ceaba3863b07df670a310e6e54e2b9469bddd43f824a6e455811ee244cceb72f'
  })

  depends_on 'glibc' # R
  depends_on 'libxslt' # L
  depends_on 'perl_xml_sax' # R

  def self.build
    system "./configure #{CREW_CONFIGURE_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    system "sed -i 's,http://docbook2x.sf.net/latest,#{CREW_PREFIX}/share/docbook2X,g' \
      #{CREW_DEST_PREFIX}/bin/db2x_xsltproc"
    Dir["#{CREW_DEST_PREFIX}/bin/*"].each do |bin|
      system "sed -i 's,${prefix},#{CREW_PREFIX},g' \
        #{bin}"
    end
  end
end
