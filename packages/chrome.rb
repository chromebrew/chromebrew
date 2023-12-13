require 'package'

class Chrome < Package
  description 'Google Chrome is a fast, easy to use, and secure web browser.'
  homepage 'https://www.google.com/chrome'
  version '120.0.6099.109-1'
  license 'google-chrome'
  compatibility 'x86_64'
  source_url 'https://dl.google.com/linux/chrome/deb/pool/main/g/google-chrome-stable/google-chrome-stable_120.0.6099.109-1_amd64.deb'
  source_sha256 '49c149401f5f6357161ed14ef06a50f32b822da3b502fc8057995b9ea4ab3c2b'

  depends_on 'nspr'
  depends_on 'cairo'
  depends_on 'gtk3'
  depends_on 'expat'
  depends_on 'cras'

  no_compile_needed
  no_shrink

  def self.preflight
    if Gem::Version.new(LIBC_VERSION.to_s) < Gem::Version.new('2.29')
      puts "\nGoogle Chrome requires GLIBC 2.29 and above.".lightred
      abort "ChromeOS is currently running GLIBC #{LIBC_VERSION}.\n".lightred
    end
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"

    FileUtils.mv 'usr/share', CREW_DEST_PREFIX
    FileUtils.mv 'opt/google/chrome', "#{CREW_DEST_PREFIX}/share"

    FileUtils.ln_s '../share/chrome/google-chrome', "#{CREW_DEST_PREFIX}/bin/google-chrome-stable"
    FileUtils.ln_s '../share/chrome/google-chrome', "#{CREW_DEST_PREFIX}/bin/google-chrome"
  end

  def self.postinstall
    puts "\nType 'google-chrome' to get started.\n".lightblue
  end
end
