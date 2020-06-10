require 'package'

class Octane < Package
  description 'The JavaScript Benchmark Suite for the modern web https://developers.google.com/octane/.'
  homepage 'https://github.com/chromium/octane'
  version '2.0'
  compatibility 'all'
  source_url 'https://github.com/chromium/octane/archive/570ad1ccfe86e3eecba0636c8f932ac08edec517.tar.gz'
  source_sha256 'c355dd9a37df421826f3d8028d89e8c8b58faa12a49da88fa2641788f9482fe7'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/octane-2.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/octane-2.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/octane-2.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/octane-2.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c195233b1d220e0905a439e631c1eca73d23631ed20f896a1d6527e64ea2b78c',
     armv7l: 'c195233b1d220e0905a439e631c1eca73d23631ed20f896a1d6527e64ea2b78c',
       i686: 'c06f5505a461387d883eeb28c506d85e07acd008bce61e38b7226b4d894f9e88',
     x86_64: '4bf8e2f68b3cfb22b212b824c5239f3ca4f3cd36cddd8e9c79991359aead9139',
  })

  def self.install
    system "mkdir -p #{CREW_DEST_PREFIX}/share/octane"
    system "cp -r . #{CREW_DEST_PREFIX}/share/octane"
  end

  def self.postinstall
    puts
    puts "To perform a benchmark test, execute the following:".lightblue
    puts "ruby -run -e httpd #{CREW_PREFIX}/share/octane/ -p 8080".lightblue
    puts "Visit http://localhost:8080".lightblue
    puts "Click 'Start Octane 2.0'".lightblue
    puts
  end
end
