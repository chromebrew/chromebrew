require 'package'

class Ttf_hanazono < Package
  description 'A free Japanese kanji font, which contains about 78,685 characters (and 2 SPACEs) defined in ISO/IEC 10646 standard / the Unicode standard.'
  homepage 'http://fonts.jp/hanazono' # From ArchLinux PKGBUILD, could not actually resolve site
  @_ver = 20170904
  @_revision = 68253
  version "#{@_ver}-r#{@_revision}"
  license 'OFL and custom'
  compatibility 'all'
  source_url "http://sourceforge.jp/frs/redir.php?m=jaist&f=%2Fhanazono-font%2F#{@_revision}%2Fhanazono-#{@_ver}.zip"
  source_sha256 '571cd4a09ae7da0c642d640fc2442c050aa450ebb0587a95cdd097d41a9c9572'

  no_compile_needed

  def self.install
    @_ttf_fonts_dir = "#{CREW_DEST_PREFIX}/share/fonts/TTF"
    FileUtils.mkdir_p @_ttf_fonts_dir
    %w[HanaMinA HanaMinB].each fontfile do
      FileUtils.install 'HanaMinA.ttf' "#{@_ttf_fonts_dir}/#{fontfile}.ttf"
    end
  end
end
