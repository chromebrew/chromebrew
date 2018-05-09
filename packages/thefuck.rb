require 'package'

class thefuck < Package
  description 'Magnificent app which corrects your previous console command.'
  homepage 'https://github.com/nvbn/thefuck'
  version '3.26'

  depends_on 'python3'

  def self.install
    system "python3 -m pip install thefuck"
    system "fuck && fuck"
  end
end
