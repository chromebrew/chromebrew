require 'package'

class Sublime_text < Package
  description 'A sophisticated text editor for code, markup and prose.'
  homepage 'https://www.sublimetext.com/'
  version 'Build 4126'
  license 'Copyright Sublime HQ Pty Ltd' # Shareware for evaluation purposes only.  Source code is not available.
  compatibility 'x86_64'
  source_url 'https://download.sublimetext.com/sublime_text_build_4126_x64.tar.xz'
  source_sha256 '5c64e534cce0032e54d3c7028e8d6b3bdef28f3fd28a26244a360a2ce75450a1'

  depends_on 'gtk2'
  depends_on 'sommelier'

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
