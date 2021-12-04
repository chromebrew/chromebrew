require 'package'

class Asciidoctor < Package
  description 'A fast text processor & publishing toolchain for converting AsciiDoc to HTML5, DocBook & more.'
  homepage 'https://asciidoctor.org/'
  version '2.0.16'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/asciidoctor/2.0.16_armv7l/asciidoctor-2.0.16-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/asciidoctor/2.0.16_armv7l/asciidoctor-2.0.16-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/asciidoctor/2.0.16_i686/asciidoctor-2.0.16-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/asciidoctor/2.0.16_x86_64/asciidoctor-2.0.16-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '523871f0cc68641c49cb2731f0b02c75c7968ed94020f8088a171b8279461601',
     armv7l: '523871f0cc68641c49cb2731f0b02c75c7968ed94020f8088a171b8279461601',
       i686: 'a6429f928ec85357e1f18a6ededb251ca27b9a73e87d3ae92f5622ece769b83b',
     x86_64: '20289399b9d9ec21db5fab0a21e76456f4b3349e05a7e5a7c60f65cb19931635'
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
