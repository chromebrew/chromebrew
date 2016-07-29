require 'package'

class Readline < Package
  version '6.2'

  binary_url({
    x86_64: "https://dl.dropboxusercontent.com/s/v8xva6e4u3tvkaw/readline-6.2-chromeos-x86_64.tar.gz?token_hash=AAHOv1kLiv7xzDkYEZCSB_3ShK0n_7B4m2dNGHPnn2fZIg&dl=1"
  })
  binary_sha1({
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
