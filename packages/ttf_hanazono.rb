require 'package'

class Ttf_hanazono < Package
  description 'A free Japanese kanji font, which contains about 78,685 characters (and 2 SPACEs) defined in ISO/IEC 10646 standard / the Unicode standard.'
  homepage 'https://osdn.net/projects/hanazono-font/'
  version '20170904'
  license 'OFL and custom'
  compatibility 'all'
  source_url "https://acc.dl.osdn.jp/hanazono-font/68253/hanazono-#{version}.zip"
  source_sha256 '571cd4a09ae7da0c642d640fc2442c050aa450ebb0587a95cdd097d41a9c9572'

  no_compile_needed

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/fonts/TTF"
    %w[HanaMinA.ttf HanaMinB.ttf].each do |fontfile|
      FileUtils.install fontfile, "#{CREW_DEST_PREFIX}/share/fonts/TTF"
    end
  end
end
