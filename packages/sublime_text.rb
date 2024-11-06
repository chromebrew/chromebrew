require 'package'

class Sublime_text < Package
  description 'A sophisticated text editor for code, markup and prose.'
  homepage 'https://www.sublimetext.com/'
  version 'Build 4169'
  license 'Copyright Sublime HQ Pty Ltd' # Shareware for evaluation purposes only.  Source code is not available.
  compatibility 'x86_64'
  source_url "https://download.sublimetext.com/sublime_text_build_#{version.split.last}_x64.tar.xz"
  source_sha256 '8e4f70282d1081f8621c36147270e1b26809b013ce5260a4caf41e239e08249e'

  depends_on 'gtk2'
  depends_on 'sommelier'

  no_compile_needed

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/sublime_text"
    FileUtils.cp_r '.', "#{CREW_DEST_PREFIX}/share/sublime_text/"
    FileUtils.ln_s "#{CREW_PREFIX}/share/sublime_text/sublime_text", "#{CREW_DEST_PREFIX}/bin/sublime_text"
  end

  def self.postinstall
    ExitMessage.add "\nType 'sublime_text' to get started.\n".lightblue
  end
end
