require 'package'

class Unicode_cldr < Package
  description 'Unicode Common Locale Data Repository'
  homepage 'http://cldr.unicode.org/'
  @_ver = '38.0'
  @_ver_prelastdot = @_ver.rpartition('.')[0]
  version @_ver
  compatibility 'all'
  source_url "https://unicode.org/Public/cldr/#{@_ver_prelastdot}/cldr-common-#{@_ver}.zip"
  source_sha256 '19689be1352eafc2f034f065d4f70fe55136aed381c2d1e506d9ed49333ee9f8'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/unicode_cldr-38.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/unicode_cldr-38.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/unicode_cldr-38.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/unicode_cldr-38.0-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'fe2d83d790608a23da19f1bbd5dd6b155e4d180b68ffe15deea1b23624efd8d0',
     armv7l: 'fe2d83d790608a23da19f1bbd5dd6b155e4d180b68ffe15deea1b23624efd8d0',
       i686: 'b295112aa7398afb08f3f7f3d95d1f5e9bb675f96513187e91e2986d72cf526a',
     x86_64: '2fbdc1ae0a2b56f81fc4e84cd08ea790404369bceaee7428c60daa9a2986a60f'
  })

  def self.install
    FileUtils.mkdir_p("#{CREW_DEST_PREFIX}/share/unicode/cldr/common")
    FileUtils.cp_r('common/.', "#{CREW_DEST_PREFIX}/share/unicode/cldr/common")
    FileUtils.chmod_R(0o755, "#{CREW_DEST_PREFIX}/share/unicode/cldr/common")
  end
end
