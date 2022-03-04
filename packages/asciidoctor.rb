require 'package'

class Asciidoctor < Package
  description 'A fast text processor & publishing toolchain for converting AsciiDoc to HTML5, DocBook & more.'
  homepage 'https://asciidoctor.org/'
  version '2.0.17'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/asciidoctor/2.0.17_armv7l/asciidoctor-2.0.17-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/asciidoctor/2.0.17_armv7l/asciidoctor-2.0.17-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/asciidoctor/2.0.17_i686/asciidoctor-2.0.17-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/asciidoctor/2.0.17_x86_64/asciidoctor-2.0.17-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'b947ceb099358cca321dbdb483e058efd41391c729be866acc40f672b1b82910',
     armv7l: 'b947ceb099358cca321dbdb483e058efd41391c729be866acc40f672b1b82910',
       i686: '890a1d900911ad20b4e87808c38ed59d5a88b4bb6343abecca0cb31b85ef8f27',
     x86_64: '8f6581e50b2ccf4074488575f439caee9e83dcb1dbf24778e2e3ef0b271f1c55'
  })

  def self.install
    system "gem install --ignore-dependencies --no-user-install --verbose \
        -i #{CREW_DEST_DIR}#{Gem.default_dir} -n #{CREW_DEST_PREFIX}/bin \
        #{to_s.downcase} -v #{version}"
    system "install -Dm644 #{CREW_DEST_DIR}#{Gem.default_dir}/gems/#{to_s.downcase}-#{version}/man/#{to_s.downcase}.1 \
        #{CREW_DEST_MAN_PREFIX}/man1/#{to_s.downcase}.1"
    FileUtils.rm "#{CREW_DEST_DIR}#{Gem.default_dir}/cache/#{to_s.downcase}-#{version}.gem"
    FileUtils.rm_rf "#{CREW_DEST_DIR}#{Gem.default_dir}/gems/#{to_s.downcase}-#{version}/man"
  end
end
