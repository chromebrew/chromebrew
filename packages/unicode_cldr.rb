require 'package'

class Unicode_cldr < Package
  description 'Unicode Common Locale Data Repository'
  homepage 'http://cldr.unicode.org/'
  @_ver = '43.0'
  @_ver_prelastdot = @_ver.rpartition('.')[0]
  version @_ver
  license 'unicode'
  compatibility 'all'
  source_url "https://unicode.org/Public/cldr/#{@_ver_prelastdot}/cldr-common-#{@_ver}.zip"
  source_sha256 '7800dadb6a11e06ba1475f8c2830aa87e0749ed441c953d8deea60b4baeef592'

  no_compile_needed

  def self.install
    FileUtils.mkdir_p("#{CREW_DEST_PREFIX}/share/unicode/cldr/common")
    FileUtils.cp_r('common/.', "#{CREW_DEST_PREFIX}/share/unicode/cldr/common")
    FileUtils.chmod_R(0o755, "#{CREW_DEST_PREFIX}/share/unicode/cldr/common")
  end
end
