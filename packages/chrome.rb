require 'package'

class Chrome < Package
  description 'Google Chrome is a fast, easy to use, and secure web browser.'
  homepage 'https://www.google.com/chrome'
  version '120.0.6099.62-1'
  license 'google-chrome'
  compatibility 'x86_64'
  source_url 'https://dl.google.com/linux/chrome/deb/pool/main/g/google-chrome-stable/google-chrome-stable_120.0.6099.62-1_amd64.deb'
  source_sha256 '6e0a762bb8e6399c540ba9393b381adde18e2229f7ac4f1df92232d99342f061'

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
