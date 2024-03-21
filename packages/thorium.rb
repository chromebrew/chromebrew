require 'package'

class Thorium < Package
  description 'The fastest browser on Earth.'
  homepage 'https://thorium.rocks/'
  version '117.0.5938.157'
  license 'BSD-3 Clause'
  compatibility 'x86_64'
  min_glibc '2.29'
  source_url "https://github.com/Alex313031/thorium/releases/download/M#{version}/Thorium_Browser_#{version}_x64.AppImage"
  source_sha256 '7657c29416f04a4420e2cb4a65d4a0360dc416c5a4b28236d5cc511b948cace3'

  depends_on 'ffmpeg'
  depends_on 'gtk3'

  no_compile_needed
  no_shrink

  def self.build
    @thoriumenv = <<~EOF
      # Thorium environment settings
      GDK_BACKEND=x11
      LD_LIBRARY_PATH=#{CREW_PREFIX}/share/thorium/usr/lib:$LD_LIBRARY_PATH
    EOF
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/bash.d"
    FileUtils.cp_r 'usr/share', CREW_DEST_PREFIX
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/thorium"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/applications"
    FileUtils.mv 'thorium-browser.desktop', "#{CREW_DEST_PREFIX}/share/applications"
    FileUtils.ln_s "#{CREW_PREFIX}/share/thorium/usr/bin/thorium", "#{CREW_DEST_PREFIX}/bin/thorium"
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/thorium"
    File.write "#{CREW_DEST_PREFIX}/etc/bash.d/10-thorium", @thoriumenv
  end

  def self.postinstall
    puts "\nType 'thorium' to get started.\n".lightblue
  end
end
