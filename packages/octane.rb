require 'package'

class Octane < Package
  description 'The JavaScript Benchmark Suite for the modern web https://developers.google.com/octane/.'
  homepage 'https://github.com/chromium/octane'
  version '2.0'
  source_url 'https://github.com/chromium/octane/archive/570ad1ccfe86e3eecba0636c8f932ac08edec517.tar.gz'
  source_sha256 'c355dd9a37df421826f3d8028d89e8c8b58faa12a49da88fa2641788f9482fe7'

  binary_url ({
  })
  binary_sha256 ({
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
