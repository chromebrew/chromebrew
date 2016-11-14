require 'package'

class Readline < Package
  version '6.2'

  # arm has 6.3 readline library in system, so leave it as is
  binary_url({
    armv7l: "https://dl.dropboxusercontent.com/s/kut6emhlda9pbc9/dummy-1.0.0-chromeos-armv7l.tar.gz",
    x86_64: "https://dl.dropboxusercontent.com/s/v8xva6e4u3tvkaw/readline-6.2-chromeos-x86_64.tar.gz?token_hash=AAHOv1kLiv7xzDkYEZCSB_3ShK0n_7B4m2dNGHPnn2fZIg&dl=1"
  })
  binary_sha1({
    armv7l: "049db60338a74d798e72afabe05097f3a4c4f7cd",
    x86_64: '621c2538b452be33cca507110ccfd4144c61edd2'
  })
  
  depends_on 'buildessential' #until binary for i686 provided

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
