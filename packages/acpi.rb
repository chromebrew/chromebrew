require 'buildsystems/autotools'

class Acpi < Autotools
  description 'Attempts to replicate the functionality of the \'old\' apm command on ACPI systems, including battery and thermal information.'
  homepage 'https://sourceforge.net/projects/acpiclient/'
  version '1.8'
  license 'GPL-2'
  compatibility 'all'
  source_url "https://downloads.sourceforge.net/project/acpiclient/acpiclient/#{version}/acpi-#{version}.tar.gz"
  source_sha256 'ed61d20400c4fd3965dde9b49ab3ac74da02f8eca1a55454f7a1ac3fa1fd5c31'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '99eb587850a3cbaa8029fb4a6562013d7e9b2e25aa83952c57f7685f06b7f7ff',
     armv7l: '99eb587850a3cbaa8029fb4a6562013d7e9b2e25aa83952c57f7685f06b7f7ff',
       i686: 'fc511f646db0b0ed8f553dae69a3176bb48ddf30f434faed31be8def9078b13b',
     x86_64: '18af9268c928bf8a50711cdc8dee48c8d6271de65a5c5a963eb616acba7255c0'
  })

  depends_on 'glibc' # R
end
