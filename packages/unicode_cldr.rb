require 'package'

class Unicode_cldr < Package
  description 'Unicode Common Locale Data Repository'
  homepage 'http://cldr.unicode.org/'
  version '43.0'
  license 'unicode'
  compatibility 'all'
  source_url "https://unicode.org/Public/cldr/#{version.rpartition('.')[0]}/cldr-common-#{version}.zip"
  source_sha256 '7800dadb6a11e06ba1475f8c2830aa87e0749ed441c953d8deea60b4baeef592'

  no_compile_needed

  def self.install
    FileUtils.mkdir_p("#{CREW_DEST_PREFIX}/share/unicode/cldr/common")
    FileUtils.cp_r('common/.', "#{CREW_DEST_PREFIX}/share/unicode/cldr/common")
    FileUtils.chmod_R(0o755, "#{CREW_DEST_PREFIX}/share/unicode/cldr/common")
  end
end
