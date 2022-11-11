require 'package'

class Sublime_text < Package
  description 'A sophisticated text editor for code, markup and prose.'
  homepage 'https://www.sublimetext.com/'
  version 'Build 4143'
  license 'Copyright Sublime HQ Pty Ltd' # Shareware for evaluation purposes only.  Source code is not available.
  compatibility 'x86_64'
  source_url 'https://download.sublimetext.com/sublime_text_build_4143_x64.tar.xz'
  source_sha256 '7de862c38d19367414117110328dded754ac709fed54c8cc5cb0737c894c073c'

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
    puts "\nCongratulations! You have installed Sublime Text on Chrome OS!".lightgreen
    puts "Now, please run 'sublime_text' to get started.\n".lightgreen
  end
end
