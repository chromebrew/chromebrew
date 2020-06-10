require 'package'

class Cros_resize < Package
  description 'A partition resizing tool for Chrome OS devices.'
  homepage 'https://github.com/ethanmad/chromeos-resize'
  version '6b01b7'
  compatibility 'all'
  source_url 'https://raw.githubusercontent.com/ethanmad/chromeos-resize/6b01b71f649dbf77b2e6ac932e8ad868e8272250/cros-resize.sh'
  source_sha256 '747ef80f29a94500304f23595c5edfa46edd4b4fa5a40d399b474984004e9ffe'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.install
    system 'wget https://raw.githubusercontent.com/ethanmad/chromeos-resize/6b01b71f649dbf77b2e6ac932e8ad868e8272250/cros-resize.sh'
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('cros-resize.sh') ) == '747ef80f29a94500304f23595c5edfa46edd4b4fa5a40d399b474984004e9ffe'
    system "install -Dm755 cros-resize.sh #{CREW_DEST_PREFIX}/bin/cros-resize"
  end
end
